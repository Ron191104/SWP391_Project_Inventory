package controller;

import dao.UserDAO;
import model.User;
import dao.SystemLogDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login"); // lấy email hoặc username
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user;

        // Nếu login chứa '@' thì đăng nhập bằng email, ngược lại bằng username
        if (login != null && login.contains("@")) {
            user = dao.getUserByEmailAndPassword(login, password);
        } else {
            user = dao.getUserByUsernameAndPassword(login, password);
        }

        if (user == null) {
            // Sai tài khoản hoặc mật khẩu
            request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // CHỈ kiểm tra duyệt với user KHÔNG PHẢI admin
        if (user.getRole() != 4 && user.getIsApproved() == 0) {
            request.setAttribute("errorMessage", "Tài khoản của bạn chưa được duyệt. Vui lòng liên hệ quản trị viên.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Đã được duyệt, cho đăng nhập như bình thường
        HttpSession session = request.getSession();
        session.setAttribute("userName", user.getName());
        session.setAttribute("userRole", user.getRole());
        session.setAttribute("userImage", user.getImage());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("username", user.getUsername()); // ✅ THÊM DÒNG NÀY

        // Ghi LOG đăng nhập thành công
        SystemLogDAO logDao = new SystemLogDAO();
        logDao.insertLog(user.getUsername(), "Đăng nhập", "Đăng nhập thành công");

        // Điều hướng theo role (int)
        int role = user.getRole();
        switch (role) {
            case 1:
                response.sendRedirect("inventory_dashboard.jsp");
                break;
            case 2:
                response.sendRedirect("store_dashboard.jsp");
                break;
            case 3:
                response.sendRedirect("supplier_dashboard.jsp");
                break;
            case 4:
                response.sendRedirect("AdminDashboardServlet");
                break;
            default:
                response.sendRedirect("general_dashboard.jsp");
                break;
        }
    }
}