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
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
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

    public void addProduct(String name, String barcode, int category_id, int supplier_id, double price_in, double price_out, int quantity, String unit, Date manufacture_date, Date expired_date, String image, String description) {
        String query = "INSERT INTO products (product_name, barcode, category_id, supplier_id, price_in, price_out, quantity, unit, manufacture_date, expired_date, image, description) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, barcode);
            ps.setInt(3, category_id);
            ps.setInt(4, supplier_id);
            ps.setDouble(5, price_in);
            ps.setDouble(6, price_out);
            ps.setInt(7, quantity);
            ps.setString(8, unit);
            ps.setDate(9, new java.sql.Date(manufacture_date.getTime()));
            ps.setDate(10, new java.sql.Date(expired_date.getTime()));

            ps.setString(11, image);
            ps.setString(12, description);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String id) {
        String query = "delete from products where product_id=?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {

        }
    }

    public List<Product> filterByPriceIn(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();
        String query = "select * from products WHERE price_in >= ? AND price_in <= ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getString(9),
                        rs.getDate(10), rs.getDate(11), rs.getString(12), rs.getString(13));

                products.add(product);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> filterByPriceOut(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();
        String query = "select * from products WHERE price_out >= ? AND price_out <= ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getString(9),
                        rs.getDate(10), rs.getDate(11), rs.getString(12), rs.getString(13));

                products.add(product);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public int countProductByCategory(int categoryId) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }


}
