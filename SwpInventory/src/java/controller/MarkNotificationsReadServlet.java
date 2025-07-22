package controller;

import dao.NotificationDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/mark-notifications-read")
public class MarkNotificationsReadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            userId = 4; // Tạm gán adminId nếu muốn test nhanh
        }

        NotificationDAO.markAllAsRead(userId);

        response.setStatus(HttpServletResponse.SC_OK);
    }
}