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
        List<SupplierAdmin> suppliers = dao.getAllSuppliers(); // lọc status = 1 trong DAO
        request.setAttribute("suppliers", suppliers);
        request.getRequestDispatcher("/supplier_management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        SupplierAdminDAO dao = new SupplierAdminDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("supplier_name").trim();
            String phone = request.getParameter("phone").trim();
            String email = request.getParameter("email").trim();
            String address = request.getParameter("address").trim();

            if (name.isEmpty()) {
                request.setAttribute("error", "Tên nhà cung cấp không được để trống.");
            } else if (dao.isSupplierNameExists(name, null)) {
                request.setAttribute("error", "Tên nhà cung cấp đã tồn tại.");
            } else {
                dao.addSupplier(name, phone, email, address);
                response.sendRedirect("suppliers");
                return;
            }
        }

        else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("supplier_id"));
            String name = request.getParameter("supplier_name").trim();
            String phone = request.getParameter("phone").trim();
            String email = request.getParameter("email").trim();
            String address = request.getParameter("address").trim();

            if (name.isEmpty()) {
                request.setAttribute("error", "Tên nhà cung cấp không được để trống.");
            } else if (dao.isSupplierNameExists(name, id)) {
                request.setAttribute("error", "Tên nhà cung cấp đã tồn tại.");
            } else {
                dao.updateSupplier(id, name, phone, email, address);
                response.sendRedirect("suppliers");
                return;
            }
        }

        else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("supplier_id"));
            dao.softDeleteSupplier(id);
            response.sendRedirect("suppliers");
            return;
        }

        else if ("restore".equals(action)) {
            int id = Integer.parseInt(request.getParameter("supplier_id"));
            dao.restoreSupplier(id);
            response.sendRedirect("suppliers");
            return;
        }

        // Nếu có lỗi thì load lại danh sách và forward
        List<SupplierAdmin> suppliers = dao.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);
        request.getRequestDispatcher("/supplier_management.jsp").forward(request, response);
    }
}
