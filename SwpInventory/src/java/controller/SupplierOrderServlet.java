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

/**
 *
 * @author LENOVO
 */
@WebServlet("/supplier_order")
public class SupplierOrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Supplier supplier = (Supplier) session.getAttribute("supplier");

        if (supplier == null) {
            response.sendRedirect("supplier_login.jsp"); 
            return;
        }

        int supplierId = supplier.getSupplier_id();
        List<Order> orderList = orderDAO.getOrdersBySupplierId(supplierId);

        // ✅ Debug in ra console để kiểm tra có đơn hàng không
        System.out.println("✅ Danh sách đơn hàng cho supplier_id = " + supplierId);
        for (Order o : orderList) {
            System.out.println("  - Order ID: " + o.getOrderId() + ", status: " + o.getStatus());
        }

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("supplier_order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action"); // approve/reject
        String orderIdStr = request.getParameter("orderId");

        if (action != null && orderIdStr != null) {
            int orderId = Integer.parseInt(orderIdStr);
            int status = 0;
            if ("approve".equals(action)) status = 1;
            else if ("reject".equals(action)) status = 2;

            boolean success = orderDAO.updateOrderStatus(orderId, status);

            // ✅ Log kết quả cập nhật trạng thái
            if (success) {
                System.out.println("✅ Đã cập nhật trạng thái đơn hàng " + orderId + " thành " + status);
            } else {
                System.out.println("❌ Lỗi cập nhật đơn hàng " + orderId);
            }
        }

        // Sau khi cập nhật chuyển hướng lại về trang danh sách
        response.sendRedirect("supplier_order");
    }
}
