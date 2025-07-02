/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestDBConnect {
    public static void main(String[] args) {
        // Thay đổi các thông tin bên dưới cho đúng với database của bạn
        String url = "jdbc:sqlserver://localhost:1433;databaseName=Inventory";
        String user = "sa";
        String password = "123"; // thay bằng mật khẩu thật

        try {
            // Nạp driver JDBC
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Kết nối tới database
            Connection conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Kết nối database thành công!");
                conn.close();
            }

        } catch (Exception e) {
            System.out.println("Kết nối thất bại: " + e.getMessage());
            e.printStackTrace();
        }
    }
}