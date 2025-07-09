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
@WebServlet("/supplier_dashboard")
public class SupplierDashboardServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Supplier supplier = (Supplier) session.getAttribute("supplier");

        if (supplier == null) {
            response.sendRedirect("supplier_login");
            return;
        }
        
        int suppplierID = supplier.getSupplier_id();
        
        //Lấy tất cả các đơn hàng của supplier
        List<Order> orders = orderDAO.getOrdersBySupplierId(supplier.getSupplier_id());
        request.setAttribute("orders", orders);
        
        //Lấy danh sách đơn hàng mới cho thông báo
        List<Order> newOrders = orderDAO.getOrdersBySupplierIdAndStatus(suppplierID, 0);
        request.setAttribute("newOrders", newOrders);
        
        request.getRequestDispatcher("supplier_dashboard").forward(request, response);
    }
}
