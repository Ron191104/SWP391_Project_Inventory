/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.StockIn;
import model.StockInDetail;
import model.StockOut;
import model.StockOutDetail;

/**
 *
 * @author User
 */
public class InventoryStockDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<StockIn> getStockInListByDateRange(Date from, Date to) {
        List<StockIn> list = new ArrayList<>();
        String sql = "SELECT * FROM stock_in WHERE stock_in_date BETWEEN ? AND ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, new Timestamp(from.getTime()));
            ps.setTimestamp(2, new Timestamp(to.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StockIn s = new StockIn();
                    s.setStockInId(rs.getInt("stock_in_id"));
                    s.setSupplierId(rs.getInt("supplier_id"));
                    s.setEmployeeId(rs.getInt("employee_id"));
                    s.setStockInDate(rs.getTimestamp("stock_in_date"));
                    s.setNote(rs.getString("note"));
                    s.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getSupplierNameById(int supplierId) {
        String sql = "SELECT supplier_name FROM suppliers WHERE supplier_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("supplier_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Không rõ";
    }

    public List<StockOut> getStockOutListByDateRange(Date from, Date to) {
        List<StockOut> list = new ArrayList<>();
        String sql = "SELECT * FROM stock_out WHERE stock_out_date BETWEEN ? AND ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, new Timestamp(from.getTime()));
            ps.setTimestamp(2, new Timestamp(to.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StockOut s = new StockOut();
                    s.setStockOutId(rs.getInt("stock_out_id"));
                    s.setEmployeeId(rs.getInt("employee_id"));
                    s.setStockOutDate(rs.getTimestamp("stock_out_date"));
                    s.setReason(rs.getString("reason"));
                    s.setNote(rs.getString("note"));
                    s.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StockInDetail> getStockInDetails(int stockInId) {
        List<StockInDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM stock_in_details WHERE stock_in_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, stockInId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StockInDetail d = new StockInDetail();
                d.setStockInDetailId(rs.getInt("stock_in_detail_id"));
                d.setStockInId(rs.getInt("stock_in_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setPriceIn(rs.getDouble("price_in"));
                d.setManufactureDate(rs.getDate("manufacture_date"));
                d.setExpiredDate(rs.getDate("expired_date"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StockOutDetail> getStockOutDetails(int stockOutId) {
        List<StockOutDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM stock_out_details WHERE stock_out_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, stockOutId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StockOutDetail d = new StockOutDetail();
                d.setStockOutDetailId(rs.getInt("stock_out_detail_id"));
                d.setStockOutId(rs.getInt("stock_out_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setPriceOut(rs.getDouble("price_out"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public StockIn getStockInById(int id) {
        String sql = "SELECT * FROM stock_in WHERE stock_in_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StockIn s = new StockIn();
                s.setStockInId(rs.getInt("stock_in_id"));
                s.setSupplierId(rs.getInt("supplier_id"));
                s.setEmployeeId(rs.getInt("employee_id"));
                s.setStockInDate(rs.getTimestamp("stock_in_date"));
                s.setNote(rs.getString("note"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public StockOut getStockOutById(int id) {
        String sql = "SELECT * FROM stock_out WHERE stock_out_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StockOut s = new StockOut();
                s.setStockOutId(rs.getInt("stock_out_id"));
                s.setEmployeeId(rs.getInt("employee_id"));
                s.setStockOutDate(rs.getTimestamp("stock_out_date"));
                s.setReason(rs.getString("reason"));
                s.setNote(rs.getString("note"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getProductNameById(int productId) {
        String sql = "SELECT product_name FROM products WHERE product_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("product_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getUnitByProductId(int productId) {
        String sql = "SELECT unit FROM products WHERE product_id = ?";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("unit");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int insertStockOut(StockOut stockOut) {
        String sql = "INSERT INTO stock_out (employee_id, stock_out_date, reason, note, created_at) "
                + "VALUES (?, ?, ?, ?, GETDATE())";
        String[] returnId = {"stock_out_id"};

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, returnId)) {

            ps.setInt(1, stockOut.getEmployeeId());
            ps.setTimestamp(2, new java.sql.Timestamp(stockOut.getStockOutDate().getTime()));
            ps.setString(3, stockOut.getReason());
            ps.setString(4, stockOut.getNote());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public void insertStockOutDetail(StockOutDetail sod) {
        String sql = "INSERT INTO stock_out_details (stock_out_id, product_id, quantity, price_out) "
                + "VALUES (?, ?, ?, ?);";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, sod.getStockOutId());
            ps.setInt(2, sod.getProductId());
            ps.setInt(3, sod.getQuantity());
            ps.setDouble(4, sod.getPriceOut());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<StockOut> getAllStockOut() {
        List<StockOut> list = new ArrayList<>();
        String sql = "SELECT * FROM stock_out ORDER BY stock_out_id DESC";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StockOut so = new StockOut();
                so.setStockOutId(rs.getInt("stock_out_id"));
                so.setEmployeeId(rs.getInt("employee_id"));
                so.setStockOutDate(rs.getTimestamp("stock_out_date"));
                so.setReason(rs.getString("reason"));
                so.setNote(rs.getString("note"));
                so.setCreatedAt(rs.getTimestamp("created_at"));
                so.setStatus(rs.getInt("status"));
                list.add(so);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StockOut> getStockOutByStatus(int status) {
        List<StockOut> list = new ArrayList<>();
        String sql = "SELECT * FROM stock_out WHERE status = ? ORDER BY stock_out_id DESC";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StockOut so = new StockOut();
                so.setStockOutId(rs.getInt("stock_out_id"));
                so.setEmployeeId(rs.getInt("employee_id"));
                so.setStockOutDate(rs.getTimestamp("stock_out_date"));
                so.setReason(rs.getString("reason"));
                so.setNote(rs.getString("note"));
                so.setCreatedAt(rs.getTimestamp("created_at"));
                so.setStatus(rs.getInt("status"));
                list.add(so);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void exportStock(int stockOutId) {
        updateStatus(stockOutId, 1);
        Map<Integer, Integer> details = getStockOutDetailsMap(stockOutId);
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
    public void updateStatus(int stockOutId, int status) {
        String query = "UPDATE stock_out SET status = ? WHERE stock_out_id = ?";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, status);
            ps.setInt(2, stockOutId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Map<Integer, Integer> getStockOutDetailsMap(int stockOutId) {
        Map<Integer, Integer> detailsMap = new HashMap<>();
        String sql = "SELECT product_id, quantity FROM stock_out_details WHERE stock_out_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, stockOutId);
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

}
