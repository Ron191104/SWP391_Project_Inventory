/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StoreDashboardDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreDashboardController", urlPatterns = {"/store_dashboard"})
public class StoreDashboardController extends HttpServlet {

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
        Integer storeIdObj = (Integer) request.getSession().getAttribute("storeId");

        if (storeIdObj == null) {
            response.sendRedirect("choose_store");
            return;
        }

        int storeId = storeIdObj.intValue();

        String filter = request.getParameter("filter");
        if (filter == null) {
            filter = "today";
        }

        String fromDate, toDate;
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        switch (filter) {
            case "month":
                fromDate = now.withDayOfMonth(1).format(formatter);
                toDate = now.format(formatter);
                break;
            case "week":
                fromDate = now.minusDays(7).format(formatter);
                toDate = now.format(formatter);
                break;
            default:  
                fromDate = now.format(formatter);
                toDate = now.format(formatter);
        }

        try {
            StoreDashboardDAO dao = new StoreDashboardDAO();

            int totalProducts = dao.getTotalProducts(storeId);
            int totalStockIn = dao.getTotalStoreStockIn(storeId, fromDate, toDate);
            int totalSales = dao.getTotalSales(storeId, fromDate, toDate);
            double totalRevenue = dao.getTotalRevenue(storeId, fromDate, toDate);

            List<StoreProduct> topSellingProducts = dao.getTopSellingProducts(storeId, fromDate, toDate);
            List<StoreProduct> lowStockProducts = dao.getTopLowStoreStockProducts(storeId);
            List<StoreProduct> chartData = dao.getProductSalesChart(storeId, fromDate, toDate);

            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalStockIn", totalStockIn);
            request.setAttribute("totalSales", totalSales);
            request.setAttribute("totalRevenue", totalRevenue);

            request.setAttribute("topSellingProducts", topSellingProducts);
            request.setAttribute("lowStockProducts", lowStockProducts);
            request.setAttribute("chartData", chartData);

            request.setAttribute("filter", filter);
            request.setAttribute("fromDate", fromDate);
            request.setAttribute("toDate", toDate);

            request.getRequestDispatcher("store_dashboard.jsp").forward(request, response);

        } catch (Exception e) {
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
