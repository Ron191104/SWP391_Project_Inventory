package dao;

import dal.DBConnect;
import model.SupplierAdmin;
import java.sql.*;
import java.util.*;

public class SupplierAdminDAO {
    public List<SupplierAdmin> getAllSuppliers() {
        List<SupplierAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM suppliers ORDER BY supplier_id";
        try (Connection conn = DBConnect.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                SupplierAdmin s = new SupplierAdmin(
                    rs.getInt("supplier_id"),
                    rs.getString("supplier_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getInt("status")
                );
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addSupplier(String name, String phone, String email, String address) {
        String sql = "INSERT INTO suppliers (supplier_name, phone, email, address, status) VALUES (?, ?, ?, ?, 1)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateSupplier(int id, String name, String phone, String email, String address) {
        String sql = "UPDATE suppliers SET supplier_name=?, phone=?, email=?, address=? WHERE supplier_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Hàm check tên đã tồn tại (kể cả đã bị xóa - status = 0)
    public boolean isSupplierNameExists(String name, Integer excludeId) {
        String sql = "SELECT COUNT(*) FROM suppliers WHERE supplier_name = ?";
        if (excludeId != null) {
            sql += " AND supplier_id != ?";
        }
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            if (excludeId != null) {
                ps.setInt(2, excludeId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Xóa mềm
    public void softDeleteSupplier(int id) {
        String sql = "UPDATE suppliers SET status = 0 WHERE supplier_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Khôi phục
    public void restoreSupplier(int id) {
        String sql = "UPDATE suppliers SET status = 1 WHERE supplier_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
