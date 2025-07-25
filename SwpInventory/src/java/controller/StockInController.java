package controller;

import dao.ProductDAO;
import dao.InventoryDAO;
import dao.StockInDAO;
import model.Product;
import model.Supplier;
import model.StockInDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.*;
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
            List<Supplier> supplierList = inventoryDAO.getAllSuppliers();

            request.setAttribute("productList", productList);
            request.setAttribute("supplierList", supplierList);

            request.getRequestDispatcher("stock_in_form.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error preparing data for stock-in form", e);
            request.setAttribute("errorMessage", "Không thể tải dữ liệu cho phiếu nhập kho. Vui lòng thử lại sau. Lỗi: " + e.getMessage());
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
            Integer employeeId = (Integer) session.getAttribute("userId");
            if (employeeId == null) {
                employeeId = 1;
            }

            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] pricesIn = request.getParameterValues("price_in[]");
            String[] manufactureDates = request.getParameterValues("manufacture_date[]");
            String[] expiredDates = request.getParameterValues("expired_date[]");

            Map<Integer, StockInDetail> productsToStockIn = new HashMap<>();

            if (productIds != null && quantities != null && pricesIn != null && manufactureDates != null) {
                for (int i = 0; i < productIds.length; i++) {
                    try {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        double priceIn = Double.parseDouble(pricesIn[i]);
                        Date manufactureDate = Date.valueOf(manufactureDates[i]);

                        Date expiredDate = null;
                        if (expiredDates != null && expiredDates.length > i && !expiredDates[i].isEmpty()) {
                            expiredDate = Date.valueOf(expiredDates[i]);
                        }

                        if (productId > 0 && quantity > 0) {
                            StockInDetail detail = new StockInDetail();
                            detail.setProductId(productId);
                            detail.setQuantity(quantity);
                            detail.setPriceIn(priceIn);
                            detail.setManufactureDate(manufactureDate);
                            detail.setExpiredDate(expiredDate);
                            productsToStockIn.put(productId, detail);
                        }
                    } catch (Exception e) {
                        LOGGER.log(Level.WARNING, "Lỗi khi xử lý dòng sản phẩm tại index " + i, e);
                    }
                }
            }

            if (productsToStockIn.isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng chọn ít nhất một sản phẩm có số lượng > 0.");
                response.sendRedirect(request.getContextPath() + "/stock_in");
                return;
            }

            boolean success = stockInDAO.processStockIn(supplierId, employeeId, note, productsToStockIn);

            if (success) {
                session.setAttribute("successMessage", "Nhập kho thành công! Tồn kho đã được cập nhật.");
            } else {
                session.setAttribute("errorMessage", "Nhập kho thất bại. Vui lòng thử lại hoặc liên hệ quản trị.");
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Lỗi định dạng số trong nhập kho", e);
            session.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ. Vui lòng kiểm tra lại số lượng, giá nhập và mã sản phẩm.");
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi cơ sở dữ liệu khi nhập kho", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống cơ sở dữ liệu: " + e.getMessage());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi không xác định khi nhập kho", e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/inventory_dashboard");
    }
}
