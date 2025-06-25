package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user-management")
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
            response.sendRedirect("no_permission.jsp");
            return;
        }
        UserDAO userDAO = new UserDAO();
        List<User> userList = userDAO.getAllUsers();
        System.out.println("userList size = " + userList.size()); // Kiểm tra log này khi truy cập trang
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("user_management.jsp").forward(request, response);
    }
}


