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
        return searchLogs(null, null, null);
    }

    public List<SystemLog> searchLogs(String username, String action, Timestamp fromTimestamp) {
        List<SystemLog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM system_logs WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (username != null && !username.trim().isEmpty()) {
            sql.append(" AND username LIKE ?");
            params.add("%" + username.trim() + "%");
        }

        if (action != null && !action.trim().isEmpty()) {
            sql.append(" AND action LIKE ?");
            params.add("%" + action.trim() + "%");
        }

        if (fromTimestamp != null) {
            sql.append(" AND log_time >= ?");
            params.add(fromTimestamp);
        }

        sql.append(" ORDER BY log_time DESC");

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

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
