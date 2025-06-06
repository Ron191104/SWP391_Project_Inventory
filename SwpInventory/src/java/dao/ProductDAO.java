/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;

import com.sun.jdi.connect.spi.Connection;
import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import dao.ProductDAO;
import model.Categories;

/**
 *
 * @author ADMIN
 */
public class ProductDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getString(9),
                        rs.getDate(10), rs.getDate(11), rs.getString(12), rs.getString(13)));
            }
        } catch (Exception e) {

        }

        return list;
    }

    public List<Categories> getAllCategories() {
        List<Categories> list = new ArrayList<>();
        String query = "Select*from categories;";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Categories(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {

        }

        return list;
    }

    public List<Product> getProductByCategory(String id) {
        List<Product> list = new ArrayList<>();
        String query = "select *from products where category_id=?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getString(9),
                        rs.getDate(10), rs.getDate(11), rs.getString(12), rs.getString(13)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "select*from products where [product_name] like ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getString(9),
                        rs.getDate(10), rs.getDate(11), rs.getString(12), rs.getString(13)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductByID(String id) {
        String query = "select*from products where product_id=?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(
                        rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getString(9),
                        rs.getDate(10), rs.getDate(11), rs.getString(12), rs.getString(13));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
        

}
