package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.OrderDisplay;
import model.Supplier;
import dao.SupplierDAO;

@WebServlet(name = "ViewOrderListServlet", urlPatterns = {"/order_list"})
public class ViewOrderListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String supplierFilter = request.getParameter("supplier"); // có thể null

        OrderDAO dao = new OrderDAO();
        SupplierDAO sdao = new SupplierDAO(); // thêm dòng này
        List<Supplier> supplierList = sdao.getAllSuppliers(); // và dòng này

        List<OrderDisplay> allOrders = dao.getOrderDisplayList(supplierFilter);
        int totalRecords = allOrders.size();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);
        List<OrderDisplay> pageOrders = allOrders.subList(start, end);

        request.setAttribute("orderDisplayList", pageOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("supplierList", supplierList);
        request.setAttribute("selectedSupplier", supplierFilter); // truyền vào để giữ giá trị sau khi chọn

        request.getRequestDispatcher("order_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "View list of grouped orders";
    }
}
