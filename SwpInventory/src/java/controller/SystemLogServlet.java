package controller;

import dao.SystemLogDAO;
import model.SystemLog;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/system-logs")
public class SystemLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !session.getAttribute("userRole").toString().equals("4")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String action = request.getParameter("action");
        String timestampStr = request.getParameter("timestamp");

        Timestamp timestamp = null;
        if (timestampStr != null && !timestampStr.isEmpty()) {
            try {
                timestamp = Timestamp.valueOf(timestampStr.replace("T", " ") + ":00");
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }

        SystemLogDAO dao = new SystemLogDAO();
        List<SystemLog> logList = dao.searchLogs(username, action, timestamp);
        request.setAttribute("logList", logList);
        request.getRequestDispatcher("system_logs.jsp").forward(request, response);
    }
}
