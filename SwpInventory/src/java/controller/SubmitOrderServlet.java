package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.OrderDetails;
import model.Product;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "SubmitOrderServlet", urlPatterns = {"/submit_order"})
public class SubmitOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<OrderDetails> cart = (List<OrderDetails>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("create_order");
            return;
        }

        String note = request.getParameter("note");
        int employeeId = 1; // cần sửa

        // lấy supplierId từ sản phẩm đầu tiên trong giỏ
        int productId = cart.get(0).getProductId();
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductByID(String.valueOf(productId));
        int supplierId = product.getSupplierId();

        // tạo đơn hàng
        Order order = new Order();
        order.setSupplierId(supplierId);
        order.setEmployeeId(employeeId);
        order.setNote(note);
        order.setStatus(0);
        order.setOrderDate(LocalDateTime.now());

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.insertOrder(order);

        // thêm chi tiết đơn hàng
        for (OrderDetails od : cart) {
            od.setOrderId(orderId);
            orderDAO.insertOrderDetail(od);
        }

        // xoá giỏ hàng
        session.removeAttribute("cart");

        response.sendRedirect("order_success.jsp");
    }
}
