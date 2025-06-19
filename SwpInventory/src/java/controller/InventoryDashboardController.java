package controller;

import dao.InventoryDAO; // MODIFIED: Import InventoryDAO
import dto.AvailableProductView;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "InventoryDashboardController", urlPatterns = {"/inventory_dashboard"})
public class InventoryDashboardController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(InventoryDashboardController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // MODIFIED: Instantiate InventoryDAO instead of ProductDAO
        InventoryDAO inventoryDAO = new InventoryDAO();
        try {
            // Call the method from the new DAO
            List<AvailableProductView> inventoryList = inventoryDAO.getInventoryList();
            request.setAttribute("inventoryList", inventoryList);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching inventory list for dashboard", e);
            request.setAttribute("errorMessage", "Could not load inventory list: " + e.getMessage());
        }
        
        request.getRequestDispatcher("inventory_dashboard.jsp").forward(request, response);
    }
}