package dao;

import dal.DBConnect;
import model.SystemLog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SystemLogDAO {
    public void insertLog(String username, String action, String details) {
        String sql = "INSERT INTO system_logs (username, action, details) VALUES (?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, action);
            ps.setString(3, details);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<SystemLog> getAllLogs() {
        List<SystemLog> list = new ArrayList<>();
        String sql = "SELECT * FROM system_logs ORDER BY log_time DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SystemLog log = new SystemLog(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("action"),
                    rs.getString("details"),
                    rs.getTimestamp("log_time")
                );
                list.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}