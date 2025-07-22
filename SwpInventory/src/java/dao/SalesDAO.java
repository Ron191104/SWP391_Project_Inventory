/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Sale;
import model.SaleDetail;

/**
 *
 * @author ADMIN
 */
public class SalesDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public double getAmountPerPoint() {
        String query = "SELECT amount_per_point FROM point_change";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("amount_per_point");
            }
        } catch (Exception e) {
        }
        return 1000;
    }

    public int createSale(int customerId, int storeId, double totalAmount, String note) {
        String query = "INSERT INTO sales (customer_id, store_id, total_amount, note) VALUES (?, ?, ?, ?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, customerId);
            ps.setInt(2, storeId);
            ps.setDouble(3, totalAmount);
            ps.setString(4, note);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return -1;
    }

    public void insertSaleDetail(int saleId, int productId, int quantity, double priceOut) {
        String query = "INSERT INTO sales_details (sale_id, product_id, quantity, price_out) VALUES (?, ?, ?, ?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, saleId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setDouble(4, priceOut);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Sale> getAllSales() {
        List<Sale> list = new ArrayList<>();
        String query = "SELECT s.sale_id, s.sale_date, s.total_amount, c.name AS customer_name "
                + "FROM sales s "
                + "LEFT JOIN customers c ON s.customer_id = c.customer_id "
                + "ORDER BY s.sale_id DESC";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Sale sale = new Sale();
                sale.setSaleId(rs.getInt("sale_id"));
                sale.setSaleDate(rs.getTimestamp("sale_date"));
                sale.setTotalAmount(rs.getDouble("total_amount"));

                String customerName = rs.getString("customer_name");
                if (customerName == null) {
                    customerName = "Khách lẻ";
                }
                sale.setCustomerName(customerName);
                list.add(sale);
            }

        } catch (Exception e) {
        }

        return list;
    }

    public List<SaleDetail> getSaleDetailsBySaleId(int saleId) {
        List<SaleDetail> list = new ArrayList<>();
        String query = "SELECT sd.sale_detail_id, sd.sale_id, sd.product_id, sd.price_out, sd.quantity,\n"
                + "       p.product_name,\n"
                + "       pu.unit_name AS base_unit\n"
                + "FROM sales_details sd\n"
                + "JOIN products p ON sd.product_id = p.product_id\n"
                + "JOIN product_units pu ON p.product_id = pu.product_id AND pu.is_base_unit = 1\n"
                + "WHERE sd.sale_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, saleId);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleDetail detail = new SaleDetail();
                detail.setSaleDetailId(rs.getInt("sale_detail_id"));
                detail.setSaleId(rs.getInt("sale_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setPriceOut(rs.getDouble("price_out"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setProductName(rs.getString("product_name"));
                detail.setUnit(rs.getString("base_unit"));
                list.add(detail);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public int createSaleAllowNull(int customerId, int storeId, double totalAmount, String note) {
        String query = "INSERT INTO sales (customer_id, store_id, total_amount, note) VALUES (?, ?, ?, ?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            if (customerId == 0) {
                ps.setNull(1, java.sql.Types.INTEGER);
            } else {
                ps.setInt(1, customerId);
            }

            ps.setInt(2, storeId);
            ps.setDouble(3, totalAmount);
            ps.setString(4, note);

            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return -1;
    }

    public List<Sale> getSalesByStore(int storeId) {
        List<Sale> list = new ArrayList<>();
        String query = "SELECT s.sale_id, s.sale_date, s.total_amount, c.name AS customer_name "
                + "FROM sales s "
                + "LEFT JOIN customers c ON s.customer_id = c.customer_id "
                + "WHERE s.store_id = ? "
                + "ORDER BY s.sale_id DESC";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Sale sale = new Sale();
                sale.setSaleId(rs.getInt("sale_id"));
                sale.setSaleDate(rs.getTimestamp("sale_date"));
                sale.setTotalAmount(rs.getDouble("total_amount"));

                String customerName = rs.getString("customer_name");
                if (customerName == null) {
                    customerName = "Khách lẻ";
                }
                sale.setCustomerName(customerName);

                list.add(sale);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Sale getSaleById(int saleId) {
        Sale sale = null;
        String query = "SELECT sale_id, customer_id,store_id, sale_date, total_amount "
                + "FROM sales WHERE sale_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, saleId);
            rs = ps.executeQuery();
            if (rs.next()) {
                sale = new Sale();
                sale.setSaleId(rs.getInt("sale_id"));
                sale.setCustomerId(rs.getInt("customer_id"));
                sale.setStoreId(rs.getInt("store_id")); 
                sale.setSaleDate(rs.getTimestamp("sale_date"));
                sale.setTotalAmount(rs.getDouble("total_amount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sale;
    }

}
