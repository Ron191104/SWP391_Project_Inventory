package dao;

import java.sql.*;
import java.util.*;
import model.InventorySummary;
import dal.DBConnect;

public class InventorySummaryDAO {
    public List<InventorySummary> getInventorySummary() throws Exception {
        List<InventorySummary> list = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, c.category_name, s.supplier_name, " +
                     "i.quantity AS stock_quantity, p.unit, p.price, i.updated_at " +
                     "FROM inventory i " +
                     "JOIN products p ON i.product_id = p.product_id " +
                     "LEFT JOIN categories c ON p.category_id = c.category_id " +
                     "LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id " +
                     "ORDER BY c.category_name, p.product_name";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InventorySummary item = new InventorySummary();
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setCategoryName(rs.getString("category_name"));
                item.setSupplierName(rs.getString("supplier_name"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                item.setUnit(rs.getString("unit"));
                item.setPrice(rs.getDouble("price"));
                item.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(item);
            }
        }
        return list;
    }
}