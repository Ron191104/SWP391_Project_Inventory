/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dao.SalesDAO;
import dao.StoreDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Customer;
import model.Sale;
import model.SaleDetail;
import model.Store;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SaleDetailController", urlPatterns = {"/sale_detail"})
public class SaleDetailController extends HttpServlet {

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

        int saleId = Integer.parseInt(request.getParameter("saleId"));

        SalesDAO salesDAO = new SalesDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        StoreDAO sdao = new StoreDAO();
        List<Store> listStore = sdao.getAllStore();
        List<SaleDetail> saleDetails = salesDAO.getSaleDetailsBySaleId(saleId);
        Sale sale = salesDAO.getSaleById(saleId);
        if (sale == null) {
            response.sendRedirect("sale_list");
            return;
        }

        Customer customer = null;
        if (sale.getCustomerId() > 0) {
            customer = customerDAO.getCustomerById(sale.getCustomerId());
        }
        request.setAttribute("saleDetails", saleDetails);
        request.setAttribute("sale", sale);
        request.setAttribute("customer", customer);
        request.setAttribute("listStore", listStore);

        request.getRequestDispatcher("store_sale_detail.jsp").forward(request, response);

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
