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
import model.Categories;
import model.Category;

/**
 *
 * @author ADMIN
 */
public class CategoryDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Categories> getAllCategories() {
        List<Categories> list = new ArrayList<>();
        String query = "SELECT category_id, category_name FROM categories";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Categories c = new Categories();
                c.setId(rs.getInt("category_id"));
                c.setName(rs.getString("category_name"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



}
