package dal;

import java.sql.*;
import model.User;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class UserDAO {

    private final String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=Inventory;encrypt=true;trustServerCertificate=true";
    private final String jdbcUser = "sa";
    private final String jdbcPass = "123";

    // Kiểm tra trùng username
    public boolean checkUsernameExists(String username) throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String sql = "SELECT username FROM users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass); PreparedStatement ps = conn.prepareStatement(sql)) {
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

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    // Hàm lấy user theo email và password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        try {
            Connection conn = DBConnect.getConnection();
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Lấy dữ liệu từ ResultSet và tạo đối tượng User đầy đủ
                String username = rs.getString("username");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                int role = rs.getInt("role");
                String image = rs.getString("image");
                user = new User(
                        username,
                        password, // Dữ liệu password vừa truyền vào, hoặc lấy từ DB nếu đã hash
                        name,
                        email,
                        phone,
                        address,
                        role,
                        image
                );
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Hàm lấy user theo username và password (THÊM HÀM NÀY CHO ĐĂNG NHẬP BẰNG TÊN ĐĂNG NHẬP)
    public User getUserByUsernameAndPassword(String username, String password) {
        User user = null;
        try {
            Connection conn = DBConnect.getConnection();
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Lấy dữ liệu từ ResultSet và tạo đối tượng User đầy đủ
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                int role = rs.getInt("role");
                String image = rs.getString("image");
                user = new User(
                        username,
                        password, // Dữ liệu password vừa truyền vào, hoặc lấy từ DB nếu đã hash
                        name,
                        email,
                        phone,
                        address,
                        role,
                        image
                );
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
