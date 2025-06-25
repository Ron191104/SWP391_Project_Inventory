/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Order;
import model.OrderDetails;
import model.OrderDetailsDisplay;

/**
 *
 * @author User
 */
public class OrderDAO {

    // thêm đơn hàng mới, trả về ID của đơn hàng vừa tạo
    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders (supplier_id, employee_id, order_date, status, note) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getSupplierId());
            stmt.setInt(2, order.getEmployeeId());
            stmt.setTimestamp(3, Timestamp.valueOf(order.getOrderDate()));
            stmt.setInt(4, order.getStatus());
            stmt.setString(5, order.getNote());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // thêm chi tiết đơn hàng
    public void insertOrderDetail(OrderDetails od) {
        String sql = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, od.getOrderId());
            stmt.setInt(2, od.getProductId());
            stmt.setInt(3, od.getQuantity());
            stmt.setDouble(4, od.getPrice());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Order> getOrdersByEmployeeId(int employeeId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE employee_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setSupplierId(rs.getInt("supplier_id"));
                o.setEmployeeId(rs.getInt("employee_id"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                o.setStatus(rs.getInt("status"));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM order_details WHERE order_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetails od = new OrderDetails();
                od.setOrderDetailId(rs.getInt("order_detail_id"));
                od.setOrderId(rs.getInt("order_id"));
                od.setProductId(rs.getInt("product_id"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getDouble("price"));
                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setSupplierId(rs.getInt("supplier_id"));
                o.setEmployeeId(rs.getInt("employee_id"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                o.setStatus(rs.getInt("status"));
                o.setNote(rs.getString("note"));
                return o;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetailsDisplay> getFullOrderDetails() {
        List<OrderDetailsDisplay> list = new ArrayList<>();
        String sql = """
        SELECT o.order_id, p.product_name, od.quantity, p.unit, od.price, o.note, o.status
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN products p ON od.product_id = p.product_id
        """;

        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderDetailsDisplay odd = new OrderDetailsDisplay();
                odd.setOrderId(rs.getInt("order_id"));
                odd.setProductName(rs.getString("product_name"));
                odd.setQuantity(rs.getInt("quantity"));
                odd.setUnit(rs.getString("unit"));
                odd.setPrice(rs.getDouble("price"));
                odd.setNote(rs.getString("note"));
                odd.setStatus(rs.getInt("status"));

                list.add(odd);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

//Lấy đơn hàng theo nhà cung cấp
    public List<Order> getOrdersBySupplier(int supplierId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE supplier_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setSupplierId(rs.getInt("supplier_id"));
                o.setEmployeeId(rs.getInt("employee_id"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                o.setStatus(rs.getInt("status"));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateOrderStatus(int orderId, int status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
