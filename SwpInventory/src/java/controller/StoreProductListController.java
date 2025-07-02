/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StoreCategoryDAO;
import dao.StoreProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.StoreCategory;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreProductListController", urlPatterns = {"/store_product_list"})
public class StoreProductListController extends HttpServlet {

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

        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        if (storeId == null) {
            response.sendRedirect("choose_store");
            return;
        }
        StoreCategoryDAO categoryDAO = new StoreCategoryDAO();
        List<StoreCategory> listStoreCategory = categoryDAO.getAllStoreCategory(storeId);
        request.setAttribute("listStoreCategory", listStoreCategory);

        String idRaw = request.getParameter("id");
        Integer categoryId = null;
        if (idRaw != null && !idRaw.isEmpty()) {
            categoryId = Integer.parseInt(idRaw);
        }

        StoreProductDAO productDAO = new StoreProductDAO();
        List<StoreProduct> listProduct;

        if (categoryId != null) {
            listProduct = productDAO.getStoreProductByCategory(storeId, categoryId);
        } else {
            listProduct = productDAO.getAllStoreProduct(storeId);
        }

        for (StoreCategory c : listStoreCategory) {
            int quantity = 0;
            for (StoreProduct sp : productDAO.getAllStoreProduct(storeId)) {
                if (sp.getStoreCategoryId() == c.getStoreCategoryId()) {
                    quantity += sp.getQuantity();
                }
            }
            c.setQuantity(quantity);
        }

        request.setAttribute("storeProduct", listProduct);
        request.setAttribute("tag", categoryId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("store_product_list.jsp");
        dispatcher.forward(request, response);
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
