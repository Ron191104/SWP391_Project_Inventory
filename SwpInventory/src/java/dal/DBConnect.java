/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Nạp driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Chuỗi kết nối - thay đổi theo cấu hình máy bạn
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Inventory;user=sa;password=123";
            conn = DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}