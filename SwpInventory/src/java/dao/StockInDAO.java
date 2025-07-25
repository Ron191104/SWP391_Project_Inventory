package dao;

import dal.DBConnect;
import java.sql.*;
import java.util.Date;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.StockInDetail;

public class StockInDAO {

    private static final Logger LOGGER = Logger.getLogger(StockInDAO.class.getName());

    public boolean processStockIn(int supplierId, int employeeId, String note, Map<Integer, StockInDetail> productsToStockIn)
            throws SQLException, ClassNotFoundException {


        String insertStockInSQL = "INSERT INTO stock_in (supplier_id, employee_id, note) VALUES (?, ?, ?)";
        String insertStockInDetailSQL = "INSERT INTO stock_in_details "
                + "(stock_in_id, product_id, quantity, price_in, manufacture_date, expired_date) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        String upsertInventorySQL = "MERGE inventory AS target "
                + "USING (VALUES (?)) AS source (product_id) "
                + "ON (target.product_id = source.product_id) "
                + "WHEN MATCHED THEN "
                + "    UPDATE SET quantity = target.quantity + ? "
                + "WHEN NOT MATCHED THEN "
                + "    INSERT (product_id, quantity) VALUES (?, ?);";
        String updateProductQuantitySQL = "UPDATE products SET quantity = quantity + ? WHERE product_id = ?";
        String updateProductPriceSQL = "UPDATE products SET price = ? WHERE product_id = ?";
        String updateProductInfoSQL = "UPDATE products SET price = ?, manufacture_date = ?, expired_date = ? WHERE product_id = ?";

        Connection con = null;
        boolean success = false;

        try {
            con = DBConnect.getConnection();
            con.setAutoCommit(false);

            // 1. Insert phiếu nhập
            int stockInId;
            try (PreparedStatement psStockIn = con.prepareStatement(insertStockInSQL, Statement.RETURN_GENERATED_KEYS)) {
                psStockIn.setInt(1, supplierId);
                psStockIn.setInt(2, employeeId);
                psStockIn.setString(3, note);
                psStockIn.executeUpdate();

                try (ResultSet generatedKeys = psStockIn.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        stockInId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Không lấy được ID của phiếu nhập.");
                    }
                }
            }

            // 2. Insert từng sản phẩm chi tiết
            for (StockInDetail detail : productsToStockIn.values()) {
                int productId = detail.getProductId();
                int quantity = detail.getQuantity();
                double price = detail.getPriceIn();

                java.sql.Date manufactureDate = null;
                if (detail.getManufactureDate() != null) {
                    manufactureDate = new java.sql.Date(detail.getManufactureDate().getTime());
                }

                java.sql.Date expiryDate = null;
                if (detail.getExpiredDate() != null) {
                    expiryDate = new java.sql.Date(detail.getExpiredDate().getTime());
                }
                if (quantity <= 0) {
                    continue;
                }

                // Insert stock_in_detail
                try (PreparedStatement ps = con.prepareStatement(insertStockInDetailSQL)) {
                    ps.setInt(1, stockInId);
                    ps.setInt(2, productId);
                    ps.setInt(3, quantity);
                    ps.setDouble(4, price);
                    ps.setDate(5, manufactureDate);
                    ps.setDate(6, expiryDate);
                    ps.executeUpdate();
                }

                // Cập nhật inventory (cộng dồn)
                try (PreparedStatement ps = con.prepareStatement(upsertInventorySQL)) {
                    ps.setInt(1, productId);
                    ps.setInt(2, quantity);
                    ps.setInt(3, productId);
                    ps.setInt(4, quantity);
                    ps.executeUpdate();
                }

                // Cập nhật số lượng trong bảng products (cộng dồn)
                try (PreparedStatement ps = con.prepareStatement(updateProductQuantitySQL)) {
                    ps.setInt(1, quantity);
                    ps.setInt(2, productId);
                    ps.executeUpdate();
                }

                // Cập nhật giá, NSX, HSD (ghi đè)
                try (PreparedStatement ps = con.prepareStatement(updateProductInfoSQL)) {
                    ps.setDouble(1, price);
                    ps.setDate(2, manufactureDate);
                    ps.setDate(3, expiryDate);
                    ps.setInt(4, productId);
                    ps.executeUpdate();
                }
            }

            con.commit();
            success = true;
            LOGGER.info("Nhập kho thành công và đã commit.");

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi trong quá trình nhập kho, rollback", e);
            if (con != null) {
                con.rollback();
            }
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }

        return success;
    }
}
