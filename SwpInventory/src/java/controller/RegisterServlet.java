package controller;

import dao.UserDAO;
import dao.NotificationDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 5 * 1024 * 1024,   // 5MB
        maxRequestSize = 10 * 1024 * 1024 // 10MB
)
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

        int role = 0;
        if ("Inventory Management".equals(roleStr)) {
            role = 1;
        } else if ("Store Management".equals(roleStr)) {
            role = 2;
        } else if ("Supplier Management".equals(roleStr)) {
            role = 3;
        }

        String error = null;
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || role == 0) {
            error = "Please fill all required fields!";
        } else if (email != null && !email.trim().isEmpty()
                && !email.matches("^[\\w.+\\-]+@[a-zA-Z\\d\\-.]+\\.[a-zA-Z]{2,}$")) {
            error = "Invalid email format!";
        } else if (password.length() < 8) {
            error = "Password must be at least 8 characters!";
        } else if (!password.matches(".*[A-Z].*")) {
            error = "Password must contain at least one uppercase letter!";
        } else if (!password.matches(".*[a-z].*")) {
            error = "Password must contain at least one lowercase letter!";
        } else if (!password.matches(".*\\d.*")) {
            error = "Password must contain at least one number!";
        } else if (!password.matches(".*[!@#$%^&*()\\-+=<>?].*")) {
            error = "Password must contain at least one special character!";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Xử lý upload ảnh
        String imagePath = null;
        Part imagePart = request.getPart("imageFile");
        if (imagePart != null && imagePart.getSize() > 0) {
            String submittedFileName = java.nio.file.Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadFileName = username + "_" + System.currentTimeMillis() + "_" + submittedFileName;
            String uploadDir = getServletContext().getRealPath("/") + "uploads";
            java.io.File dir = new java.io.File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            imagePart.write(uploadDir + java.io.File.separator + uploadFileName);
            imagePath = "uploads/" + uploadFileName;
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

            User user = new User(username, password, name, email, phone, address, role, imagePath, 0);

            if (dao.insertUser(user)) {
                // Thêm thông báo gửi đến admin
                int adminUserId = 4; // Hoặc lấy từ hệ thống nếu có nhiều admin
                NotificationDAO.insertNotification(
                    adminUserId,
                    "Yêu cầu duyệt tài khoản mới: " + user.getUsername()
                );

                response.sendRedirect("register_success.jsp");
            } else {
                request.setAttribute("error", "Registration failed!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}