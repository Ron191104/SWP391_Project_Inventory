/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dao.SalesDAO;
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
import model.StoreOrderDetails;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ProcessCheckoutController", urlPatterns = {"/processCheckout"})
public class ProcessCheckoutController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProcessCheckoutController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProcessCheckoutController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");

        if (storeId == null) {
            response.sendRedirect("choose_store");
            return;
        }

        String customerName = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        boolean usePoints = request.getParameter("usePoints") != null;
        String cartKey = "saleCart_" + storeId;
        List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute(cartKey);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("sales");
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        SalesDAO salesDAO = new SalesDAO();
        StoreProductDAO storeProductDAO = new StoreProductDAO();

        int customerId = -1;

        if (phone != null && !phone.isEmpty()) {
            customerId = customerDAO.findCustomerIdByPhone(phone);

            if (customerId == -1) {
                customerId = customerDAO.insertCustomer(customerName, phone, 0);
            }
        }

        double totalAmount = 0;
        for (StoreOrderDetails item : cart) {
            totalAmount += item.getPrice() * item.getQuantity();
        }

        int customerPoints = (customerId > 0) ? customerDAO.getPoints(customerId) : 0;

        if (usePoints && customerId > 0 && customerPoints > 0) {
            double amountPerPoint = salesDAO.getAmountPerPoint();
            double maxDiscount = customerPoints * amountPerPoint;

            double discount = Math.min(maxDiscount, totalAmount);
            int pointsToUse = (int) Math.floor(discount / amountPerPoint);

            totalAmount = totalAmount - (pointsToUse * amountPerPoint);

            customerDAO.subtractPoints(customerId, pointsToUse);
        }

        int saleId = salesDAO.createSaleAllowNull(
                (customerId > 0) ? customerId : 0,
                storeId,
                totalAmount,
                ""
        );

        for (StoreOrderDetails item : cart) {
            salesDAO.insertSaleDetail(saleId, item.getProductId(), item.getQuantity(), item.getPrice());
            storeProductDAO.subtractQuantity(storeId, item.getProductId(), item.getQuantity());
        }

        if (customerId > 0) {
            customerDAO.addPoint(customerId, 1);
        }

        session.removeAttribute(cartKey);

        response.sendRedirect("sale_detail?saleId=" + saleId);
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
