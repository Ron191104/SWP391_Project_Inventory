package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=Inventory;encrypt=true;trustServerCertificate=true";
        String username = "sa";
        String password = "2910";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, username, password);
    }
}
