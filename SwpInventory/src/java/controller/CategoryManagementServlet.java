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
            String name = request.getParameter("category_name").trim();
            if (name.isEmpty()) {
                request.setAttribute("error", "Tên danh mục không được để trống.");
            } else if (dao.isCategoryNameExists(name, null)) {
                request.setAttribute("error", "Tên danh mục đã tồn tại.");
            } else {
                boolean success = dao.addCategory(name);
                if (success) {
                    response.sendRedirect("categories");
                    return;
                } else {
                    request.setAttribute("error", "Không thể thêm danh mục.");
                }
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("category_id"));
            String name = request.getParameter("category_name").trim();
            if (name.isEmpty()) {
                request.setAttribute("error", "Tên danh mục không được để trống.");
            } else if (dao.isCategoryNameExists(name, id)) {
                request.setAttribute("error", "Tên danh mục đã tồn tại.");
            } else {
                dao.updateCategory(id, name);
                response.sendRedirect("categories");
                return;
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("category_id"));
            dao.deleteCategory(id);
            response.sendRedirect("categories");
            return;
        } else if ("restore".equals(action)) {
            int id = Integer.parseInt(request.getParameter("category_id"));
            dao.restoreCategory(id);
            response.sendRedirect("categories");
            return;
        }

        // Nếu có lỗi, load lại danh sách
        List<Category> categories = dao.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/category_management.jsp").forward(request, response);
    }
}