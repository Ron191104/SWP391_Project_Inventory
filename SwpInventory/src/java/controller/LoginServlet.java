package controller;

import dal.UserDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmailAndPassword(email, password);

        if (user == null) {
            // Không tìm thấy user hoặc sai mật khẩu
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("signin.jsp").forward(request, response);
            return;
        }

        if (user.getIsApproved() != 1) {
            // Tài khoản chưa được duyệt
            request.setAttribute("errorMessage", "Tài khoản của bạn chưa được admin duyệt!");
            request.getRequestDispatcher("signin.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công (cả admin lẫn user thường)
        HttpSession session = request.getSession();
        session.setAttribute("userName", user.getUsername()); // dùng username để nhất quán
        session.setAttribute("userRole", user.getRole());
        session.setAttribute("userImage", user.getImage());
        session.setAttribute("userEmail", user.getEmail());
        response.sendRedirect("dashboard.jsp"); // đổi thành dashboard/home tùy bạn
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang đăng nhập khi truy cập GET
        request.getRequestDispatcher("signin.jsp").forward(request, response);
    }
}