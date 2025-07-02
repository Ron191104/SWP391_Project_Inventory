package controller;

import dao.UserDAO;
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
    maxRequestSize = 10 * 1024 * 1024// 10MB
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
        // Không lấy image từ text
        // String image = request.getParameter("image");

        int role = 0;
        if ("Inventory Management".equals(roleStr)) role = 1;
        else if ("Store Management".equals(roleStr)) role = 2;
        else if ("Supplier Management".equals(roleStr)) role = 3;

        String error = null;
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == 0) {
            error = "Please fill all required fields!";
        }
        else if (email != null && !email.trim().isEmpty() &&
            !email.matches("^[\\w.+\\-]+@[a-zA-Z\\d\\-.]+\\.[a-zA-Z]{2,}$")) {
            error = "Invalid email format!";
        }
        else if (password.length() < 6) {
            error = "Password must be at least 6 characters!";
        }
        else if (!password.matches(".*[A-Za-z].*") || !password.matches(".*\\d.*")) {
            error = "Password must contain both letters and numbers!";
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
            // Lấy tên file gốc
            String submittedFileName = java.nio.file.Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            // Đổi tên file để tránh trùng
            String uploadFileName = username + "_" + System.currentTimeMillis() + "_" + submittedFileName;
            // Đường dẫn thư mục upload (lưu ý: nên tạo thư mục này trong webapp)
            String uploadDir = getServletContext().getRealPath("/") + "uploads";
            java.io.File dir = new java.io.File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            // Lưu file lên server
            imagePart.write(uploadDir + java.io.File.separator + uploadFileName);
            // Đường dẫn lưu vào DB (tương đối)
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

            // Gán path ảnh vào trường image
            User user = new User(username, password, name, email, phone, address, role, imagePath, 0);

            if (dao.insertUser(user)) {
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