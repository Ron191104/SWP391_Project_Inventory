/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InventoryStockDAO;
import dao.StoreStockInDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
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
    int stockInId = Integer.parseInt(request.getParameter("id"));

    StoreStockInDAO dao = new StoreStockInDAO();
    StoreStockIn stockIn = dao.getStockInById(stockInId);
    List<StoreStockInDetail> details = dao.getStockInDetails(stockInId);

    request.setAttribute("stockIn", stockIn);
    request.setAttribute("details", details);

    request.getRequestDispatcher("stock_out_form.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int stockInId = Integer.parseInt(request.getParameter("id"));

        StoreStockInDAO storeDAO = new StoreStockInDAO();
        InventoryStockDAO invDAO = new InventoryStockDAO();

        StoreStockIn stockIn = storeDAO.getStockInById(stockInId);
        List<StoreStockInDetail> details = storeDAO.getStockInDetails(stockInId);

        StockOut stockOut = new StockOut();
        stockOut.setStockOutDate(new Date());
        stockOut.setReason("Xuất hàng cho cửa hàng");
        stockOut.setNote(stockIn.getNote());
        stockOut.setCreatedAt(new Date());

        int stockOutId = invDAO.insertStockOut(stockOut);

        for (StoreStockInDetail d : details) {
            StockOutDetail sod = new StockOutDetail();
            sod.setStockOutId(stockOutId);
            sod.setProductId(d.getProductId());
            sod.setQuantity(d.getQuantity());
            sod.setPriceOut(d.getPriceIn());

            invDAO.insertStockOutDetail(sod);
        }

        storeDAO.approveStockIn(stockInId);

        response.sendRedirect("inventory_order_detail?id=" + stockInId);
    }
}
