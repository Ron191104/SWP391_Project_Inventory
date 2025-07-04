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
import model.Product;
import model.Store;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
public class StoreProductDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<StoreProduct> getAllStoreProduct(int storeId) {
        List<StoreProduct> list = new ArrayList<>();
        String query = "SELECT "
                + "sp.store_product_id, "
                + "sp.store_id, "
                + "p.product_id, "
                + "p.image, "
                + "p.product_name, "
                + "p.barcode, "
                + "p.category_id, "
                + "p.unit, "
                + "p.price, "
                + "sp.price_out, "
                + "sp.quantity, "
                + "p.manufacture_date, "
                + "p.expired_date "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_id = ?;";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);

            rs = ps.executeQuery();
            while (rs.next()) {

                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setImage(rs.getString("image"));
                p.setName(rs.getString("product_name"));
                p.setBarcode(rs.getString("barcode"));
                p.setCategory_id(rs.getInt("category_id"));
                p.setUnit(rs.getString("unit"));
                p.setPrice(rs.getDouble("price"));
                p.setManufacture_date(rs.getDate("manufacture_date"));
                p.setExpired_date(rs.getDate("expired_date"));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt("store_product_id"));
                sp.setStoreId(rs.getInt("store_id"));
                sp.setProduct(p);
                sp.setPriceOut(rs.getDouble("price_out"));
                sp.setQuantity(rs.getInt("quantity"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return list;
    }

    public List<StoreProduct> getStoreProductByCategory(int storeId, int storeCategoryId) {
        List<StoreProduct> list = new ArrayList<>();
        String query = "SELECT "
                + "sp.store_product_id, "
                + "sp.store_id, "
                + "p.product_id, "
                + "p.image, "
                + "p.product_name, "
                + "p.barcode, "
                + "p.category_id, "
                + "p.unit, "
                + "p.price, "
                + "sp.price_out, "
                + "sp.quantity, "
                + "p.manufacture_date, "
                + "p.expired_date "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_id = ? AND p.category_id=?;";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setInt(2, storeCategoryId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setImage(rs.getString("image"));
                p.setName(rs.getString("product_name"));
                p.setBarcode(rs.getString("barcode"));
                p.setCategory_id(rs.getInt("category_id"));
                p.setUnit(rs.getString("unit"));
                p.setPrice(rs.getDouble("price"));
                p.setManufacture_date(rs.getDate("manufacture_date"));
                p.setExpired_date(rs.getDate("expired_date"));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt("store_product_id"));
                sp.setStoreId(rs.getInt("store_id"));
                sp.setProduct(p);
                sp.setPriceOut(rs.getDouble("price_out"));
                sp.setQuantity(rs.getInt("quantity"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }

        return list;
    }

    public List<StoreProduct> filterByPriceIn(double minPrice, double maxPrice, int storeId) {
        List<StoreProduct> list = new ArrayList<>();
        String query = "SELECT "
                + "sp.store_product_id, "
                + "sp.store_id, "
                + "p.product_id, "
                + "p.image, "
                + "p.product_name, "
                + "p.barcode, "
                + "p.category_id, "
                + "p.unit, "
                + "p.price, "
                + "sp.price_out, "
                + "sp.quantity, "
                + "p.manufacture_date, "
                + "p.expired_date "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_id = ? AND p.price >= ? AND p.price <= ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setDouble(2, minPrice);
            ps.setDouble(3, maxPrice);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setImage(rs.getString("image"));
                p.setName(rs.getString("product_name"));
                p.setBarcode(rs.getString("barcode"));
                p.setCategory_id(rs.getInt("category_id"));
                p.setUnit(rs.getString("unit"));
                p.setPrice(rs.getDouble("price"));
                p.setManufacture_date(rs.getDate("manufacture_date"));
                p.setExpired_date(rs.getDate("expired_date"));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt("store_product_id"));
                sp.setStoreId(rs.getInt("store_id"));
                sp.setProduct(p);
                sp.setPriceOut(rs.getDouble("price_out"));
                sp.setQuantity(rs.getInt("quantity"));
                list.add(sp);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StoreProduct> filterByPriceOut(double minPrice, double maxPrice, int storeId) {
        List<StoreProduct> list = new ArrayList<>();
        String query = "SELECT "
                + "sp.store_product_id, "
                + "sp.store_id, "
                + "p.product_id, "
                + "p.image, "
                + "p.product_name, "
                + "p.barcode, "
                + "p.category_id, "
                + "p.unit, "
                + "p.price, "
                + "sp.price_out, "
                + "sp.quantity, "
                + "p.manufacture_date, "
                + "p.expired_date "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_id = ? AND sp.price_out >= ? AND sp.price_out <= ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setDouble(2, minPrice);
            ps.setDouble(3, maxPrice);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setImage(rs.getString("image"));
                p.setName(rs.getString("product_name"));
                p.setBarcode(rs.getString("barcode"));
                p.setCategory_id(rs.getInt("category_id"));
                p.setUnit(rs.getString("unit"));
                p.setPrice(rs.getDouble("price"));
                p.setManufacture_date(rs.getDate("manufacture_date"));
                p.setExpired_date(rs.getDate("expired_date"));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt("store_product_id"));
                sp.setStoreId(rs.getInt("store_id"));
                sp.setProduct(p);
                sp.setPriceOut(rs.getDouble("price_out"));
                sp.setQuantity(rs.getInt("quantity"));
                list.add(sp);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StoreProduct> searchByName(String txtSearch, int storeId) {
        List<StoreProduct> list = new ArrayList<>();
        String query = "SELECT "
                + "sp.store_product_id, "
                + "sp.store_id, "
                + "p.product_id, "
                + "p.image, "
                + "p.product_name, "
                + "p.barcode, "
                + "p.category_id, "
                + "p.unit, "
                + "p.price, "
                + "sp.price_out, "
                + "sp.quantity, "
                + "p.manufacture_date, "
                + "p.expired_date "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_id = ? AND p.product_name LIKE ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setString(2, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setImage(rs.getString("image"));
                p.setName(rs.getString("product_name"));
                p.setBarcode(rs.getString("barcode"));
                p.setCategory_id(rs.getInt("category_id"));
                p.setUnit(rs.getString("unit"));
                p.setPrice(rs.getDouble("price"));
                p.setManufacture_date(rs.getDate("manufacture_date"));
                p.setExpired_date(rs.getDate("expired_date"));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt("store_product_id"));
                sp.setStoreId(rs.getInt("store_id"));
                sp.setProduct(p);
                sp.setPriceOut(rs.getDouble("price_out"));
                sp.setQuantity(rs.getInt("quantity"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public StoreProduct getStoreProductById(int id) {
        StoreProduct sp = null;
        String query = "SELECT sp.store_product_id, sp.price_out, sp.quantity, "
                + "p.product_id, p.product_name, p.barcode, p.unit, p.price, "
                + "p.image, p.manufacture_date, p.expired_date, p.category_id, p.description "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id "
                + "WHERE sp.store_product_id = ?";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setBarcode(rs.getString("barcode"));
                p.setUnit(rs.getString("unit"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setManufacture_date(rs.getDate("manufacture_date"));
                p.setExpired_date(rs.getDate("expired_date"));
                p.setCategory_id(rs.getInt("category_id"));
                p.setDescription(rs.getString("description"));

                sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt("store_product_id"));
                sp.setPriceOut(rs.getDouble("price_out"));
                sp.setQuantity(rs.getInt("quantity"));
                sp.setProduct(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sp;
    }

    public void deleteStoreProduct(int storeId, int storeProductId) {
        String query = "DELETE FROM store_products WHERE store_product_id = ? AND store_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeProductId);
            ps.setInt(2, storeId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public List<StoreProduct> getStoreProductByPage(int storeId, int offset, int limit) {
    List<StoreProduct> list = new ArrayList<>();
    String query = "SELECT "
            + "sp.store_product_id, "
            + "sp.store_id, "
            + "p.product_id, "
            + "p.image, "
            + "p.product_name, "
            + "p.barcode, "
            + "p.category_id, "
            + "p.unit, "
            + "p.price, "
            + "sp.price_out, "
            + "sp.quantity, "
            + "p.manufacture_date, "
            + "p.expired_date "
            + "FROM store_products sp "
            + "JOIN products p ON sp.product_id = p.product_id "
            + "WHERE sp.store_id = ? "
            + "ORDER BY sp.store_product_id "
            + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);
        ps.setInt(2, offset);
        ps.setInt(3, limit);

        rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("product_id"));
            p.setImage(rs.getString("image"));
            p.setName(rs.getString("product_name"));
            p.setBarcode(rs.getString("barcode"));
            p.setCategory_id(rs.getInt("category_id"));
            p.setUnit(rs.getString("unit"));
            p.setPrice(rs.getDouble("price"));
            p.setManufacture_date(rs.getDate("manufacture_date"));
            p.setExpired_date(rs.getDate("expired_date"));

            StoreProduct sp = new StoreProduct();
            sp.setStoreProductId(rs.getInt("store_product_id"));
            sp.setStoreId(rs.getInt("store_id"));
            sp.setProduct(p);
            sp.setPriceOut(rs.getDouble("price_out"));
            sp.setQuantity(rs.getInt("quantity"));

            list.add(sp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    
    public int getTotalStoreProductCount(int storeId) {
    String query = "SELECT COUNT(*) FROM store_products WHERE store_id = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);

        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

    
    public int countStoreProductByCategory(int storeId, int categoryId) {
    String query = "SELECT COUNT(*) FROM store_products sp "
                 + "JOIN products p ON sp.product_id = p.product_id "
                 + "WHERE sp.store_id = ? AND p.category_id = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);
        ps.setInt(2, categoryId);

        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

    
    public List<StoreProduct> getStoreProductByCategoryWithPaging(int storeId, int categoryId, int offset, int limit) {
    List<StoreProduct> list = new ArrayList<>();
    String query = "SELECT sp.store_product_id, sp.store_id, p.product_id, p.image, p.product_name, p.barcode, "
                 + "p.category_id, p.unit, p.price, sp.price_out, sp.quantity, p.manufacture_date, p.expired_date "
                 + "FROM store_products sp "
                 + "JOIN products p ON sp.product_id = p.product_id "
                 + "WHERE sp.store_id = ? AND p.category_id = ? "
                 + "ORDER BY sp.store_product_id "
                 + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);
        ps.setInt(2, categoryId);
        ps.setInt(3, offset);
        ps.setInt(4, limit);

        rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("product_id"));
            p.setImage(rs.getString("image"));
            p.setName(rs.getString("product_name"));
            p.setBarcode(rs.getString("barcode"));
            p.setCategory_id(rs.getInt("category_id"));
            p.setUnit(rs.getString("unit"));
            p.setPrice(rs.getDouble("price"));
            p.setManufacture_date(rs.getDate("manufacture_date"));
            p.setExpired_date(rs.getDate("expired_date"));

            StoreProduct sp = new StoreProduct();
            sp.setStoreProductId(rs.getInt("store_product_id"));
            sp.setStoreId(rs.getInt("store_id"));
            sp.setProduct(p);
            sp.setPriceOut(rs.getDouble("price_out"));
            sp.setQuantity(rs.getInt("quantity"));

            list.add(sp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public static void main(String[] args) {
        StoreProductDAO dao = new StoreProductDAO();
        List<StoreProduct> list = dao.getAllStoreProduct(2);
        for (StoreProduct sp : list) {
            System.out.println(sp);
        }
    }
}
