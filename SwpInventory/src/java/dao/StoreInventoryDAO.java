package dao;

import java.sql.*;
import java.util.*;
import model.StoreInventory; // Chỉ dùng một model
import dal.DBConnect;

public class StoreInventoryDAO {

    public StoreInventoryDAO(Connection conn) {
    }

    // Sử dụng DBConnect cho kết nối
    public List<StoreInventory> getAllStoreInventories() throws Exception {
        List<StoreInventory> list = new ArrayList<>();
        String sql = "SELECT st.store_id, st.store_name, p.product_id, p.product_name, "
                + "c.category_name, s.supplier_name, sp.quantity AS stock_quantity, "
                + "p.unit, p.price, sp.price_out "
                + "FROM store_products sp "
                + "JOIN stores st ON sp.store_id = st.store_id "
                + "JOIN products p ON sp.product_id = p.product_id "
                + "LEFT JOIN categories c ON p.category_id = c.category_id "
                + "LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id "
                + "ORDER BY st.store_id, c.category_name, p.product_name";
        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StoreInventory item = new StoreInventory();
                item.setStoreId(rs.getInt("store_id"));
                item.setStoreName(rs.getString("store_name"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setCategoryName(rs.getString("category_name"));
                item.setSupplierName(rs.getString("supplier_name"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                item.setUnit(rs.getString("unit"));
                item.setPrice(rs.getDouble("price"));      // Đúng tên hàm
                item.setPriceOut(rs.getDouble("price_out"));
                list.add(item);
            }
        }
        return list;
    }
}
