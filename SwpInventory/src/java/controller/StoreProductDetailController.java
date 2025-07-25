/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.StoreProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Categories;
import model.Category;
import model.Product;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "DetailController", urlPatterns = {"/store_product_detail"})
public class StoreProductDetailController extends HttpServlet {

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
        String didRaw = request.getParameter("did");
        if (didRaw == null || didRaw.isEmpty()) {
            response.sendRedirect("store_product_list.jsp");
            return;
        }

        int did = Integer.parseInt(didRaw);
        StoreProductDAO dao = new StoreProductDAO();

        StoreProduct detail = dao.getStoreProductById(storeId,did);
        if (detail == null) {
            response.sendRedirect("store_product_list.jsp");
            return;
        }

        CategoryDAO cdao = new CategoryDAO();
        List<Categories> listStoreCategory = cdao.getAllCategories();
        request.setAttribute("listStoreCategory", listStoreCategory);

        request.setAttribute("detail", detail);
        request.getRequestDispatcher("store_product_detail.jsp").forward(request, response);
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
