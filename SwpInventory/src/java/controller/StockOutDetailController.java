/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InventoryStockDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.StockOut;
import model.StockOutDetail;
import model.User;

/**
 *
 * @author User
 */
@WebServlet(name = "StockOutDetailController", urlPatterns = {"/stock_out_detail"})
public class StockOutDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        int stockOutId = Integer.parseInt(id);

        InventoryStockDAO dao = new InventoryStockDAO();
        UserDAO userDAO = new UserDAO(); // ✅ Thêm DAO để lấy thông tin nhân viên

        // Lấy đơn xuất kho và chi tiết
        StockOut stockOut = dao.getStockOutById(stockOutId);
        List<StockOutDetail> details = dao.getStockOutDetails(stockOutId);

        // Lấy tên sản phẩm cho từng chi tiết
        for (StockOutDetail d : details) {
            String productName = dao.getProductNameById(d.getProductId());
            d.setProductName(productName);
            String unitName = dao.getUnitByProductId(d.getProductId());
            d.setUnitName(unitName);
        }

        // ✅ Lấy thông tin nhân viên từ employeeId của stockOut
        User employee = userDAO.getUserById(stockOut.getEmployeeId());

        // Truyền dữ liệu sang JSP
        request.setAttribute("stockOut", stockOut);
        request.setAttribute("details", details);
        request.setAttribute("employee", employee); // ✅ gửi sang JSP
        request.getRequestDispatcher("stock_out_detail.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
