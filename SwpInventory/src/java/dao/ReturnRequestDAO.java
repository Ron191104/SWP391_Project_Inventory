package dao;

import model.ReturnRequest;
import model.ReturnRequestDetail;
import dal.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReturnRequestDAO {

    public int createReturnRequest(ReturnRequest req, List<ReturnRequestDetail> details) {
        String insertMain = "INSERT INTO return_requests (supplier_id, employee_id, reason, note) VALUES (?, ?, ?, ?)";
        String insertDetail = "INSERT INTO return_request_details (return_id, product_id, quantity) VALUES (?, ?, ?)";

        Connection conn = null;
        PreparedStatement psMain = null;
        PreparedStatement psDetail = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false);

            // Insert into return_requests
            psMain = conn.prepareStatement(insertMain, Statement.RETURN_GENERATED_KEYS);
            psMain.setInt(1, req.getSupplierId());
            psMain.setInt(2, req.getEmployeeId());
            psMain.setString(3, req.getReason());
            psMain.setString(4, req.getNote());
            psMain.executeUpdate();

            rs = psMain.getGeneratedKeys();
            int returnId = 0;
            if (rs.next()) {
                returnId = rs.getInt(1);
            }

            // Insert into return_request_details
            psDetail = conn.prepareStatement(insertDetail);
            for (ReturnRequestDetail d : details) {
                psDetail.setInt(1, returnId);
                psDetail.setInt(2, d.getProductId());
                psDetail.setInt(3, d.getQuantity());
                psDetail.addBatch();
            }
            psDetail.executeBatch();

            conn.commit();
            return returnId;

        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return -1;

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (psMain != null) {
                    psMain.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (psDetail != null) {
                    psDetail.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Lấy danh sách yêu cầu trả hàng theo nhà cung cấp
    public List<ReturnRequest> getReturnRequestsBySupplierId(int supplierId) {
        List<ReturnRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM return_requests WHERE supplier_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReturnRequest r = new ReturnRequest();
                r.setId(rs.getInt("return_id"));  // ✅ Sửa lại tên cột
                r.setSupplierId(rs.getInt("supplier_id"));
                r.setEmployeeId(rs.getInt("employee_id"));
                r.setReason(rs.getString("reason"));
                r.setNote(rs.getString("note"));
                r.setCreatedDate(rs.getTimestamp("created_at"));  // ✅ Sửa lại tên cột
                r.setStatus(rs.getInt("status"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái yêu cầu (1 = duyệt, 2 = từ chối)
    public boolean updateRequestStatus(int id, int status) {
        String sql = "UPDATE return_requests SET status = ? WHERE id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // (Tuỳ chọn) Lấy chi tiết các sản phẩm trong 1 yêu cầu
    public List<ReturnRequestDetail> getReturnRequestDetails(int returnId) {
        List<ReturnRequestDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM return_request_details WHERE return_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, returnId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReturnRequestDetail d = new ReturnRequestDetail();
                d.setReturnId(rs.getInt("return_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
