/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DBConnect;
import dao.InventoryStockDAO;
import dao.StoreStockInDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.StockOut;
import model.StockOutDetail;
import model.StoreStockIn;
import model.StoreStockInDetail;

/**
 *
 * @author User
 */
@WebServlet(name = "StockOutServlet", urlPatterns = {"/stock_out"})
public class StockOutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int stockOutId = Integer.parseInt(request.getParameter("id"));
        InventoryStockDAO invDAO = new InventoryStockDAO();

        StockOut stockOut = invDAO.getStockOutById(stockOutId);
        List<StockOutDetail> details = invDAO.getStockOutDetails(stockOutId);
        for (StockOutDetail d : details) {
            String productName = invDAO.getProductNameById(d.getProductId());
            d.setProductName(productName);
            String unitName = invDAO.getUnitByProductId(d.getProductId());
            d.setUnitName(unitName);
        }
        Map<Integer, String> storeNameMap = new HashMap<>();
        String sql = "SELECT store_id, store_name FROM stores";
        try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                storeNameMap.put(rs.getInt("store_id"), rs.getString("store_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("storeNameMap", storeNameMap);

        request.setAttribute("so", stockOut);
        request.setAttribute("details", details);

        request.getRequestDispatcher("stock_out_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int stockOutId = Integer.parseInt(request.getParameter("id"));
        InventoryStockDAO invDAO = new InventoryStockDAO();
        List<StockOutDetail> details = invDAO.getStockOutDetails(stockOutId);
        for (StockOutDetail d : details) {
            int newQuantity = Integer.parseInt(request.getParameter("quantity_" + d.getProductId()));
            invDAO.updateStockOutDetailQuantity(stockOutId, d.getProductId(), newQuantity);
        }

        invDAO.exportStock(stockOutId);
        invDAO.updateStockOutDate(stockOutId);

        response.sendRedirect("stock_out_list");
    }
}
