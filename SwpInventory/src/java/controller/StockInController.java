// File: src/main/java/controller/StockInController.java
// (This is a new servlet file to be created in your 'controller' package)
package controller;

import dao.ProductDAO;
import dao.InventoryDAO; // Using the separated DAO for inventory-related data
import dao.StockInDAO;
import model.Product;
import model.Supplier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "StockInController", urlPatterns = {"/stock_in"})
public class StockInController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(StockInController.class.getName());

    /**
     * Handles the HTTP GET request. This method is responsible for displaying the
     * stock-in form and populating it with necessary data like products and suppliers.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Use your existing ProductDAO to get the list of products
        ProductDAO productDAO = new ProductDAO();
        // Use the new, separate InventoryDAO to get the list of suppliers
        InventoryDAO inventoryDAO = new InventoryDAO(); 
        
        try {
            // Fetch all products (assuming you want to be able to stock-in any product)
            List<Product> productList = productDAO.getAllProduct();
            // Fetch all suppliers for the dropdown menu
            List<Supplier> supplierList = inventoryDAO.getAllSuppliers();
            
            // Set the lists as request attributes so the JSP can access them
            request.setAttribute("productList", productList);
            request.setAttribute("supplierList", supplierList);

            // Forward the request to the JSP page that contains the form
            request.getRequestDispatcher("stock_in_form.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error preparing data for stock-in form", e);
            request.setAttribute("errorMessage", "Could not load data for the stock-in form. Please try again later. Error: " + e.getMessage());
            // Redirect to the inventory dashboard with an error message
            request.getRequestDispatcher("/inventory_dashboard").forward(request, response);
        }
    }

    /**
     * Handles the HTTP POST request. This method processes the submitted stock-in form,
     * performs the database operations, and redirects the user with a success or error message.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        StockInDAO stockInDAO = new StockInDAO();

        try {
            // 1. Get main form data (supplier ID, notes)
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String note = request.getParameter("note");
            
            // In a real application, get the employee ID from the user's session
            // For this example, it's hardcoded.
            int employeeId = 1; 

            // 2. Get the lists of products and their quantities from the form
            String[] productIds = request.getParameterValues("productId");
            String[] quantities = request.getParameterValues("quantity");
            
            Map<Integer, Integer> productsToStockIn = new HashMap<>();
            if (productIds != null && quantities != null) {
                for (int i = 0; i < productIds.length; i++) {
                    // Ensure the data is valid before processing
                    if (productIds[i] != null && !productIds[i].isEmpty() && quantities[i] != null && !quantities[i].isEmpty()) {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        // Only add products with a valid ID and a quantity greater than zero
                        if (productId > 0 && quantity > 0) {
                            productsToStockIn.put(productId, quantity);
                        }
                    }
                }
            }
            
            // 3. Validate that at least one product was added
            if (productsToStockIn.isEmpty()) {
                session.setAttribute("errorMessage", "Please add at least one product with a valid quantity.");
                response.sendRedirect(request.getContextPath() + "/stock_in");
                return; // Stop processing if no valid products were submitted
            }

            // 4. Call the DAO to process the stock-in transaction
            boolean success = stockInDAO.processStockIn(supplierId, employeeId, note, productsToStockIn);

            if (success) {
                session.setAttribute("successMessage", "Stock-in successful! Inventory and product quantities have been updated.");
            } else {
                session.setAttribute("errorMessage", "Stock-in failed. Please check the server logs and try again.");
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid number format in stock-in form submission", e);
            session.setAttribute("errorMessage", "Invalid input. Please ensure all quantities and IDs are numbers.");
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database or Driver error during stock-in process", e);
            session.setAttribute("errorMessage", "A critical database error occurred. Details: " + e.getMessage());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "An unexpected error occurred during stock-in process", e);
            session.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
        }

        // 5. Redirect back to the inventory dashboard to show the success/error message
        response.sendRedirect(request.getContextPath() + "/inventory_dashboard");
    }
}
