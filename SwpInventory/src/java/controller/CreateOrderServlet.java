/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.Product;
import model.Order;
import model.OrderDetails;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author User
 */
@WebServlet(name = "CreateOrderServlet", urlPatterns = {"/create_order"})
public class CreateOrderServlet extends HttpServlet {

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
        ProductDAO productDAO = new ProductDAO();
        List<Product> list = productDAO.getAllProduct();
        request.setAttribute("listP", list);
        request.getRequestDispatcher("create_order.jsp").forward(request, response);
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
    HttpSession session = request.getSession();
    String productId = request.getParameter("id");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    int pid = Integer.parseInt(productId);

    ProductDAO dao = new ProductDAO();
    Product selectedProduct = dao.getProductByID(productId);

    List<OrderDetails> cart = (List<OrderDetails>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    boolean exists = false;
    for (OrderDetails od : cart) {
        if (od.getProductId() == pid) {
            od.setQuantity(od.getQuantity() + quantity);
            exists = true;
            break;
        }
    }

    if (!exists) {
        OrderDetails od = new OrderDetails();
        od.setProductId(pid);
        od.setQuantity(quantity);
        od.setPrice(selectedProduct.getPrice()); 
        cart.add(od);
    }

    session.setAttribute("cart", cart);
    response.sendRedirect("create_order");
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
