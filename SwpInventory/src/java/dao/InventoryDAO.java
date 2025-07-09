package dao;

import dal.DBConnect;
import dto.AvailableProductView;
import model.SupplierAdmin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    /**
     * Fetches a list of all suppliers from the database.
     * @return A list of SupplierAdmin objects.
     * @throws SQLException if a database access error occurs.
     * @throws ClassNotFoundException if the JDBC driver is not found.
     */
    public List<SupplierAdmin> getAllSuppliers() throws SQLException, ClassNotFoundException {
        List<SupplierAdmin> suppliers = new ArrayList<>();
        String sql = "SELECT supplier_id, supplier_name, phone, email, address FROM suppliers ORDER BY supplier_name ASC";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                suppliers.add(new SupplierAdmin(
                    rs.getInt("supplier_id"), 
                    rs.getString("supplier_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address")
                ));
            }
        }
        return suppliers;
    }

    /**
     * Fetches the current list of all products in the inventory for the dashboard.
     * @return A list of AvailableProductView DTOs representing inventory items.
     * @throws SQLException if a database access error occurs.
     * @throws ClassNotFoundException if the JDBC driver is not found.
     */
    public List<AvailableProductView> getInventoryList() throws SQLException, ClassNotFoundException {
        List<AvailableProductView> inventoryList = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, inv.quantity, c.category_name " +
                     "FROM inventory inv " +
                     "JOIN products p ON inv.product_id = p.product_id " +
                     "JOIN categories c ON p.category_id = c.category_id " +
                     "ORDER BY p.product_name ASC";
        
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                AvailableProductView item = new AvailableProductView();
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setInventoryQuantity(rs.getInt("quantity"));
                item.setCategoryName(rs.getString("category_name"));
                inventoryList.add(item);
            }
        }
        return inventoryList;
    }
}