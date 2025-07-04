package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.OrderDetailsDisplay;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order_details"})
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderDAO dao = new OrderDAO();
        List<OrderDetailsDisplay> orderDetailsList = dao.getFullOrderDetails(orderId);

        request.setAttribute("orderDetailsList", orderDetailsList);
        request.getRequestDispatcher("order_details.jsp").forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
