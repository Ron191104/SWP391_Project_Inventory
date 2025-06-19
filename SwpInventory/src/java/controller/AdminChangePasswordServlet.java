package controller;

import dao.UserDAO;
import dao.SystemLogDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/change-password")
public class AdminChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("userName");

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsernameAndPassword(username, oldPassword);

        if (user == null) {
            request.setAttribute("error", "Mật khẩu cũ không đúng!");
            request.getRequestDispatcher("change_password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận không khớp!");
            request.getRequestDispatcher("change_password.jsp").forward(request, response);
            return;
        }

        dao.updatePassword(username, newPassword);

        // Ghi log đổi mật khẩu
        SystemLogDAO logDao = new SystemLogDAO();
        logDao.insertLog(username, "Đổi mật khẩu", "Đổi mật khẩu thành công");

        request.setAttribute("message", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("change_password.jsp").forward(request, response);
    }
}