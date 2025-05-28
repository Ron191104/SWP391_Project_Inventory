package dal;

import java.sql.*;
import model.User;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class UserDAO {
    private final String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=Inventory;encrypt=true;trustServerCertificate=true";
    private final String jdbcUser = "sa";
    private final String jdbcPass = "123456789";

    // Kiểm tra trùng username
    public boolean checkUsernameExists(String username) throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String sql = "SELECT username FROM users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    // Hàm hash password (SHA-256, bạn có thể dùng BCrypt nếu muốn)
    public String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        md.update(salt);
        byte[] hashed = md.digest(password.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(salt) + "$" + Base64.getEncoder().encodeToString(hashed);
    }

    // Hàm lưu user vào DB
    public boolean insertUser(User user) throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String sql = "INSERT INTO users (username, password, name, email, phone, address, role, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setInt(7, user.getRole());
            ps.setString(8, user.getImage());
            return ps.executeUpdate() > 0;
        }
    }
}