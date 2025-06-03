package controller;

import dal.UserDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
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

        // Validate phía server
        if (username==null || username.trim().isEmpty() ||
            password==null || password.trim().isEmpty() ||
            role == 0) {
            request.setAttribute("error", "Please fill all required fields!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Email (nếu nhập) phải đúng định dạng
        if(email != null && !email.trim().isEmpty() && !email.matches("^[\\w.+\\-]+@[a-zA-Z\\d\\-.]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Invalid email format!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Password nên >=6 ký tự
        if(password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        try {
            if(dao.checkUsernameExists(username)) {
                request.setAttribute("error", "Username already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Hash password trước khi lưu
            String hashedPassword = dao.hashPassword(password);

            User user = new User(username, hashedPassword, name, email, phone, address, role, image);

            if (dao.insertUser(user)) {
                response.sendRedirect("register_success.jsp");
            } else {
                // Thông báo lỗi chung
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