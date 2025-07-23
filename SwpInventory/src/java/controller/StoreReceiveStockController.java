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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.StoreStockIn;
import model.StoreStockInDetail;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreReceiveStockController", urlPatterns = {"/store_stock_in_receive"})
public class StoreReceiveStockController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StoreReceiveStockController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StoreReceiveStockController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String idRaw = request.getParameter("id");

        if (idRaw == null || idRaw.isEmpty()) {
            response.sendRedirect("store_stock_in_list");
            return;
        }

        int stockInId = Integer.parseInt(idRaw);
        StoreStockInDAO dao = new StoreStockInDAO();

        StoreStockIn stockIn = dao.getStockInById(stockInId);
        List<StoreStockInDetail> details = dao.getStockInDetails(stockInId);

        request.setAttribute("storeStockIn", stockIn);
        request.setAttribute("details", details);

        request.getRequestDispatcher("store_stock_in_receive.jsp").forward(request, response);
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
        int stockInId = Integer.parseInt(request.getParameter("storeStockInId"));
        String[] productIdsRaw = request.getParameterValues("productId");
        String[] quantitiesRaw = request.getParameterValues("actualQuantity");

        int[] productIds = new int[productIdsRaw.length];
        int[] quantities = new int[quantitiesRaw.length];

        for (int i = 0; i < productIdsRaw.length; i++) {
            productIds[i] = Integer.parseInt(productIdsRaw[i]);
            quantities[i] = Integer.parseInt(quantitiesRaw[i]);
        }

        StoreStockInDAO dao = new StoreStockInDAO();
        dao.receiveStockIn(stockInId, productIds, quantities);

        response.sendRedirect("store_stock_in_list");
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
