package controller;

import dao.UserDAO;
import dao.SystemLogDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        // Xóa user khỏi DB
        UserDAO dao = new UserDAO();
        dao.deleteUser(username);

        // GHI LOG
        SystemLogDAO logDao = new SystemLogDAO();
        HttpSession session = request.getSession();
        String adminUsername = (String) session.getAttribute("userName");
        logDao.insertLog(adminUsername, "Xóa người dùng", "Đã xóa user: " + username);

        response.sendRedirect("user-management");
    }
}
