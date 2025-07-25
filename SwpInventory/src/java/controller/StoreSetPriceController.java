/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StoreDAO;
import dao.StoreProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.Store;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreSetPriceController", urlPatterns = {"/store_set_price"})
public class StoreSetPriceController extends HttpServlet {

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
        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        if (storeId == null) {
            response.sendRedirect("choose_store");
            return;
        }

        StoreProductDAO dao = new StoreProductDAO();
        List<StoreProduct> productList = dao.getAllStoreProduct(storeId);
 StoreDAO sdao = new StoreDAO();
        List<Store> list = sdao.getAllStore();

        request.setAttribute("listStore", list);
        request.setAttribute("storeProduct", productList);
        request.getRequestDispatcher("store_set_price.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        if (storeId == null) {
            response.sendRedirect("choose_store");
            return;
        }
        Map<String, String[]> parameterMap = request.getParameterMap();
        StoreProductDAO dao = new StoreProductDAO();

        for (String key : parameterMap.keySet()) {
            if (key.startsWith("newPrices[")) {
                try {
                    int storeProductId = Integer.parseInt(key.substring(10, key.length() - 1));
                    double newPrice = Double.parseDouble(request.getParameter(key));
                    dao.updatePriceOut(storeProductId, newPrice, storeId);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }

        response.sendRedirect("store_set_price?updated=true");
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
