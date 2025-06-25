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
        // SỬA: kiểm tra đúng role admin (role == 4)
        if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
            // Nếu không phải admin, hiển thị trang báo không có quyền
            response.sendRedirect("no_permission.jsp");
            return;
        }
        UserDAO dao = new UserDAO();
        List<User> unapprovedUsers = dao.getUnapprovedUsers();
        request.setAttribute("users", unapprovedUsers);
        request.getRequestDispatcher("approve_users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // SỬA: kiểm tra đúng role admin (role == 4)
        if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
            response.sendRedirect("no_permission.jsp");
            return;
        }
        String username = request.getParameter("username");
        UserDAO dao = new UserDAO();
        dao.approveUser(username);
        response.sendRedirect("user-management");
    }
}