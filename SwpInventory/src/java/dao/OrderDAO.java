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
import model.OrderDisplay;

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

    public List<OrderDetailsDisplay> getFullOrderDetails(int orderId) {
        List<OrderDetailsDisplay> list = new ArrayList<>();
        String sql = """
        SELECT 
            od.order_id,
            p.product_name,
            od.quantity,
            p.unit,
            od.price
        FROM order_details od
        JOIN products p ON od.product_id = p.product_id
        WHERE od.order_id = ?
    """;

        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId); // bổ sung dòng này

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetailsDisplay odd = new OrderDetailsDisplay();
                    odd.setOrderId(rs.getInt("order_id"));
                    odd.setProductName(rs.getString("product_name"));
                    odd.setQuantity(rs.getInt("quantity"));
                    odd.setUnit(rs.getString("unit"));
                    odd.setPrice(rs.getDouble("price"));

                    list.add(odd);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<OrderDisplay> getOrderDisplayList() {
        List<OrderDisplay> list = new ArrayList<>();

        String sql = """
        SELECT 
            o.order_id,
            o.order_date,
            o.note,
            o.status,
            s.supplier_name,
            COUNT(od.product_id) AS product_count
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN suppliers s ON o.supplier_id = s.supplier_id
        GROUP BY o.order_id, o.order_date, o.note, o.status, s.supplier_name
        ORDER BY o.order_id DESC
    """;

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderDisplay od = new OrderDisplay();
                od.setOrderId(rs.getInt("order_id"));
                od.setOrderDate(rs.getDate("order_date"));
                od.setNote(rs.getString("note"));
                od.setStatus(rs.getInt("status"));
                od.setSupplierName(rs.getString("supplier_name"));
                od.setProductCount(rs.getInt("product_count"));

                list.add(od);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

//Lấy đơn hàng theo nhà cung cấp
    public List<Order> getOrdersBySupplierId(int supplierId) {
        List<Order> list = new ArrayList<>();
        // DEBUG: In toàn bộ đơn hàng từ JDBC
        try (Connection conn = DBConnect.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery("SELECT * FROM orders")) {
            System.out.println("=== TOÀN BỘ ĐƠN HÀNG TRONG DB KẾT NỐI QUA JDBC ===");
            while (rs.next()) {
                System.out.println("Order ID: " + rs.getInt("order_id") + ", Supplier ID: " + rs.getInt("supplier_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String sql = "SELECT * FROM orders WHERE supplier_id = ?";
        System.out.println("⚙️ SQL Query: " + sql + " | supplier_id = " + supplierId);

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

            System.out.println("📦 Số đơn hàng tìm thấy trong DAO: " + list.size());

        } catch (Exception e) {
            System.out.println("❌ Lỗi khi lấy đơn hàng theo supplier_id:");
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

    public int getOrderStatus(int orderId) {
        String sql = "SELECT status FROM orders WHERE order_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("status");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // hoặc giá trị mặc định khác
    }
// Lấy đơn hàng theo supplierId và trạng thái (status)

    public List<Order> getOrdersBySupplierIdAndStatus(int supplierId, int status) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE supplier_id = ? AND status = ? ORDER BY order_date DESC";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            ps.setInt(2, status);
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

    public void deleteOrder(int orderId) {
        String deleteOrderDetailsSql = "DELETE FROM order_details WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";

        Connection conn = null;
        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psDetails = conn.prepareStatement(deleteOrderDetailsSql); PreparedStatement psOrder = conn.prepareStatement(deleteOrderSql)) {

                psDetails.setInt(1, orderId);
                psDetails.executeUpdate();

                psOrder.setInt(1, orderId);
                psOrder.executeUpdate();

                conn.commit();
            }
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    //hiển thị thông báo có đơn hàng mới cho nhà cung cấp
    public List<Order> getNewOrdersBySupplierId(int supplierId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE supplier_id = ? AND status = 0";
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

    public List<OrderDisplay> getOrderDisplayList(String supplierFilter) {
        List<OrderDisplay> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
        SELECT 
            o.order_id,
            o.order_date,
            o.note,
            o.status,
            s.supplier_name,
            COUNT(od.product_id) AS product_count
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN suppliers s ON o.supplier_id = s.supplier_id
    """);

        List<Object> params = new ArrayList<>();
        if (supplierFilter != null && !supplierFilter.trim().isEmpty()) {
            sql.append(" WHERE s.supplier_name = ? ");
            params.add(supplierFilter);
        }

        sql.append("""
        GROUP BY o.order_id, o.order_date, o.note, o.status, s.supplier_name
        ORDER BY o.order_id DESC
    """);

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDisplay od = new OrderDisplay();
                od.setOrderId(rs.getInt("order_id"));
                od.setOrderDate(rs.getDate("order_date"));
                od.setNote(rs.getString("note"));
                od.setStatus(rs.getInt("status"));
                od.setSupplierName(rs.getString("supplier_name"));
                od.setProductCount(rs.getInt("product_count"));
                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
