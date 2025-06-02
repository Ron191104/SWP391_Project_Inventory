package controller;

import dal.UserDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleStr = request.getParameter("role");
        String image = request.getParameter("image");

        int role = 0;
        switch (roleStr) {
            case "Inventory Management": role = 1; break;
            case "Store Management": role = 2; break;
            case "Supplier Management": role = 3; break;
        }

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == 0) {
            request.setAttribute("error", "Please fill all required fields!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (email != null && !email.trim().isEmpty() && !email.matches("^[\\w.+\\-]+@[a-zA-Z\\d\\-.]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Invalid email format!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        try {
            if (dao.checkUsernameExists(username)) {
                request.setAttribute("error", "Username already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (dao.checkEmailExists(email)) {
                request.setAttribute("error", "Email already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Không hash password, dùng plain text
            User user = new User(username, password, name, email, phone, address, role, image, 0);

            if (dao.insertUser(user)) {
                response.sendRedirect("register_success.jsp");
            } else {
                request.setAttribute("error", "Registration failed!");
                request.getRequestDispatcher("register_failed.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}