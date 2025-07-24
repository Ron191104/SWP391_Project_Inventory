/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InventoryStockDAO;
import dao.ProductDAO;
import dao.StoreDAO;
import dao.StoreStockInDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import model.Product;
import model.StockOut;
import model.StockOutDetail;
import model.Store;
import model.StoreStockIn;
import model.StoreStockInDetail;

/**
 *
 * @author User
 */
@WebServlet(name = "InventoryOrderDetailController", urlPatterns = {"/inventory_order_detail"})
public class InventoryOrderDetailController extends HttpServlet {

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
        int stockInId = Integer.parseInt(id);
        StoreStockInDAO dao = new StoreStockInDAO();

        StoreStockIn stockIn = dao.getStockInById(stockInId);
        List<StoreStockInDetail> details = dao.getStockInDetails(stockInId);

        double totalAmount = 0;
        for (StoreStockInDetail d : details) {
            totalAmount += d.getQuantity() * d.getPriceIn();
        }

        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("stockIn", stockIn);
        request.setAttribute("details", details);
        request.getRequestDispatcher("inventory_order_detail.jsp").forward(request, response);
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
        InventoryStockDAO invDAO = new InventoryStockDAO();
        StoreStockInDAO sidao = new StoreStockInDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        StoreStockIn stockIn = sidao.getStockInById(id);
        List<StoreStockInDetail> details = sidao.getStockInDetails(id);
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("id");

        if (employeeId == null) {
            request.setAttribute("error", "Bạn cần đăng nhập trước");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if ("approve".equals(action)) {
            sidao.updateStatus(id, 1);
            StockOut stockOut = new StockOut();
            stockOut.setStockOutDate(new Date());
            stockOut.setReason("Xuất hàng cho cửa hàng");
            stockOut.setNote(stockIn.getNote());
            stockOut.setCreatedAt(new Date());
            stockOut.setEmployeeId(employeeId); // ✅ Gán employeeId

            int stockOutId = invDAO.insertStockOut(stockOut);

            for (StoreStockInDetail d : details) {
                StockOutDetail sod = new StockOutDetail();
                sod.setStockOutId(stockOutId);
                sod.setProductId(d.getProductId());
                sod.setQuantity(d.getQuantity());
                sod.setPriceOut(d.getPriceIn());
                sod.setProductName(d.getProductName());
                sod.setUnitName(d.getUnitName());

                invDAO.insertStockOutDetail(sod);
            }

        } else if ("reject".equals(action)) {
            sidao.updateStatus(id, 2);
        }
        response.sendRedirect("inventory_order_detail?id=" + id);
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
