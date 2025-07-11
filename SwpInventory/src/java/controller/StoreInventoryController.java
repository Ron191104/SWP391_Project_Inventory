/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.StoreDAO;
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
import model.Store;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreInventoryController", urlPatterns = {"/store_inventory"})
public class StoreInventoryController extends HttpServlet {

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

        try {
            String idRaw = request.getParameter("id");
            Integer categoryId = null;
            if (idRaw != null && !idRaw.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(idRaw);
                } catch (NumberFormatException e) {
                    categoryId = null;
                }
            }

            int page = 1;
            int itemPerPage = 15;
            String pageRaw = request.getParameter("page");
            if (pageRaw != null && !pageRaw.isEmpty()) {
                try {
                    page = Integer.parseInt(pageRaw);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int offset = (page - 1) * itemPerPage;

            StoreProductDAO dao = new StoreProductDAO();
            List<StoreProduct> listProduct;
            int totalItems;

            if (categoryId != null) {
                listProduct = dao.getStoreProductByCategoryWithPaging(storeId, categoryId, offset, itemPerPage);
                totalItems = dao.countStoreProductByCategory(storeId, categoryId);
            } else {
                listProduct = dao.getStoreProductByPage(storeId, offset, itemPerPage);
                totalItems = dao.getTotalStoreProductCount(storeId);
            }

            int totalPages = (int) Math.ceil(totalItems * 1.0 / itemPerPage);

            CategoryDAO cdao = new CategoryDAO();
            List<Categories> listStoreCategory = cdao.getAllCategories();

            StoreDAO sdao = new StoreDAO();
            List<Store> listStore = sdao.getAllStore();
            List<StoreProduct> productList = dao.getProductsByStoreId(storeId);
            request.setAttribute("productList", productList);
            request.setAttribute("listStore", listStore);
            request.setAttribute("storeProduct", listProduct);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("tag", categoryId);
            request.setAttribute("listStoreCategory", listStoreCategory);

            request.getRequestDispatcher("store_inventory.jsp").forward(request, response);
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
