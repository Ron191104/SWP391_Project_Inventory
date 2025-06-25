/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order;
import model.Supplier;
import model.User;

/**
 *
 * @author LENOVO
 */
@WebServlet("/supplier-dashboard")
public class SupplierDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Supplier supplier = (Supplier) session.getAttribute("supplier");

        if (supplier == null) {
            response.sendRedirect("supplier_login.jsp");
            return;
        }

        OrderDAO dao = new OrderDAO();
        List<Order> orders = dao.getOrdersBySupplier(supplier.getSupplier_id());

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("supplier-dashboard.jsp").forward(request, response);
    }
}
