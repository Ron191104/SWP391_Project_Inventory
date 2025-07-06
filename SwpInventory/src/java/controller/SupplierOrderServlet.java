package controller;

import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order;
import model.Supplier;

@WebServlet("/supplier_order")
public class SupplierOrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Supplier supplier = (Supplier) session.getAttribute("supplier");

        if (supplier == null) {
            response.sendRedirect("supplier_login.jsp");
            return;
        }

        int supplierId = supplier.getSupplier_id();
        String statusParam = request.getParameter("status");
        List<Order> orderList;

        if (statusParam != null && !statusParam.isEmpty()) {
            try {
                int status = Integer.parseInt(statusParam);
                orderList = orderDAO.getOrdersBySupplierIdAndStatus(supplierId, status);
            } catch (NumberFormatException e) {
                orderList = orderDAO.getOrdersBySupplierId(supplierId);
            }
        } else {
            orderList = orderDAO.getOrdersBySupplierId(supplierId);
        }

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("supplier_order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // approve/reject
        String orderIdStr = request.getParameter("orderId");

        if (action != null && orderIdStr != null) {
            int orderId = Integer.parseInt(orderIdStr);
            int status = 0;
            if ("approve".equals(action)) {
                status = 1;
            } else if ("reject".equals(action)) {
                status = 2;
            }

            boolean success = orderDAO.updateOrderStatus(orderId, status);

            if (success) {
                System.out.println("✅ Đã cập nhật trạng thái đơn hàng " + orderId + " thành " + status);
            } else {
                System.out.println("❌ Lỗi cập nhật đơn hàng " + orderId);
            }
        }

        response.sendRedirect("supplier_order");
    }
}
