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
                + "sp.store_category_id, "
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
                p.setId(rs.getInt(3));
                p.setImage(rs.getString(4));
                p.setName(rs.getString(5));
                p.setBarcode(rs.getString(6));
                p.setUnit(rs.getString(8));
                p.setPrice(rs.getDouble(9));
                p.setManufacture_date(rs.getDate(12));
                p.setExpired_date(rs.getDate(13));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt(1));
                sp.setStoreId(rs.getInt(2));
                sp.setProduct(p);
                sp.setStoreCategoryId(rs.getInt(7));
                sp.setPriceOut(rs.getDouble(10));
                sp.setQuantity(rs.getInt(11));
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
                + "    sp.store_product_id, "
                + "    sp.store_id, "
                + "    p.product_id, "
                + "    p.image, "
                + "    p.product_name, "
                + "    p.barcode, "
                + "    sp.store_category_id, "
                + "    p.unit, "
                + "    p.price, "
                + "    sp.price_out, "
                + "    sp.quantity, "
                + "    p.manufacture_date, "
                + "    p.expired_date "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_id = ? AND sp.store_category_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setInt(2, storeCategoryId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt(3));
                p.setImage(rs.getString(4));
                p.setName(rs.getString(5));
                p.setBarcode(rs.getString(6));
                p.setUnit(rs.getString(8));
                p.setPrice(rs.getDouble(9));
                p.setManufacture_date(rs.getDate(12));
                p.setExpired_date(rs.getDate(13));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt(1));
                sp.setStoreId(rs.getInt(2));
                sp.setProduct(p);
                sp.setStoreCategoryId(rs.getInt(7));
                sp.setPriceOut(rs.getDouble(10));
                sp.setQuantity(rs.getInt(11));
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
                + "sp.store_category_id, "
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
                p.setId(rs.getInt(3));
                p.setImage(rs.getString(4));
                p.setName(rs.getString(5));
                p.setBarcode(rs.getString(6));
                p.setUnit(rs.getString(8));
                p.setPrice(rs.getDouble(9));
                p.setManufacture_date(rs.getDate(12));
                p.setExpired_date(rs.getDate(13));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt(1));
                sp.setStoreId(rs.getInt(2));
                sp.setProduct(p);
                sp.setStoreCategoryId(rs.getInt(7));
                sp.setPriceOut(rs.getDouble(10));
                sp.setQuantity(rs.getInt(11));
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
                + "sp.store_category_id, "
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
                p.setId(rs.getInt(3));
                p.setImage(rs.getString(4));
                p.setName(rs.getString(5));
                p.setBarcode(rs.getString(6));
                p.setUnit(rs.getString(8));
                p.setPrice(rs.getDouble(9));
                p.setManufacture_date(rs.getDate(12));
                p.setExpired_date(rs.getDate(13));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt(1));
                sp.setStoreId(rs.getInt(2));
                sp.setProduct(p);
                sp.setStoreCategoryId(rs.getInt(7));
                sp.setPriceOut(rs.getDouble(10));
                sp.setQuantity(rs.getInt(11));
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
                + "sp.store_category_id, "
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
                p.setId(rs.getInt(3));
                p.setImage(rs.getString(4));
                p.setName(rs.getString(5));
                p.setBarcode(rs.getString(6));
                p.setUnit(rs.getString(8));
                p.setPrice(rs.getDouble(9));
                p.setManufacture_date(rs.getDate(12));
                p.setExpired_date(rs.getDate(13));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt(1));
                sp.setStoreId(rs.getInt(2));
                sp.setProduct(p);
                sp.setStoreCategoryId(rs.getInt(7));
                sp.setPriceOut(rs.getDouble(10));
                sp.setQuantity(rs.getInt(11));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public StoreProduct getStoreProductById(int storeProductId) {
        String query = "SELECT "
                + "sp.store_product_id, "
                + "sp.store_id, "
                + "p.product_id, "
                + "p.image, "
                + "p.product_name, "
                + "p.barcode, "
                + "sp.store_category_id, "
                + "p.unit, "
                + "p.price, "
                + "sp.price_out, "
                + "sp.quantity, "
                + "p.manufacture_date, "
                + "p.expired_date, "
                + " p.description "
                + "FROM store_products sp JOIN products p ON sp.product_id = p.product_id WHERE sp.store_product_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeProductId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt(3));
                p.setImage(rs.getString(4));
                p.setName(rs.getString(5));
                p.setBarcode(rs.getString(6));
                p.setUnit(rs.getString(8));
                p.setPrice(rs.getDouble(9));
                p.setManufacture_date(rs.getDate(12));
                p.setExpired_date(rs.getDate(13));
                p.setDescription(rs.getString(14));

                StoreProduct sp = new StoreProduct();
                sp.setStoreProductId(rs.getInt(1));
                sp.setStoreId(rs.getInt(2));
                sp.setProduct(p);
                sp.setStoreCategoryId(rs.getInt(7));
                sp.setPriceOut(rs.getDouble(10));
                sp.setQuantity(rs.getInt(11));
                return sp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteStoreProduct(int storeProductId) {
        String query = "delete from store_products where store_product_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeProductId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addStoreProduct(int storeId, int storeCategoryId, int productId, double priceOut, int quantity) {
        String query = "INSERT INTO store_products (store_id, store_category_id, product_id, price_out, quantity) VALUES (?, ?, ?, ?, ?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setInt(2, storeCategoryId);
            ps.setInt(3, productId);
            ps.setDouble(4, priceOut);
            ps.setInt(5, quantity);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void clearProductsByStoreCategoryId(int storeId, int categoryId) {
        StoreCategoryDAO categoryDAO = new StoreCategoryDAO();
        int naCategoryId = categoryDAO.getNACategoryId(storeId);

        String sql = "UPDATE store_products SET store_category_id = ? WHERE store_id = ? AND store_category_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, naCategoryId);
            ps.setInt(2, storeId);
            ps.setInt(3, categoryId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        StoreProductDAO dao = new StoreProductDAO();
        List<StoreProduct> list = dao.getAllStoreProduct(2);
        for (StoreProduct sp : list) {
            System.out.println(sp);
        }
    }
}
