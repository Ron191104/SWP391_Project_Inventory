package controller;

import dao.SupplierDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Supplier;

@WebServlet("/supplier_login")
public class SupplierLoginServlet extends HttpServlet {

    private SupplierDAO supplierDAO = new SupplierDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Load danh sách supplier để hiển thị trong trang login
        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        request.setAttribute("supplierList", suppliers);

        // Forward đến trang login
        request.getRequestDispatcher("supplier_login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            Supplier supplier = supplierDAO.getSupplierById(supplierId);

            if (supplier != null) {
                HttpSession session = request.getSession();
                session.setAttribute("supplier", supplier);
                response.sendRedirect("supplier_dashboard");
            } else {
                request.setAttribute("error", "ID không tồn tại");
                doGet(request, response); // Hiển thị lại danh sách + lỗi
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ");
            doGet(request, response);
        }
    }
}
