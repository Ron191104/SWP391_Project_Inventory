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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.StoreOrderDetails;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="StoreStockInController", urlPatterns={"/store_stock_in"})
public class StoreStockInController extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
   
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
 ProductDAO dao = new ProductDAO();
        request.setAttribute("listP", dao.getAllProduct());
        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        if (storeId != null) {
            String cartKey = "cart_" + storeId;
            List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
            request.setAttribute("cart", cart);
        }
        request.getRequestDispatcher("store_stock_in.jsp").forward(request, response);    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
         HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        if (storeId == null) {
            request.setAttribute("error", "Không xác định được chi nhánh.");
            request.getRequestDispatcher("store_stock_in.jsp").forward(request, response);
            return;
        }
    String productIdStr = request.getParameter("productId");
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    ProductDAO dao = new ProductDAO();
    Product p = dao.getProductByID(productIdStr); 
int productId = Integer.parseInt(productIdStr);

        String cartKey = "cart_" + storeId;
        List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean exists = false;
        for (StoreOrderDetails od : cart) {
            if (od.getProductId() == productId) {
                od.setQuantity(od.getQuantity() + quantity);
                exists = true;
                break;
            }
        }

        if (!exists) {
            StoreOrderDetails od = new StoreOrderDetails();
            od.setProductId(productId);
            od.setQuantity(quantity);
            od.setPrice(p.getPrice());
            cart.add(od);
        }

        session.setAttribute(cartKey, cart);

        // Để hiển thị lại danh sách sản phẩm và giỏ hàng
        request.setAttribute("listP", dao.getAllProduct());
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("store_stock_in.jsp").forward(request, response);
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
