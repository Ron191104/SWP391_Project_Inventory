package controller;

import dao.CategoryAdminDAO;
import model.Category;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class CategoryManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        CategoryAdminDAO dao = new CategoryAdminDAO();
        List<Category> categories = dao.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/category_management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");
        CategoryAdminDAO dao = new CategoryAdminDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("category_name");
            if (name != null && !name.trim().isEmpty()) {
                dao.addCategory(name.trim());
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("category_id"));
            String name = request.getParameter("category_name");
            dao.updateCategory(id, name.trim());
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("category_id"));
            dao.deleteCategory(id);
        }
        response.sendRedirect("categories");
    }
}