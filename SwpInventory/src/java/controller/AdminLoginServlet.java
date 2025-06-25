package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username);

        // Kiểm tra: tài khoản tồn tại, đúng mật khẩu, là admin (role=4), đã duyệt
        if (user == null || !user.getPassword().equals(password) || user.getRole() != 4 || user.getIsApproved() != 1) {
            request.setAttribute("error", "Sai thông tin đăng nhập hoặc bạn không có quyền admin!");
            request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin đăng nhập vào session
        HttpSession session = request.getSession();
        session.setAttribute("userName", user.getUsername());
        session.setAttribute("userRole", user.getRole());

        // Chuyển tới dashboard admin
        response.sendRedirect("dashboard_admin.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Hiển thị trang đăng nhập admin
        request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
    }
}