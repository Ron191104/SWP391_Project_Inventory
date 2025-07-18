/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StoreDAO;
import dao.StoreStockInDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Store;
import model.StoreStockIn;
import model.StoreStockInDetail;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreStockInDetailController", urlPatterns = {"/store_stock_in_detail"})
public class StoreStockInDetailController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

        String idRaw = request.getParameter("id");

        if (idRaw == null || idRaw.isEmpty()) {
            response.sendRedirect("store_stock_in_list");
            return;
        }

        try {
            int stockInId = Integer.parseInt(idRaw);
            StoreStockInDAO dao = new StoreStockInDAO();

            StoreStockIn stockIn = dao.getStockInById(stockInId);
            List<StoreStockInDetail> details = dao.getStockInDetails(stockInId);
            StoreDAO sdao = new StoreDAO();
            List<Store> listStore = sdao.getAllStore();

            double totalAmount = 0;
            for (StoreStockInDetail d : details) {
                totalAmount += d.getQuantity() * d.getPriceIn();
            }

            request.setAttribute("listStore", listStore);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("listStore", listStore);
            request.setAttribute("stockIn", stockIn);
            request.setAttribute("details", details);
            request.getRequestDispatcher("store_stock_in_detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
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
