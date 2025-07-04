package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ProductDAO;
import dao.SupplierAdminDAO;
import model.Product;
import model.SupplierAdmin;
import model.OrderDetails;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CreateOrderServlet", urlPatterns = {"/create_order"})
public class CreateOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String supplierId = request.getParameter("supplierId");

        // lấy danh sách supplier
        SupplierAdminDAO s_dao = new SupplierAdminDAO();
        List<SupplierAdmin> suppliers = s_dao.getAllSuppliers();
        request.setAttribute("listS", suppliers);

        // lấy danh sách sản phẩm theo supplier nếu có
        ProductDAO productDAO = new ProductDAO();
        List<Product> list;

        if (supplierId != null && !supplierId.isEmpty()) {
            list = productDAO.getProductsBySupplierId(supplierId);
        } else {
            list = new ArrayList<>();
        }

        request.setAttribute("listP", list);

        // forward sang JSP

        request.getRequestDispatcher("create_order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String productId = request.getParameter("id");
        String supplierId = request.getParameter("supplierId");
        String quantityStr = request.getParameter("quantity");

        if (productId == null || supplierId == null || quantityStr == null
                || productId.isEmpty() || supplierId.isEmpty() || quantityStr.isEmpty()) {
            response.sendRedirect("create_order");
            return;
        }

        int pid = Integer.parseInt(productId);
        int quantity = Integer.parseInt(quantityStr);

        ProductDAO dao = new ProductDAO();
        Product selectedProduct = dao.getProductByID(productId);

        if (selectedProduct == null) {
            response.sendRedirect("create_order?supplierId=" + supplierId);
            return;
        }

        List<OrderDetails> cart = (List<OrderDetails>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean exists = false;
        for (OrderDetails od : cart) {
            if (od.getProductId() == pid) {
                od.setQuantity(od.getQuantity() + quantity);
                exists = true;
                break;
            }
        }

        if (!exists) {
            OrderDetails od = new OrderDetails();
            od.setProductId(pid);
            od.setQuantity(quantity);
            od.setPrice(selectedProduct.getPrice());
            cart.add(od);
        }

        session.setAttribute("cart", cart);

        // redirect lại trang tạo đơn hàng với supplier đã chọn
        response.sendRedirect("create_order?supplierId=" + supplierId + "&id=" + productId);
    }
}
