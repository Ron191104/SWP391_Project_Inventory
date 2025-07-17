package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.DashboardDAO; // Nên tách riêng DAO cho dashboard, hoặc bổ sung vào UserDAO
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập và quyền
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !"4".equals(session.getAttribute("userRole").toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        DashboardDAO dashboardDao = new DashboardDAO();
        int supplierCount = dashboardDao.getSupplierCount();
        int customerCount = dashboardDao.getCustomerCount();
        int purchaseInvoiceCount = dashboardDao.getPurchaseInvoiceCount();
        int salesInvoiceCount = dashboardDao.getSalesInvoiceCount();

        request.setAttribute("supplierCount", supplierCount);
        request.setAttribute("customerCount", customerCount);
        request.setAttribute("purchaseInvoiceCount", purchaseInvoiceCount);
        request.setAttribute("salesInvoiceCount", salesInvoiceCount);

        // Forward sang đúng file JSP cho admin
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}