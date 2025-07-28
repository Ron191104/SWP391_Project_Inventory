package controller;

import dao.UserDAO;
import dao.NotificationDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

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

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleStr = request.getParameter("role");

        // Làm sạch dữ liệu
        username = username != null ? username.trim() : "";
        password = password != null ? password.trim() : "";
        email = email != null ? email.trim() : "";
        name = name != null ? name.trim() : "";
        phone = phone != null ? phone.trim() : "";
        address = address != null ? address.trim() : "";

        // Chuyển role sang số
        int role = 0;
        if ("Inventory Management".equals(roleStr)) {
            role = 1;
        } else if ("Store Management".equals(roleStr)) {
            role = 2;
        } else if ("Supplier Management".equals(roleStr)) {
            role = 3;
        }

        // Bắt đầu validate
        String error = null;

        if (username.isEmpty()) {
            error = "Username is required!";
        } else if (!username.matches("^[a-zA-Z0-9_]{4,20}$")) {
            error = "Username must be 4–20 characters long, no special characters or spaces!";
        } else if (password.isEmpty()) {
            error = "Password is required!";
        } else if (password.length() < 8) {
            error = "Password must be at least 8 characters!";
        } else if (!password.matches(".*[A-Z].*")) {
            error = "Password must contain at least one uppercase letter!";
        } else if (!password.matches(".*[a-z].*")) {
            error = "Password must contain at least one lowercase letter!";
        } else if (!password.matches(".*\\d.*")) {
            error = "Password must contain at least one number!";
        } else if (!password.matches(".*[!@#$%^&*()\\-+=<>?].*")) {
            error = "Password must contain at least one special character (!@#$%^&* etc.)!";
        } else if (name.isEmpty()) {
            error = "Full name is required!";
        } else if (!name.matches("^[\\p{L} ]{2,50}$")) {
            error = "Full name must be 2–50 letters (no special characters)!";
        } else if (!email.isEmpty() && !email.matches("^[\\w.+\\-]+@[a-zA-Z\\d\\-.]+\\.[a-zA-Z]{2,}$")) {
            error = "Invalid email format!";
        } else if (!phone.isEmpty() && !phone.matches("^\\d{9,11}$")) {
            error = "Phone number must be 9–11 digits!";
        } else if (role == 0) {
            error = "Please select a valid role!";
        }

        // Kiểm tra file ảnh (nếu có)
        Part imagePart = request.getPart("imageFile");
        String imagePath = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = imagePart.getSubmittedFileName().toLowerCase();
            if (!fileName.matches(".*\\.(png|jpg|jpeg|gif)$")) {
                error = "Avatar must be an image file (png, jpg, jpeg, gif)!";
            }
        }

        // Trả về nếu có lỗi
        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Lưu file ảnh (nếu có)
        if (imagePart != null && imagePart.getSize() > 0) {
            String submittedFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadFileName = username + "_" + System.currentTimeMillis() + "_" + submittedFileName;
            String uploadDir = getServletContext().getRealPath("/") + "uploads";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            imagePart.write(uploadDir + File.separator + uploadFileName);
            imagePath = "uploads/" + uploadFileName;
        }

        // Xử lý lưu vào database
        UserDAO dao = new UserDAO();
        try {
            if (dao.checkUsernameExists(username)) {
                request.setAttribute("error", "Username already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (!email.isEmpty() && dao.checkEmailExists(email)) {
                request.setAttribute("error", "Email already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (!phone.isEmpty() && dao.checkPhoneExists(phone)) {
                request.setAttribute("error", "Phone number already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            User user = new User(username, password, name, email, phone, address, role, imagePath, 0);
            if (dao.insertUser(user)) {
                NotificationDAO.insertNotification(
                        4, // ID admin
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
