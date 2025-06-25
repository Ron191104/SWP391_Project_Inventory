package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.IOException;

@WebServlet("/myprofile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class MyProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String email = (String) session.getAttribute("userEmail");
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }
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
        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int role = Integer.parseInt(request.getParameter("role"));

        // Lấy ảnh cũ
        UserDAO dao = new UserDAO();
        User oldUser = dao.getUserByEmail(email);
        String image = (oldUser != null && oldUser.getImage() != null) ? oldUser.getImage() : null;

        // Xử lý upload file mới nếu có
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

        // Tạo đối tượng User mới (isApproved giữ nguyên, ở đây mặc định là 1)
        User user = new User(username, password, name, email, phone, address, role, image, 1);

        boolean updated = dao.updateProfile(user);

        if (updated) {
            HttpSession session = request.getSession();
            session.setAttribute("userFullName", name);
            session.setAttribute("userImage", image);
            session.setAttribute("userEmail", email);
            request.setAttribute("success", "Cập nhật hồ sơ thành công!");
        } else {
            request.setAttribute("error", "Cập nhật thất bại!");
        }

        // Lấy lại thông tin mới nhất để hiển thị
        User updatedUser = dao.getUserByEmail(email);
        request.setAttribute("user", updatedUser);
        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }
}