package controller;

import dao.SupplierAdminDAO;
import model.SupplierAdmin;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/suppliers")
public class SupplierManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        SupplierAdminDAO dao = new SupplierAdminDAO();
        List<SupplierAdmin> suppliers = dao.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);
        request.getRequestDispatcher("/supplier_management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");
        SupplierAdminDAO dao = new SupplierAdminDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("supplier_name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            dao.addSupplier(name, phone, email, address);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("supplier_id"));
            String name = request.getParameter("supplier_name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            dao.updateSupplier(id, name, phone, email, address);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("supplier_id"));
            dao.deleteSupplier(id);
        }
        response.sendRedirect("suppliers");
    }
}