package controller;

import dao.ProductDAO;
import dao.InventoryDAO; // Đã sửa InventoryDAO dùng Supplier
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();

        try {
            List<Product> productList = productDAO.getAllProduct();
            List<Supplier> supplierList = inventoryDAO.getAllSuppliers(); // ✅ dùng Supplier

            request.setAttribute("productList", productList);
            request.setAttribute("supplierList", supplierList);

            request.getRequestDispatcher("stock_in_form.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error preparing data for stock-in form", e);
            request.setAttribute("errorMessage", "Could not load data for the stock-in form. Error: " + e.getMessage());
            request.getRequestDispatcher("/inventory_dashboard").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        StockInDAO stockInDAO = new StockInDAO();

        try {
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String note = request.getParameter("note");
            int employeeId = 1; // Có thể lấy từ session trong thực tế

            String[] productIds = request.getParameterValues("productId");
            String[] quantities = request.getParameterValues("quantity");

            Map<Integer, Integer> productsToStockIn = new HashMap<>();
            if (productIds != null && quantities != null) {
                for (int i = 0; i < productIds.length; i++) {
                    if (productIds[i] != null && !productIds[i].isEmpty() &&
                        quantities[i] != null && !quantities[i].isEmpty()) {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        if (productId > 0 && quantity > 0) {
                            productsToStockIn.put(productId, quantity);
                        }
                    }
                }
            }

            if (productsToStockIn.isEmpty()) {
                session.setAttribute("errorMessage", "Please add at least one product with a valid quantity.");
                response.sendRedirect(request.getContextPath() + "/stock_in");
                return;
            }

            boolean success = stockInDAO.processStockIn(supplierId, employeeId, note, productsToStockIn);

            if (success) {
                session.setAttribute("successMessage", "Stock-in successful!");
            } else {
                session.setAttribute("errorMessage", "Stock-in failed. Please try again.");
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid number format in stock-in form submission", e);
            session.setAttribute("errorMessage", "Invalid input. Please enter valid numbers.");
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database error during stock-in", e);
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during stock-in", e);
            session.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/inventory_dashboard");
    }
}
