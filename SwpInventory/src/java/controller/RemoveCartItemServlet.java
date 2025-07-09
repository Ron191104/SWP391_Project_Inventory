/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.StoreOrderDetails;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="RemoveCartItemServlet", urlPatterns={"/remove_cart_item"})
public class RemoveCartItemServlet extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
 response.setContentType("text/html;charset=UTF-8");
          HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");
        if (storeId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String cartKey = "cart_" + storeId;
        List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);

        String productIdRaw = request.getParameter("productId");

        if (productIdRaw != null && cart != null) {
            try {
                int productId = Integer.parseInt(productIdRaw);
                cart.removeIf(item -> item.getProductId() == productId);
                session.setAttribute(cartKey, cart); 
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("store_stock_in"); 
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
