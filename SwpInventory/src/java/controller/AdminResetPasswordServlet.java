package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.MailUtil;

import java.io.IOException;

@WebServlet("/admin-reset-password")
public class AdminResetPasswordServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String username = request.getParameter("username");
    User user = null;

    if (username != null && !username.trim().isEmpty()) {
        UserDAO dao = new UserDAO();
        user = dao.getUserByUsername(username);
        request.setAttribute("username", username);
        if (user != null && user.getEmail() != null) {
            request.setAttribute("userEmail", user.getEmail());
        }
    }

    // Có thể username null thì cũng vẫn forward form (cho admin nhập username bằng tay hoặc quay lại)
    String message = request.getParameter("message");
    if (message != null) {
        request.setAttribute("message", message);
    }

    request.getRequestDispatcher("admin_reset_password_form.jsp").forward(request, response);
}
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String username = request.getParameter("username");
    String newPassword = request.getParameter("newPassword");

    UserDAO dao = new UserDAO();
    boolean updated = dao.updatePassword(username, newPassword);

    User user = dao.getUserByUsername(username);
    request.setAttribute("username", username);

    if (user != null && user.getEmail() != null) {
        request.setAttribute("userEmail", user.getEmail());
    }

    if (updated) {
        try {
            if (user != null && user.getEmail() != null && !user.getEmail().isEmpty()) {
                String subject = "Mật khẩu của bạn đã được thay đổi";
                String message = "Xin chào " + user.getName() + ",\n\n"
                        + "Mật khẩu tài khoản của bạn vừa được quản trị viên thay đổi.\n"
                        + "Tên đăng nhập: " + username + "\n"
                        + "Mật khẩu mới: " + newPassword + "\n\n"
                        + "Vui lòng đăng nhập lại và đổi mật khẩu nếu cần.\n\n"
                        + "Trân trọng,\nHệ thống Quản lý Kho";

                MailUtil.sendMail(user.getEmail(), subject, message);
                System.out.println("✅ Đã gửi email về: " + user.getEmail());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("message", "Đổi mật khẩu thành công cho " + username);
    } else {
        request.setAttribute("message", "❌ Lỗi: Không thể đổi mật khẩu.");
    }

    // Forward lại chính form để giữ dữ liệu
    request.getRequestDispatcher("admin_reset_password_form.jsp").forward(request, response);
}
}
