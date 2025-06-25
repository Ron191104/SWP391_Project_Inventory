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

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userImage", user.getImage());
            session.setAttribute("userEmail", user.getEmail());

            // Ghi LOG đăng nhập thành công
            SystemLogDAO logDao = new SystemLogDAO();
            logDao.insertLog(user.getUsername(), "Đăng nhập", "Đăng nhập thành công");

            response.sendRedirect("dashboard.jsp");
        } else {
            // Nếu muốn, cũng có thể ghi log đăng nhập thất bại (tùy ý)
            request.setAttribute("errorMessage", "Email/Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}