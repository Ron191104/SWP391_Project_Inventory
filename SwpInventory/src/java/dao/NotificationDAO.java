package dao;

import java.sql.*;
import java.util.*;
import dal.DBConnect;
import model.Notification;

public class NotificationDAO {

    public static List<Notification> getNotificationsByUser(int userId) {
        List<Notification> list = new ArrayList<>();
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "SELECT TOP 10 * FROM notifications WHERE user_id = ? ORDER BY created_at DESC");) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Notification n = new Notification(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("message"),
                    rs.getBoolean("is_read"),
                    rs.getTimestamp("created_at").toString()
                );
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void insertNotification(int userId, String message) {
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO notifications (user_id, message) VALUES (?, ?)");) {
            stmt.setInt(1, userId);
            stmt.setString(2, message);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void markAllAsRead(int userId) {
    try (Connection conn = DBConnect.getConnection();
         PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0")) {
        stmt.setInt(1, userId);
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
}