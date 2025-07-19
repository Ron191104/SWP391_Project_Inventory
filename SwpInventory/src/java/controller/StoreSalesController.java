/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.StoreDAO;
import dao.StoreProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.StoreOrderDetails;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "StoreSaleController", urlPatterns = {"/sales"})

public class StoreSalesController extends HttpServlet {

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

        String barcode = request.getParameter("barcode");
        String categoryRaw = request.getParameter("categoryId");
        String pageRaw = request.getParameter("page");

        int categoryId = -1;
        if (categoryRaw != null && !categoryRaw.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryRaw);
            } catch (NumberFormatException e) {
                categoryId = -1;
            }
        }

        int page = 1;
        int itemsPerPage = 12;
        if (pageRaw != null && !pageRaw.isEmpty()) {
            try {
                page = Integer.parseInt(pageRaw);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * itemsPerPage;

        StoreProductDAO productDAO = new StoreProductDAO();
        List<StoreProduct> listProduct;
        int totalItems;

        if (barcode != null && !barcode.trim().isEmpty()) {
            listProduct = productDAO.findByBarcodeLike(storeId, barcode);
            totalItems = listProduct.size();
            request.setAttribute("searchedBarcode", barcode);
            request.setAttribute("paginationEnabled", false);
        } else if (categoryId != -1) {
            listProduct = productDAO.getStoreProductByCategoryWithPaging(storeId, categoryId, offset, itemsPerPage);
            totalItems = productDAO.countStoreProductByCategory(storeId, categoryId);
            request.setAttribute("paginationEnabled", true);
        } else {
            listProduct = productDAO.getStoreProductByPage(storeId, offset, itemsPerPage);
            totalItems = productDAO.getTotalStoreProductCount(storeId);
            request.setAttribute("paginationEnabled", true);
        }

        int totalPages = (int) Math.ceil(totalItems * 1.0 / itemsPerPage);

        String cartKey = "saleCart_" + storeId;
        List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
        request.setAttribute("cart", cart);

        StoreDAO sdao = new StoreDAO();
        CategoryDAO cdao = new CategoryDAO();

        request.setAttribute("storeProduct", listProduct);
        request.setAttribute("listStore", sdao.getAllStore());
        request.setAttribute("listStoreCategory", cdao.getAllCategories());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("tag", categoryId);

        request.getRequestDispatcher("sales.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        String cartKey = "saleCart_" + storeId;
        List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(item -> item.getProductId() == productId);
        } else if ("increase".equals(action) || "decrease".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            for (StoreOrderDetails od : cart) {
                if (od.getProductId() == productId) {
                    if ("increase".equals(action)) {
                        od.setQuantity(od.getQuantity() + 1);
                    } else if ("decrease".equals(action) && od.getQuantity() > 1) {
                        od.setQuantity(od.getQuantity() - 1);
                    }
                    break;
                }
            }
            
        } else {
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null) {
                int productId = Integer.parseInt(productIdStr);
                StoreProductDAO productDAO = new StoreProductDAO();
                StoreProduct storeProduct = productDAO.getStoreProductById(storeId, productId);

                if (storeProduct != null) {
                    boolean exists = false;
                    for (StoreOrderDetails od : cart) {
                        if (od.getProductId() == productId) {
                            od.setQuantity(od.getQuantity() + 1);
                            exists = true;
                            break;
                        }
                    }

                    if (!exists) {
                        StoreOrderDetails newItem = new StoreOrderDetails();
                        newItem.setProductId(productId);
                        newItem.setQuantity(1);
                        String priceParam = request.getParameter("price");
                        double price = storeProduct.getPriceOut(); // fallback
                        price = Double.parseDouble(priceParam);
                        newItem.setPrice(price);

                        newItem.setUnit(storeProduct.getProduct().getUnit());
                        cart.add(newItem);
                    }
                }
            }
        }

        session.setAttribute(cartKey, cart);

        StoreProductDAO productDAO = new StoreProductDAO();
        List<StoreProduct> listProduct = productDAO.getAllStoreProduct(storeId);
        StoreDAO sdao = new StoreDAO();

        request.setAttribute("storeProduct", listProduct);
        request.setAttribute("cart", cart);
        request.setAttribute("listStore", sdao.getAllStore());
        session.setAttribute("storeProductAllPage", productDAO.getAllStoreProduct(storeId));

        response.sendRedirect("sales");
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
