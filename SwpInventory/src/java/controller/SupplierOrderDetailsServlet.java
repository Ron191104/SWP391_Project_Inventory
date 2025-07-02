package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderDetailsDisplay;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/supplier_orderdetails")
public class SupplierOrderDetailsServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        int orderId = 0;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Định dạng mã đơn hàng không hợp lệ");
            return;
        }

        // Lấy chi tiết đơn hàng
        List<OrderDetailsDisplay> orderDetailsList = orderDAO.getFullOrderDetails(orderId);

        // Lấy thông tin đơn hàng (đầy đủ)
        Order order = orderDAO.getOrderById(orderId);

        request.setAttribute("orderId", orderId);
        request.setAttribute("orderDetailsList", orderDetailsList);
        request.setAttribute("orderStatus", order != null ? order.getStatus() : null);
        request.setAttribute("order", order); // Truyền sang để JSP lấy

        request.getRequestDispatcher("supplier_orderdetails.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String action = request.getParameter("action");

        if ("approve".equals(action)) {
            orderDAO.updateOrderStatus(orderId, 1); // Đã duyệt
        } else if ("reject".equals(action)) {
            orderDAO.updateOrderStatus(orderId, 2); // Từ chối
        } else if ("delivered".equals(action)) {
            orderDAO.updateOrderStatus(orderId, 3); // Đã cung cấp
        }
        response.sendRedirect("supplier_orderdetails?orderId=" + orderId);
    }
}