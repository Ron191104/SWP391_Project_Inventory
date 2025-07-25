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
    // Lấy thông tin yêu cầu trả hàng theo returnId và chi tiết trả hàng

    public ReturnRequest getReturnRequestById(int returnId) {
        String sql = "SELECT * FROM return_requests WHERE return_id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, returnId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ReturnRequest r = new ReturnRequest();
                r.setId(rs.getInt("return_id"));
                r.setSupplierId(rs.getInt("supplier_id"));
                r.setEmployeeId(rs.getInt("employee_id"));
                r.setReason(rs.getString("reason"));
                r.setNote(rs.getString("note"));
                r.setCreatedDate(rs.getTimestamp("created_at"));
                r.setStatus(rs.getInt("status"));

                // Lấy các chi tiết trả hàng
                List<ReturnRequestDetail> details = getReturnRequestDetailInfo(returnId);
                r.setDetails(details);

                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật trạng thái yêu cầu (1 = duyệt, 2 = từ chối)
    public boolean updateRequestStatus(int id, int status) {
        String sql = "UPDATE return_requests SET status = ? WHERE return_id = ?";
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

    // Lấy tất cả yêu cầu trả hàng
    public List<ReturnRequest> getAllReturnRequests() {
        List<ReturnRequest> list = new ArrayList<>();
        String sql = "SELECT rr.*, u.name AS employee_name FROM return_requests rr "
                + "JOIN users u ON rr.employee_id = u.id "
                + "ORDER BY rr.return_id DESC";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReturnRequest rr = new ReturnRequest();
                rr.setId(rs.getInt("return_id"));
                rr.setSupplierId(rs.getInt("supplier_id"));
                rr.setEmployeeId(rs.getInt("employee_id"));
                rr.setReason(rs.getString("reason"));
                rr.setNote(rs.getString("note"));
                rr.setCreatedDate(rs.getTimestamp("created_at"));
                rr.setStatus(rs.getInt("status"));

                // Lấy tên nhân viên từ bảng users
                rr.setEmployeeName(rs.getString("employee_name"));

                list.add(rr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy danh sách đơn hoàn trả đã duyệt (đã gửi đi)
    public List<ReturnRequest> getApprovedReturnRequests() {
        List<ReturnRequest> list = new ArrayList<>();

        String sql = "SELECT rr.*, s.supplier_name, u.name AS employee_name "
                + "FROM return_requests rr "
                + "JOIN suppliers s ON rr.supplier_id = s.supplier_id "
                + "JOIN users u ON rr.employee_id = u.id "
                + "WHERE rr.status = 1 "
                + // Chỉ lấy đơn đã duyệt (đã gửi đi)
                "ORDER BY rr.created_at DESC";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReturnRequest rr = new ReturnRequest();
                rr.setId(rs.getInt("return_id"));
                rr.setSupplierId(rs.getInt("supplier_id"));
                rr.setEmployeeId(rs.getInt("employee_id"));
                rr.setReason(rs.getString("reason"));
                rr.setNote(rs.getString("note"));
                rr.setCreatedDate(rs.getTimestamp("created_at"));
                rr.setStatus(rs.getInt("status"));

                // Gán thông tin hiển thị thêm
                rr.setSupplierName(rs.getString("supplier_name"));
                rr.setEmployeeName(rs.getString("employee_name"));

                list.add(rr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<ReturnRequestDetail> getReturnRequestDetailInfo(int returnId) {
        List<ReturnRequestDetail> list = new ArrayList<>();
        String sql = "SELECT d.product_id, p.product_name, d.quantity, p.unit, p.price "
                + "FROM return_request_details d "
                + "JOIN products p ON d.product_id = p.product_id "
                + "WHERE d.return_id = ?";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, returnId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReturnRequestDetail d = new ReturnRequestDetail();
                d.setProductId(rs.getInt("product_id"));
                d.setProductName(rs.getString("product_name"));
                d.setQuantity(rs.getInt("quantity"));
                d.setUnit(rs.getString("unit"));
                d.setPrice(rs.getDouble("price"));
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ReturnRequest> getReturnRequestsBySupplierIdAndStatus(int supplierId, int status) {
        List<ReturnRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM return_requests WHERE supplier_id = ? AND status = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            ps.setInt(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReturnRequest r = new ReturnRequest();
                r.setId(rs.getInt("return_id"));
                r.setSupplierId(rs.getInt("supplier_id"));
                r.setEmployeeId(rs.getInt("employee_id"));
                r.setReason(rs.getString("reason"));
                r.setNote(rs.getString("note"));
                r.setCreatedDate(rs.getTimestamp("created_at"));
                r.setStatus(rs.getInt("status"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void cancelReturnRequest(int returnId) {
        String sql = "UPDATE return_request SET status = 3 WHERE id = ?";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, returnId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
