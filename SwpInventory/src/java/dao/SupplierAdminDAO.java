package dao;

import dal.DBConnect;
import java.sql.*;
import java.util.*;
import model.SupplierAdmin;

public class SupplierAdminDAO {
    public List<SupplierAdmin> getAllSuppliers() {
        List<SupplierAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM suppliers";
        try (Connection conn = DBConnect.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()) {
                SupplierAdmin s = new SupplierAdmin(
                    rs.getInt("supplier_id"),
                    rs.getString("supplier_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address")
                );
                list.add(s);
            }
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }

    public void addSupplier(String name, String phone, String email, String address) {
        String sql = "INSERT INTO suppliers (supplier_name, phone, email, address) VALUES (?,?,?,?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.executeUpdate();
        } catch(Exception e) { e.printStackTrace(); }
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
        } catch(Exception e) { e.printStackTrace(); }
    }

    public void deleteSupplier(int id) {
        String sql = "DELETE FROM suppliers WHERE supplier_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(Exception e) { e.printStackTrace(); }
    }
}