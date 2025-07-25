package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/ToggleApprovalServlet")
public class ToggleApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String userIdStr = request.getParameter("userId");
            String action = request.getParameter("action");

            System.out.println(">>> Nhận userId = " + userIdStr + ", action = " + action);

            if (userIdStr != null && !userIdStr.isEmpty()) {
                int userId = Integer.parseInt(userIdStr);
                UserDAO dao = new UserDAO();

                if ("unapprove".equals(action)) {
                    System.out.println("→ Hủy duyệt user ID: " + userId);
                    dao.updateApprovalStatus(userId, 0);
                } else if ("approve".equals(action)) {
                    System.out.println("→ Duyệt lại user ID: " + userId);
                    dao.updateApprovalStatus(userId, 1);
                }
            } else {
                System.out.println("⚠️ userId bị null hoặc rỗng");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("user-management");
    }
}