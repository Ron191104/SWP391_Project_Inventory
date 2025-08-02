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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleStr = request.getParameter("role");

        // Validate đầu vào
        String errorMsg = null;
        if (name == null || name.trim().isEmpty()) {
            errorMsg = "Tên không được để trống.";
        } else if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            errorMsg = "Email không hợp lệ.";
        } else if (phone == null || !phone.matches("^\\d{9,11}$")) {
            errorMsg = "Số điện thoại phải là số và từ 9-11 chữ số.";
        } else if (address == null || address.trim().isEmpty()) {
            errorMsg = "Địa chỉ không được để trống.";
        } else if (roleStr == null || !roleStr.matches("\\d+")) {
            errorMsg = "Vai trò không hợp lệ.";
        }

        int role = 0;
        if (errorMsg == null) {
            role = Integer.parseInt(roleStr);
            if (role < 1 || role > 4) {
                errorMsg = "Vai trò không hợp lệ.";
            }
        }

        if (errorMsg != null) {
            User user = new User(username, "", name, email, phone, address, role, null, 1);
            request.setAttribute("user", user);
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("edit_user.jsp").forward(request, response);
            return;
        }

        // Cập nhật vào DB nếu không lỗi
        UserDAO dao = new UserDAO();
        dao.updateUser(username, name, email, phone, address, role);
        response.sendRedirect("user-management");
    }
}