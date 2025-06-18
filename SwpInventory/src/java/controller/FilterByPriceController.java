/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Categories;
import model.Product;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="FilterByPriceController", urlPatterns={"/FilterByPriceController"})
public class FilterByPriceController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String minPriceRaw = request.getParameter("minPrice");
        String maxPriceRaw = request.getParameter("maxPrice");
        String filterType = request.getParameter("filterType");

        double minPrice = 0;
        double maxPrice = Double.MAX_VALUE; 

        if (minPriceRaw != null && !minPriceRaw.isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceRaw);
            } catch (NumberFormatException e) {
                minPrice = 0;
            }
        }

        if (maxPriceRaw != null && !maxPriceRaw.isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceRaw);
            } catch (NumberFormatException e) {
                maxPrice = Double.MAX_VALUE;
            }
        }

        ProductDAO dao = new ProductDAO();
        List<Product> productList = new ArrayList<>();

        if ("in".equals(filterType)) {
            productList = dao.filterByPriceIn(minPrice, maxPrice);
        } else if ("out".equals(filterType)) {
            productList = dao.filterByPriceOut(minPrice, maxPrice);
        }

        List<Categories> categoryList = dao.getAllCategories();

        request.setAttribute("listC", categoryList);
        request.setAttribute("listP", productList);
        request.getRequestDispatcher("product_list.jsp").forward(request, response);
    }
    
     

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
