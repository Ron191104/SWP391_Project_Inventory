/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

/**
 *
 * @author ADMIN
 */
public class CustomerDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getPoints(int customerId) {
        String query = "SELECT point FROM customers WHERE customer_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("point");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void subtractPoints(int customerId, int points) {
        String query = "UPDATE customers SET point = point - ? WHERE customer_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, points);
            ps.setInt(2, customerId);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void addPoint(int customerId, int points) {
        String query = "UPDATE customers SET point = point + ? WHERE customer_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, points);
            ps.setInt(2, customerId);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String query = "SELECT customer_id, name, phone, point FROM customers ORDER BY customer_id DESC";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("customer_id"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                c.setPoint(rs.getInt("point"));
                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }
    
public int findCustomerIdByPhone(String phone) {
    String query = "SELECT customer_id FROM customers WHERE phone = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setString(1, phone);
        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("customer_id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1;  
}

public int insertCustomer(String name, String phone, int point) {
    String query = "INSERT INTO customers (name, phone, point) VALUES (?, ?, ?)";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, name);
        ps.setString(2, phone);
        ps.setInt(3, point);
        ps.executeUpdate();
        rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1;
}

public Customer getCustomerById(int customerId) {
    Customer c = null;
    String query = "SELECT customer_id, name, phone, point FROM customers WHERE customer_id = ?";
    try {
        con = DBConnect.getConnection();
        ps = con.prepareStatement(query);
        ps.setInt(1, customerId);
        rs = ps.executeQuery();
        if (rs.next()) {
            c = new Customer();
            c.setCustomerId(rs.getInt("customer_id"));
            c.setName(rs.getString("name"));
            c.setPhone(rs.getString("phone"));
            c.setPoint(rs.getInt("point"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return c;
}



}
