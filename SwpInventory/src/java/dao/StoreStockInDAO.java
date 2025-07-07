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
import model.StoreOrderDetails;
import model.StoreStockIn;
import java.sql.Statement;
import model.StoreStockInDetail;


/**
 *
 * @author ADMIN
 */
public class StoreStockInDAO {
    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<StoreStockIn> getAllByStoreId(int storeId) {
        List<StoreStockIn> list = new ArrayList<>();
        String query = "SELECT * FROM store_stock_in WHERE store_id = ? ORDER BY import_date DESC";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            rs = ps.executeQuery();

            while (rs.next()) {
                StoreStockIn s = new StoreStockIn();
                s.setId(rs.getInt("stock_in_id"));
                s.setStoreId(rs.getInt("store_id"));
                s.setNote(rs.getString("note"));
                s.setImportDate(rs.getTimestamp("import_date"));
                s.setStatus(rs.getInt("status"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insertStockIn(StoreStockIn s) {
        int newId = 0;
        String query = "INSERT INTO store_stock_in (store_id, note, status) VALUES (?, ?, ?)";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, s.getStoreId());
            ps.setString(2, s.getNote());
            ps.setInt(3, s.getStatus());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                newId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } 
        return newId;
    }

    public void insertStockInDetail(int stockInId, StoreOrderDetails d) {
        String query = "INSERT INTO store_stock_in_details (stock_in_id, product_id, quantity, price_in) VALUES (?, ?, ?, ?)";

        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, stockInId);
            ps.setInt(2, d.getProductId());
            ps.setInt(3, d.getQuantity());
            ps.setDouble(4, d.getPrice());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } 

 
    }
    
    public StoreStockIn getStockInById(int stockInId) {
    String query = "SELECT * FROM store_stock_in WHERE stock_in_id = ?";
    try{
           con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
        ps.setInt(1, stockInId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            StoreStockIn s = new StoreStockIn();
            s.setId(rs.getInt("stock_in_id"));
            s.setStoreId(rs.getInt("store_id"));
            s.setNote(rs.getString("note"));
            s.setImportDate(rs.getTimestamp("import_date"));
            s.setStatus(rs.getInt("status"));
            return s;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

public List<StoreStockInDetail> getStockInDetails(int stockInId) {
    List<StoreStockInDetail> list = new ArrayList<>();
    String query = "SELECT d.*, p.product_name FROM store_stock_in_details d " +
                   "JOIN products p ON d.product_id = p.product_id WHERE d.stock_in_id = ?";
    try {
        con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
        ps.setInt(1, stockInId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            StoreStockInDetail d = new StoreStockInDetail();
            d.setId(rs.getInt("id"));
            d.setStockInId(rs.getInt("stock_in_id"));
            d.setProductId(rs.getInt("product_id"));
            d.setQuantity(rs.getInt("quantity"));
            d.setPriceIn(rs.getDouble("price_in"));
            d.setProductName(rs.getString("product_name"));
            list.add(d);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


}
