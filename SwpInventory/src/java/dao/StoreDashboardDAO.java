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
import model.StoreProduct;


/**
 *
 * @author ADMIN
 */
public class StoreDashboardDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getTotalProducts(int storeId) {
        String query = "SELECT COUNT(DISTINCT product_id) FROM store_products WHERE store_id = ?";
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

    public int getTotalStoreStockIn(int storeId, String fromDate, String toDate) {
        String query = "SELECT COUNT(*) FROM store_stock_in WHERE store_id = ? AND import_date BETWEEN ? AND ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setString(2, fromDate);
            ps.setString(3, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalSales(int storeId, String fromDate, String toDate) {
        String query = "SELECT COUNT(*) FROM sales WHERE store_id = ? AND sale_date BETWEEN ? AND ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setString(2, fromDate);
            ps.setString(3, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRevenue(int storeId, String fromDate, String toDate) {
        String query = "SELECT ISNULL(SUM(total_amount), 0) FROM sales WHERE store_id = ? AND sale_date BETWEEN ? AND ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            ps.setString(2, fromDate);
            ps.setString(3, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

 public List<StoreProduct> getProductSalesChart(int storeId, String fromDate, String toDate) {
    List<StoreProduct> list = new ArrayList<>();
    String query = "SELECT "
            + "p.product_id, p.product_name, p.image, p.barcode, "
            + "SUM(sd.quantity) AS total_quantity "
            + "FROM sales_details sd "
            + "JOIN sales s ON sd.sale_id = s.sale_id "
            + "JOIN products p ON sd.product_id = p.product_id "
            + "WHERE s.store_id = ? AND s.sale_date BETWEEN ? AND ? "
            + "GROUP BY p.product_id, p.product_name, p.image, p.barcode "
            + "ORDER BY total_quantity DESC";

    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);
        ps.setString(2, fromDate);
        ps.setString(3, toDate);

        rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("product_id"));
            p.setName(rs.getString("product_name"));
            p.setImage(rs.getString("image"));
            p.setBarcode(rs.getString("barcode"));

            StoreProduct sp = new StoreProduct();
            sp.setProduct(p);
            sp.setQuantity(rs.getInt("total_quantity"));  

            list.add(sp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}



    public List<StoreProduct> getTopSellingProducts(int storeId, String fromDate, String toDate) {
    List<StoreProduct> list = new ArrayList<>();
    String query = "SELECT TOP 5 "
            + "p.product_id, p.product_name, p.image, p.barcode, "
            + "SUM(sd.quantity) AS total_sold "
            + "FROM sales_details sd "
            + "JOIN sales s ON sd.sale_id = s.sale_id "
            + "JOIN products p ON sd.product_id = p.product_id "
            + "WHERE s.store_id = ? AND s.sale_date BETWEEN ? AND ? "
            + "GROUP BY p.product_id, p.product_name, p.image, p.barcode "
            + "ORDER BY total_sold DESC";

    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);
        ps.setString(2, fromDate);
        ps.setString(3, toDate);

        rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("product_id"));
            p.setName(rs.getString("product_name"));
            p.setBarcode(rs.getString("barcode"));
            p.setImage(rs.getString("image"));

            StoreProduct sp = new StoreProduct();
            sp.setProduct(p);
            sp.setQuantity(rs.getInt("total_sold")); // Lưu số lượng bán ra vào quantity

            list.add(sp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


   public List<StoreProduct> getTopLowStoreStockProducts(int storeId) {
    List<StoreProduct> list = new ArrayList<>();
    String query = "SELECT TOP 5 "
            + "sp.store_product_id, sp.store_id, sp.quantity, "
            + "p.product_id, p.product_name, p.barcode, p.image "
            + "FROM store_products sp "
            + "JOIN products p ON sp.product_id = p.product_id "
            + "WHERE sp.store_id = ? "
            + "ORDER BY sp.quantity ASC";

    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, storeId);

        rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("product_id"));
            p.setName(rs.getString("product_name"));
            p.setBarcode(rs.getString("barcode"));
            p.setImage(rs.getString("image"));

            StoreProduct sp = new StoreProduct();
            sp.setStoreProductId(rs.getInt("store_product_id"));
            sp.setStoreId(rs.getInt("store_id"));
            sp.setQuantity(rs.getInt("quantity"));
            sp.setProduct(p);

            list.add(sp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

}
