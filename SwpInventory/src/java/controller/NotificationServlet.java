package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.NotificationDAO;
import model.Notification;

@WebServlet("/load-notifications")
public class NotificationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");

        // In ra để kiểm tra session thực sự có userId chưa
        System.out.println("userId trong session: " + userId);

        // Nếu chưa có userId trong session (tức chưa đăng nhập đúng), tạm cho adminId cố định
        if (userId == null) {
            userId = 4; // 🛠️ Tạm thời: admin có userId = 4
        }

        // Lấy danh sách thông báo từ DB
        List<Notification> notifications = NotificationDAO.getNotificationsByUser(userId);

        // Trả JSON về trình duyệt
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(notifications);
        response.getWriter().write(json);
    }
}