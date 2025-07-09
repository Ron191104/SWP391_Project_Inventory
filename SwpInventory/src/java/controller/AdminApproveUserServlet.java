package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-approve")
public class AdminApproveUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
            response.sendRedirect("no_permission.jsp");
            return;
        }

        String action = request.getParameter("action");
        String username = request.getParameter("username");

        UserDAO dao = new UserDAO();

        // Nếu là edit, lấy user show ra form edit
        if ("edit".equals(action) && username != null) {
            User user = dao.getUserByUsername(username);
            request.setAttribute("editUser", user);
        }
        // Nếu là delete, xóa user rồi quay lại danh sách
        else if ("delete".equals(action) && username != null) {
            dao.deleteUser(username);
            response.sendRedirect("admin-approve");
            return;
        }

        List<User> unapprovedUsers = dao.getUnapprovedUsers();
        request.setAttribute("users", unapprovedUsers);
        request.getRequestDispatcher("approve_users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
            response.sendRedirect("no_permission.jsp");
            return;
        }
        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        // Duyệt user
        if ("approve".equals(action)) {
            String username = request.getParameter("username");
            dao.approveUser(username);
            response.sendRedirect("admin-approve");
        }
        // Sửa user
        else if ("edit".equals(action)) {
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            int role = Integer.parseInt(request.getParameter("role"));
            dao.updateUser(username, name, email, phone, address, role);
            response.sendRedirect("admin-approve");
        }
        // Xóa user (nếu dùng POST)
        else if ("delete".equals(action)) {
            String username = request.getParameter("username");
            dao.deleteUser(username);
            response.sendRedirect("admin-approve");
        }
    }
}