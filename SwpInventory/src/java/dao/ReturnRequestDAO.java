package dao;

import model.ReturnRequest;
import model.ReturnRequestDetail;
import dal.DBConnect;

import java.sql.*;
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
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return -1;

        } finally {
            try {
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (psMain != null) psMain.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (psDetail != null) psDetail.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
