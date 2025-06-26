package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/approve_order")
public class ApproveOrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        String action = req.getParameter("action"); // approve/reject
        String orderIdStr = req.getParameter("orderId");
        if (action != null && orderIdStr != null) {
            int orderId = Integer.parseInt(orderIdStr);
            int status = 0;
            if ("approve".equals(action)) status = 1;
            else if ("reject".equals(action)) status = 2;

            boolean updated = orderDAO.updateOrderStatus(orderId, status);
            // Có thể set thông báo vào session nếu muốn hiển thị lại
        }
        // Trở lại dashboard đơn hàng
        resp.sendRedirect("supplier_order");
    }
}