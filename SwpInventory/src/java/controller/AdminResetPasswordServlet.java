package controller;

import dao.UserDAO;
import dao.SystemLogDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-reset-password")
public class AdminResetPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        request.setAttribute("username", username); // truyền cho JSP
        request.getRequestDispatcher("admin_reset_password_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        UserDAO dao = new UserDAO();
        dao.updatePassword(username, newPassword);

        request.setAttribute("message", "Đổi mật khẩu thành công cho " + username);
        request.setAttribute("username", username); // giữ lại username để hiển thị lại form
        request.getRequestDispatcher("admin_reset_password_form.jsp").forward(request, response);
    }
}