package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Order;
import model.OrderDetails;
import model.Product;

@WebServlet(name = "SubmitOrderServlet", urlPatterns = {"/submit_order"})
public class SubmitOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<OrderDetails> cart = (List<OrderDetails>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("create_order");
            return;
        }

        String note = request.getParameter("note");
        int employeeId = 1; // hardcoded

        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();

        Map<Integer, List<OrderDetails>> grouped = new HashMap<>();

        for (OrderDetails od : cart) {
            int productId = od.getProductId();
            Product product = productDAO.getProductByID(String.valueOf(productId));
            int supplierId = product.getSupplier_id();

            grouped.computeIfAbsent(supplierId, k -> new ArrayList<>()).add(od);
        }

        for (Map.Entry<Integer, List<OrderDetails>> entry : grouped.entrySet()) {
            int supplierId = entry.getKey();
            List<OrderDetails> details = entry.getValue();

            Order order = new Order();
            order.setSupplierId(supplierId);
            order.setEmployeeId(employeeId);
            order.setNote(note);
            order.setStatus(0);
            order.setOrderDate(LocalDateTime.now()); // phải có dòng này

            int orderId = orderDAO.insertOrder(order);

            for (OrderDetails od : details) {
                od.setOrderId(orderId);
                orderDAO.insertOrderDetail(od);
            }
        }

        session.removeAttribute("cart");
        response.sendRedirect("order_success.jsp");
    }
    
}
