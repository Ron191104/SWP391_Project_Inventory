/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Categories;

/**
 *
 * @author ADMIN
 */
public class CategoryDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void addCategory(String name) {
        String sql = "INSERT INTO categories (category_name) VALUES (?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void deleteCategory(int id) {
    String sql = "DELETE FROM categories WHERE category_id = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    
    public void clearProductsByCategoryId(int categoryId) {
    String sql = "UPDATE products SET category_id = NULL WHERE category_id = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, categoryId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
