/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.StoreDAO;
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
import model.Categories;
import model.Category;
import model.Store;
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
        String idRaw = request.getParameter("id");
        Integer categoryId = null;
        if (idRaw != null && !idRaw.isEmpty()) {
            categoryId = Integer.parseInt(idRaw);
        }

        int page = 1;
        int itemPerPage = 8;
        String pageRaw = request.getParameter("page");
        if (pageRaw != null && !pageRaw.isEmpty()) {
            try {
                page = Integer.parseInt(pageRaw);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int totalPage;
        StoreProductDAO productDAO = new StoreProductDAO();
        List<StoreProduct> listProduct;
        CategoryDAO cdao = new CategoryDAO();
        List<Categories> listStoreCategory = cdao.getAllCategories();
        int offset = (page - 1) * itemPerPage;

        if (categoryId != null) {
            listProduct = productDAO.getStoreProductByCategoryWithPaging(storeId, categoryId, offset, itemPerPage);
            totalPage = productDAO.countStoreProductByCategory(storeId, categoryId);
        } else {
            listProduct = productDAO.getStoreProductByPage(storeId, offset, itemPerPage);
            totalPage = productDAO.getTotalStoreProductCount(storeId);
        }

        int totalPages = (int) Math.ceil(totalPage * 1.0 / itemPerPage);

        StoreDAO dao = new StoreDAO();
        List<Store> list = dao.getAllStore();

        request.setAttribute("listStore", list);
        request.setAttribute("storeProduct", listProduct);
        request.setAttribute("tag", categoryId);
        request.setAttribute("listStoreCategory", listStoreCategory);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("store_product_list.jsp").forward(request, response);
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
