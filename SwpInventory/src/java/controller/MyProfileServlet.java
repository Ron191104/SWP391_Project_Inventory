package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/myprofile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class MyProfileServlet extends HttpServlet {

    private boolean isValidEmail(String email) {
        return Pattern.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$", email);
    }

    private boolean isValidPhone(String phone) {
        return Pattern.matches("^0\\d{9,10}$", phone); // Bắt đầu bằng 0, 10-11 số
    }

    private boolean isValidUsername(String username) {
        return Pattern.matches("^[a-zA-Z0-9._-]{3,30}$", username);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("userEmail");
        User user = new UserDAO().getUserByEmail(email);
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String name     = request.getParameter("name");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String address  = request.getParameter("address");
        int role        = Integer.parseInt(request.getParameter("role"));

        UserDAO dao = new UserDAO();
        String error = null;

        // Validate
        if (username == null || !isValidUsername(username)) {
            error = "❌ Tên đăng nhập không hợp lệ!";
        } else if (name == null || name.trim().isEmpty()) {
            error = "❌ Họ tên không được để trống!";
        } else if (email == null || !isValidEmail(email)) {
            error = "❌ Email không đúng định dạng!";
        } else if (dao.isEmailDuplicate(email, username)) {
            error = "❌ Email này đã được sử dụng bởi tài khoản khác!";
        } else if (phone == null || !isValidPhone(phone)) {
            error = "❌ Số điện thoại không hợp lệ! Phải bắt đầu bằng 0 và có 10–11 số.";
        } else if (dao.isPhoneDuplicate(phone, username)) {
            error = "❌ Số điện thoại này đã được sử dụng bởi tài khoản khác!";
        } else if (address == null || address.trim().isEmpty()) {
            error = "❌ Địa chỉ không được để trống!";
        }

        if (error != null) {
            request.setAttribute("error", error);
            User fallback = new User(username, null, name, email, phone, address, role, null, 1);
            request.setAttribute("user", fallback);
            request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            return;
        }

        // Lấy dữ liệu cũ
        User oldUser = dao.getUserByUsername(username);
        String password = (oldUser != null) ? oldUser.getPassword() : "";
        String image = (oldUser != null && oldUser.getImage() != null) ? oldUser.getImage() : null;

        // Xử lý ảnh nếu có upload
        Part imagePart = request.getPart("imageFile");
        if (imagePart != null && imagePart.getSize() > 0) {
            String submittedFileName = java.nio.file.Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadFileName = username + "_" + System.currentTimeMillis() + "_" + submittedFileName;
            String uploadDir = getServletContext().getRealPath("/") + "uploads";
            java.io.File dir = new java.io.File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            imagePart.write(uploadDir + java.io.File.separator + uploadFileName);
            image = "uploads/" + uploadFileName;
        }

        User user = new User(username, password, name, email, phone, address, role, image, 1);
        boolean updated = dao.updateProfile(user);
        if (updated) {
            HttpSession session = request.getSession();
            session.setAttribute("userFullName", name);
            session.setAttribute("userImage", image);
            session.setAttribute("userEmail", email);
            request.setAttribute("success", "✅ Cập nhật hồ sơ thành công!");
        } else {
            request.setAttribute("error", "❌ Cập nhật thất bại!");
        }

        request.setAttribute("user", dao.getUserByEmail(email));
        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }
}