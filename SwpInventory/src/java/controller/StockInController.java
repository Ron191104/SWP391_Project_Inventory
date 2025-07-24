package controller;

import dao.ProductDAO;
import dao.InventoryDAO;
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

        ProductDAO productDAO = new ProductDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();

        try {
            // Fetch all products
            List<Product> productList = productDAO.getAllProduct();

            // Fetch all suppliers (now using Supplier model)
            List<Supplier> supplierList = inventoryDAO.getAllSuppliers();

            // Set attributes for JSP
            request.setAttribute("productList", productList);
            request.setAttribute("supplierList", supplierList);

            // Forward to stock-in form JSP
            request.getRequestDispatcher("stock_in_form.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error preparing data for stock-in form", e);
            request.setAttribute("errorMessage", "Không thể tải dữ liệu cho phiếu nhập kho. Vui lòng thử lại sau. Lỗi: " + e.getMessage());
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

            // Get employeeId from session (should be set when login)
            Integer employeeId = (Integer) session.getAttribute("userId");
            if (employeeId == null) employeeId = 1; // fallback nếu chưa đăng nhập

            // 2. Get the lists of products and their quantities from the form
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

            // 3. Validate at least one product
            if (productsToStockIn.isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng chọn ít nhất một sản phẩm có số lượng > 0.");
                response.sendRedirect(request.getContextPath() + "/stock_in");
                return;
            }

            // 4. Process stock-in
            boolean success = stockInDAO.processStockIn(supplierId, employeeId, note, productsToStockIn);

            if (success) {
                session.setAttribute("successMessage", "Nhập kho thành công! Tồn kho đã được cập nhật.");
            } else {
                session.setAttribute("errorMessage", "Nhập kho thất bại. Vui lòng thử lại hoặc liên hệ quản trị.");
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Lỗi định dạng số trong nhập kho", e);
            session.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ. Vui lòng kiểm tra lại số lượng và mã sản phẩm.");
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi cơ sở dữ liệu khi nhập kho", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống cơ sở dữ liệu: " + e.getMessage());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi không xác định khi nhập kho", e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        // 5. Redirect to dashboard
        response.sendRedirect(request.getContextPath() + "/inventory_dashboard");
    }
}