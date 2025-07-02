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
import java.util.List;
import model.Order;

/**
 *
 * @author LENOVO
 */
@WebServlet("/test-orders")
public class TestOrdersServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        List<Order> orders = orderDAO.getOrdersBySupplierId(1);

        PrintWriter out = response.getWriter();
        out.println("<h2>Đơn hàng cho Supplier ID = 1</h2>");
        out.println("<ul>");
        for (Order o : orders) {
            out.println("<li>Mã đơn: " + o.getOrderId() + " - Trạng thái: " + o.getStatus() + "</li>");
        }
        out.println("</ul>");
    }
}
