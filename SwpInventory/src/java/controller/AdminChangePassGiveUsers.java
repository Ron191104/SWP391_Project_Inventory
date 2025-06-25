package controller;

import dao.UserDAO;
import dao.SystemLogDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/change-password-admin")
public class AdminChangePassGiveUsers extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận không khớp!");
            request.getRequestDispatcher("change_password_admin.jsp?username=" + username).forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        dao.updatePassword(username, newPassword);

        // Ghi log đổi mật khẩu
        HttpSession session = request.getSession();
        String admin = (String) session.getAttribute("userName");
        SystemLogDAO logDao = new SystemLogDAO();
        logDao.insertLog(admin, "Reset mật khẩu", "Đặt lại mật khẩu cho tài khoản: " + username);

        request.setAttribute("message", "Đổi mật khẩu thành công cho " + username);
        request.getRequestDispatcher("change_password_admin.jsp?username=" + username).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển sang JSP đổi mật khẩu
        request.getRequestDispatcher("change_password_admin.jsp").forward(request, response);
    }
}