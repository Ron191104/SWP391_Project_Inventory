package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ChangePassWordUser", urlPatterns = {"/changepassworduser"})
public class ChangePassWordUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form đổi mật khẩu
        request.getRequestDispatcher("change_password_user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đảm bảo xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username"); // lấy username từ session

 

        // Lấy dữ liệu từ form
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra dữ liệu rỗng
        if (username == null || oldPassword == null || newPassword == null || confirmPassword == null ||
            oldPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            request.getRequestDispatcher("change_password_user.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("change_password_user.jsp").forward(request, response);
            return;
        }

        // Gọi DAO để kiểm tra và cập nhật
        UserDAO dao = new UserDAO();
        boolean isCorrect = dao.checkPassword(username, oldPassword);
        if (!isCorrect) {
            request.setAttribute("error", "Mật khẩu cũ không đúng.");
        } else {
            boolean success = dao.updatePassword(username, newPassword);
            if (success) {
                request.setAttribute("message", "Đổi mật khẩu thành công.");
            } else {
                request.setAttribute("error", "Có lỗi khi cập nhật mật khẩu.");
            }
        }

        request.getRequestDispatcher("change_password_user.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Đổi mật khẩu cho user đã đăng nhập";
    }
}