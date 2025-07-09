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
@WebServlet(name="StoreStockInConfirmController", urlPatterns={"/store_stock_in_confirm"})
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
//   HttpSession session = request.getSession();
//    Integer storeId = (Integer) session.getAttribute("storeId");
//
//    if (storeId == null) {
//        request.getRequestDispatcher("store_stock_in_confirm.jsp").forward(request, response);
//        return;
//    }
//
//    String cartKey = "cart_" + storeId;
//    List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
//    String note = request.getParameter("note");
//
//    if (cart == null || cart.isEmpty()) {
//        request.setAttribute("errorMessage", "Giỏ hàng null");
//    } else {
//        request.setAttribute("successMessage", "Tạo đơn nhập hàng thành công" + storeId);
//        session.removeAttribute(cartKey);
//    }
//
//    request.getRequestDispatcher("store_stock_in_confirm.jsp").forward(request, response);   
    
      HttpSession session = request.getSession();
    Integer storeId = (Integer) session.getAttribute("storeId");

    // Lấy giỏ hàng riêng theo chi nhánh
    String cartKey = "cart_" + storeId;
    List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
    String note = request.getParameter("note");

    // Kiểm tra dữ liệu đầu vào
    if (storeId == null || cart == null || cart.isEmpty()) {
        request.setAttribute("errorMessage", "Thiếu thông tin, không thể tạo đơn.");
        request.getRequestDispatcher("store_stock_in_confirm.jsp").forward(request, response);
        return;
    }

    // Tạo đơn nhập chính
    StoreStockInDAO dao = new StoreStockInDAO();
    StoreStockIn stockIn = new StoreStockIn();
    stockIn.setStoreId(storeId);
    stockIn.setNote(note);
    stockIn.setStatus(0); // Trạng thái mặc định: đang xử lý

    // Lưu đơn nhập vào DB
    int stockInId = dao.insertStockIn(stockIn); // DAO sẽ return id tự tăng

    // Thêm chi tiết đơn nhập
    for (StoreOrderDetails d : cart) {
        dao.insertStockInDetail(stockInId, d);
    }

    // Xoá giỏ hàng
    session.removeAttribute(cartKey);

    // Thông báo thành công
    request.setAttribute("successMessage", "Đã tạo đơn nhập #" + stockInId);
    request.getRequestDispatcher("store_stock_in_confirm.jsp").forward(request, response);
}
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
