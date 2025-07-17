package controller;

import dao.InventorySummaryDAO;
import model.InventorySummary;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet; // import annotation này
import java.io.IOException;
import java.util.List;

@WebServlet("/inventory-summary") // Đăng ký đường dẫn cho servlet
public class InventorySummaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        InventorySummaryDAO dao = new InventorySummaryDAO();
        try {
            List<InventorySummary> inventoryList = dao.getInventorySummary();
            request.setAttribute("inventoryList", inventoryList);
            RequestDispatcher rd = request.getRequestDispatcher("inventory_summary.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error loading inventory data");
        }
    }
}