package controller;

import dao.StoreInventoryDAO;
import model.StoreInventory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/store-inventory-statistics")
public class StoreInventoryStatisticServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=Inventory";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASS = "2910";

    private Connection conn;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
        } catch (Exception e) {
            throw new ServletException("Cannot connect to DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StoreInventoryDAO dao = new StoreInventoryDAO(conn);
        try {
            // Sử dụng hàm getAllStoreInventories() thay vì getStoreInventoryStatistics()
            List<StoreInventory> inventoryList = dao.getAllStoreInventories();
            request.setAttribute("inventoryList", inventoryList);
            request.getRequestDispatcher("store_inventory_statistics.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        try {
            if (conn != null && !conn.isClosed()) conn.close();
        } catch (Exception ignored) {}
    }
}