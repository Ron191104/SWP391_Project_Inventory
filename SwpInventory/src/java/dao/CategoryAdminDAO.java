package dao;

import dal.DBConnect;
import java.sql.*;
import java.util.*;
import model.Category;

public class CategoryAdminDAO {
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        try (Connection conn = DBConnect.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()) {
                Category c = new Category(
                    rs.getInt("category_id"),
                    rs.getString("category_name")
                );
                list.add(c);
            }
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }

    public void addCategory(String categoryName) {
        String sql = "INSERT INTO categories (category_name) VALUES (?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            ps.executeUpdate();
        } catch(Exception e) { e.printStackTrace(); }
    }

    public void updateCategory(int categoryId, String categoryName) {
        String sql = "UPDATE categories SET category_name=? WHERE category_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        } catch(Exception e) { e.printStackTrace(); }
    }

    public void deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.executeUpdate();
        } catch(Exception e) { e.printStackTrace(); }
    }
}