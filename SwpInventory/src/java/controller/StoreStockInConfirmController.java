/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StoreStockInDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.StoreOrderDetails;
import model.StoreStockIn;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreStockInConfirmController", urlPatterns = {"/store_stock_in_confirm"})
public class StoreStockInConfirmController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        String cartKey = "cart_" + storeId;
        List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
        String note = request.getParameter("note");
        if (storeId == null || cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Thiếu thông tin, không thể tạo đơn.");
            request.getRequestDispatcher("store_stock_in_confirm.jsp").forward(request, response);
            return;
        }
        StoreStockInDAO dao = new StoreStockInDAO();
        StoreStockIn stockIn = new StoreStockIn();
        stockIn.setStoreId(storeId);
        stockIn.setNote(note);
        stockIn.setStatus(0);

        int stockInId = dao.insertStockIn(stockIn); 

        for (StoreOrderDetails d : cart) {
            dao.insertStockInDetail(stockInId, d);
        }

        session.removeAttribute(cartKey);
        request.setAttribute("successMessage", "Đã tạo đơn nhập hàng " + stockInId);
        request.getRequestDispatcher("store_stock_in_confirm.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
