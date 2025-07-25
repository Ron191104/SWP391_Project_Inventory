package dao;

import dal.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StockInDAO {
    private static final Logger LOGGER = Logger.getLogger(StockInDAO.class.getName());

    public boolean processStockIn(int supplierId, int employeeId, String note, Map<Integer, Integer> productsToStockIn)
            throws SQLException, ClassNotFoundException {
        
        String insertStockInSQL = "INSERT INTO stock_in (supplier_id, employee_id, note) VALUES (?, ?, ?);";
        String insertStockInDetailSQL = "INSERT INTO stock_in_details (stock_in_id, product_id, quantity) VALUES (?, ?, ?);";
        String upsertInventorySQL = "MERGE inventory AS target " +
                                    "USING (VALUES (?)) AS source (product_id) " +
                                    "ON (target.product_id = source.product_id) " +
                                    "WHEN MATCHED THEN " +
                                    "    UPDATE SET quantity = target.quantity + ? " +
                                    "WHEN NOT MATCHED THEN " +
                                    "    INSERT (product_id, quantity) VALUES (?, ?);";
        String updateProductQuantitySQL = "UPDATE products SET quantity = quantity + ? WHERE product_id = ?;";

        Connection con = null;
        boolean success = false;

        try {
            con = DBConnect.getConnection();
            con.setAutoCommit(false); // Start transaction

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
                        throw new SQLException("Creating stock_in failed, no ID obtained.");
                    }
                }
            }

            for (Map.Entry<Integer, Integer> entry : productsToStockIn.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();
                if (quantity <= 0) continue;

                try (PreparedStatement psDetail = con.prepareStatement(insertStockInDetailSQL)) {
                    psDetail.setInt(1, stockInId);
                    psDetail.setInt(2, productId);
                    psDetail.setInt(3, quantity);
                    psDetail.executeUpdate();
                }

                try (PreparedStatement psInventory = con.prepareStatement(upsertInventorySQL)) {
                    psInventory.setInt(1, productId);
                    psInventory.setInt(2, quantity);
                    psInventory.setInt(3, productId);
                    psInventory.setInt(4, quantity);
                    psInventory.executeUpdate();
                }
                
                try (PreparedStatement psUpdateProduct = con.prepareStatement(updateProductQuantitySQL)) {
                    psUpdateProduct.setInt(1, quantity);
                    psUpdateProduct.setInt(2, productId);
                    psUpdateProduct.executeUpdate();
                }
            }

            con.commit();
            success = true;
            LOGGER.log(Level.INFO, "Stock-in transaction committed successfully.");

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during stock-in transaction. Rolling back.", e);
            if (con != null) con.rollback();
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