/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.StoreOrderDetails;
import model.StoreStockIn;
import java.sql.Statement;
import model.StoreStockInDetail;
import java.util.Map;
import java.util.HashMap;

/**
 *
 * @author ADMIN
 */
public class StoreStockInDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<StoreStockIn> getAllByStoreId(int storeId) {
        List<StoreStockIn> list = new ArrayList<>();
        String query = "SELECT * FROM store_stock_in WHERE store_id = ? ORDER BY import_date DESC";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            rs = ps.executeQuery();

            while (rs.next()) {
                StoreStockIn s = new StoreStockIn();
                s.setId(rs.getInt("store_stock_in_id"));
                s.setStoreId(rs.getInt("store_id"));
                s.setNote(rs.getString("note"));
                s.setImportDate(rs.getTimestamp("import_date"));
                s.setStatus(rs.getInt("status"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insertStockIn(StoreStockIn s) {
        int newId = 0;
        String query = "INSERT INTO store_stock_in (store_id, note, status) VALUES (?, ?, ?)";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, s.getStoreId());
            ps.setString(2, s.getNote());
            ps.setInt(3, s.getStatus());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                newId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return newId;
    }

    public void insertStockInDetail(int stockInId, StoreOrderDetails d) {
        String query = "INSERT INTO store_stock_in_details (store_stock_in_id, product_id, quantity, price_in, unit_name) VALUES (?, ?, ?, ?, ?)";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, stockInId);
            ps.setInt(2, d.getProductId());
            ps.setInt(3, d.getQuantity());
            ps.setDouble(4, d.getPrice());
            ps.setString(5, d.getUnit());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public StoreStockIn getStockInById(int stockInId) {
        String query = "SELECT * FROM store_stock_in WHERE store_stock_in_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, stockInId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StoreStockIn s = new StoreStockIn();
                s.setId(rs.getInt("store_stock_in_id"));
                s.setStoreId(rs.getInt("store_id"));
                s.setNote(rs.getString("note"));
                s.setImportDate(rs.getTimestamp("import_date"));
                s.setStatus(rs.getInt("status"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<StoreStockInDetail> getStockInDetails(int stockInId) {
        List<StoreStockInDetail> list = new ArrayList<>();
        String query = "SELECT d.*, p.product_name, p.barcode FROM store_stock_in_details d "
                + "JOIN products p ON d.product_id = p.product_id WHERE d.store_stock_in_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, stockInId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StoreStockInDetail d = new StoreStockInDetail();
                d.setId(rs.getInt("id"));
                d.setStockInId(rs.getInt("store_stock_in_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setPriceIn(rs.getDouble("price_in"));
                d.setProductName(rs.getString("product_name"));
                d.setUnitName(rs.getString("unit_name"));
                d.setBarcode(rs.getString("barcode"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StoreStockIn> getAllStockIn() {
        List<StoreStockIn> list = new ArrayList<>();
        String query = "SELECT * FROM store_stock_in ORDER BY import_date DESC";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                StoreStockIn s = new StoreStockIn();
                s.setId(rs.getInt("store_stock_in_id"));
                s.setStoreId(rs.getInt("store_id"));
                s.setNote(rs.getString("note"));
                s.setImportDate(rs.getTimestamp("import_date"));
                s.setStatus(rs.getInt("status"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateStatus(int stockInId, int status) {
        String query = "UPDATE store_stock_in SET status = ? WHERE store_stock_in_id = ?";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, status);
            ps.setInt(2, stockInId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void exportStock(int stockInId) {
        Map<Integer, Integer> details = getStockInDetailsMap(stockInId);

        try {
            con = DBConnect.getConnection();

            for (Map.Entry<Integer, Integer> entry : details.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();

                // Trừ kho tổng (products)
                String updateInventory = "UPDATE products SET quantity = quantity - ? WHERE product_id = ?";
                ps = con.prepareStatement(updateInventory);
                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.executeUpdate();
                ps.close();
            }

            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Map<Integer, Integer> getStockInDetailsMap(int stockInId) {
        Map<Integer, Integer> detailsMap = new HashMap<>();
        String sql = "SELECT product_id, quantity FROM store_stock_in_details WHERE store_stock_in_id = ?";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockInId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                detailsMap.put(productId, quantity);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return detailsMap;
    }

    public int getStoreIdByStockInId(int stockInId) {
        String sql = "SELECT store_id FROM store_stock_in WHERE store_stock_in_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockInId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("store_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
   public void receiveStockIn(int stockInId, int[] productIds, int[] quantities) {
    int storeId = getStoreIdByStockInId(stockInId);

    try {
        con = DBConnect.getConnection();

        String sql = "SELECT CASE WHEN pu.is_base_unit = 1 THEN ? ELSE ? * pu.conversion_value END AS store_quantity "
                   + "FROM store_stock_in_details s "
                   + "JOIN product_units pu ON s.product_id = pu.product_id AND s.unit_name = pu.unit_name "
                   + "WHERE s.store_stock_in_id = ? AND s.product_id = ?";

        String updateStoreSql = "UPDATE store_products SET quantity = quantity + ? WHERE store_id = ? AND product_id = ?";
        String insertStoreSql = "INSERT INTO store_products (store_id, product_id, quantity) VALUES (?, ?, ?)";

        for (int i = 0; i < productIds.length; i++) {
            int productId = productIds[i];
            int quantity = quantities[i];

            int storeQuantity = quantity; // default

            ps = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, quantity);
            ps.setInt(3, stockInId);
            ps.setInt(4, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                storeQuantity = rs.getInt("store_quantity");
            }
            rs.close();
            ps.close();

            ps = con.prepareStatement(updateStoreSql);
            ps.setInt(1, storeQuantity);
            ps.setInt(2, storeId);
            ps.setInt(3, productId);
            int rows = ps.executeUpdate();
            ps.close();

            if (rows == 0) {
                ps = con.prepareStatement(insertStoreSql);
                ps.setInt(1, storeId);
                ps.setInt(2, productId);
                ps.setInt(3, storeQuantity);
                ps.executeUpdate();
                ps.close();
            }
        }

        updateStatus(stockInId, 3);
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
