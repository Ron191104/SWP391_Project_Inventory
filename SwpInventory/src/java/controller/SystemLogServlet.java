package controller;

import dao.SystemLogDAO;
import model.SystemLog;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
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
        SystemLogDAO dao = new SystemLogDAO();
        List<SystemLog> logList = dao.getAllLogs();
        request.setAttribute("logList", logList);
        request.getRequestDispatcher("system_logs.jsp").forward(request, response);
    }
}