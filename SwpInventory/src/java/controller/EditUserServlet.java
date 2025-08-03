package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/edit-user")
public class EditUserServlet extends HttpServlet {

    // Hiển thị form sửa thông tin người dùng (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
            response.sendRedirect("no_permission.jsp");
            return;
        }

        String username = request.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("user-management");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username);
        if (user == null) {
            response.sendRedirect("user-management");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("edit_user.jsp").forward(request, response);
    }

    // Xử lý cập nhật người dùng sau khi submit form (POST)
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("userRole") == null || ((int) session.getAttribute("userRole")) != 4) {
        response.sendRedirect("no_permission.jsp");
        return;
    }

    String username = request.getParameter("username");
    String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
    String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
    String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
    String address = request.getParameter("address") != null ? request.getParameter("address").trim() : "";
    String roleStr = request.getParameter("role");

    int role = 0;
    String errorMsg = null;

    // Validate đầu vào
    if (name.isEmpty()) {
        errorMsg = "Tên không được để trống.";
    } else if (!name.matches("^[\\p{L} ]{2,50}$")) {
        errorMsg = "Tên phải từ 2–50 ký tự chữ, không chứa ký tự đặc biệt.";
    } else if (email.isEmpty()) {
        errorMsg = "Email không được để trống.";
    } else if (!email.matches("^[\\w.+\\-]+@[a-zA-Z\\d\\-.]+\\.[a-zA-Z]{2,}$")) {
        errorMsg = "Email không hợp lệ.";
    } else if (phone.isEmpty()) {
        errorMsg = "Số điện thoại không được để trống.";
    } else if (!phone.matches("^\\d{9,11}$")) {
        errorMsg = "Số điện thoại phải từ 9–11 chữ số.";
    } else if (address.isEmpty()) {
        errorMsg = "Địa chỉ không được để trống.";
    } else if (roleStr == null || !roleStr.matches("\\d+")) {
        errorMsg = "Vai trò không hợp lệ.";
    } else {
        role = Integer.parseInt(roleStr);
        if (role < 1 || role > 4) {
            errorMsg = "Vai trò không hợp lệ.";
        }
    }

    // Nếu có lỗi validate -> trả về form
    if (errorMsg != null) {
        User user = new User(username, "", name, email, phone, address, role, null, 1);
        request.setAttribute("user", user);
        request.setAttribute("errorMsg", errorMsg);
        request.getRequestDispatcher("edit_user.jsp").forward(request, response);
        return;
    }

    // Kiểm tra trùng email và sđt
    UserDAO dao = new UserDAO();

    if (dao.isEmailDuplicate(email, username)) {
        User user = new User(username, "", name, email, phone, address, role, null, 1);
        request.setAttribute("user", user);
        request.setAttribute("errorMsg", "Email đã được sử dụng bởi người dùng khác.");
        request.getRequestDispatcher("edit_user.jsp").forward(request, response);
        return;
    }

    if (dao.isPhoneDuplicate(phone, username)) {
        User user = new User(username, "", name, email, phone, address, role, null, 1);
        request.setAttribute("user", user);
        request.setAttribute("errorMsg", "Số điện thoại đã được sử dụng bởi người dùng khác.");
        request.getRequestDispatcher("edit_user.jsp").forward(request, response);
        return;
    }

    // Nếu hợp lệ, cập nhật DB
    dao.updateUser(username, name, email, phone, address, role);
    response.sendRedirect("user-management");
}
}
