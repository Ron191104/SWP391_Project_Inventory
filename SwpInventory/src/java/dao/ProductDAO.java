package dao;

import dal.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.Categories;

public class ProductDAO {

    Connection con = null;
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
                list.add(new Product(
                    rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                    rs.getInt(5), rs.getDouble(6), rs.getInt(7), rs.getString(8),
                    rs.getDate(9), rs.getDate(10), rs.getString(11), rs.getString(12)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    public List<Categories> getAllCategories() {
        List<Categories> list = new ArrayList<>();
        String query = "SELECT * FROM categories";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Categories(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductByCategory(String id) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM products WHERE category_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                    rs.getInt(5), rs.getDouble(6), rs.getInt(7), rs.getString(8),
                    rs.getDate(9), rs.getDate(10), rs.getString(11), rs.getString(12)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Product> getProductsBySupplierId(String supplierId) {
    List<Product> list = new ArrayList<>();
    String query = "SELECT * FROM products WHERE supplier_id = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setString(1, supplierId);
        rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Product(
                rs.getInt(1),     // id
                rs.getString(2),  // name
                rs.getString(3),  // barcode
                rs.getInt(4),     // category_id
                rs.getInt(5),     // supplier_id
                rs.getDouble(6),  // price
                rs.getInt(7),     // quantity
                rs.getString(8),  // unit
                rs.getDate(9),    // manufacture_date
                rs.getDate(10),   // expired_date
                rs.getString(11), // image
                rs.getString(12)  // description
            ));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM products WHERE product_name LIKE ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                    rs.getInt(5), rs.getDouble(6), rs.getInt(7), rs.getString(8),
                    rs.getDate(9), rs.getDate(10), rs.getString(11), rs.getString(12)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductByID(String id) {
        String query = "SELECT * FROM products WHERE product_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                    rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                    rs.getInt(5), rs.getDouble(6), rs.getInt(7), rs.getString(8),
                    rs.getDate(9), rs.getDate(10), rs.getString(11), rs.getString(12)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addProduct(String name, String barcode, int category_id, int supplier_id, double price,
                           int quantity, String unit, Date manufacture_date, Date expired_date,
                           String image, String description) {
        String query = "INSERT INTO products (product_name, barcode, category_id, supplier_id, price, quantity, unit, manufacture_date, expired_date, image, description) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, barcode);
            ps.setInt(3, category_id);
            ps.setInt(4, supplier_id);
            ps.setDouble(5, price);
            ps.setInt(6, quantity);
            ps.setString(7, unit);
            ps.setDate(8, new java.sql.Date(manufacture_date.getTime()));
            ps.setDate(9, new java.sql.Date(expired_date.getTime()));
            ps.setString(10, image);
            ps.setString(11, description);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String id) {
        String query = "DELETE FROM products WHERE product_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> filterByPrice(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE price >= ? AND price <= ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                    rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                    rs.getInt(5), rs.getDouble(6), rs.getInt(7), rs.getString(8),
                    rs.getDate(9), rs.getDate(10), rs.getString(11), rs.getString(12)
                ));
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
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
