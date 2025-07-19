package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.DashboardDAO;
import dao.StoreInventoryDAO; // Import StoreInventoryDAO
import model.StoreInventory; // Import StoreInventory model
import model.CategoryStock;  // Import CategoryStock model
import java.util.List;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/AdminDashboardServlet") // Vẫn giữ nguyên URL pattern này
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

        // --- BỔ SUNG LOGIC LẤY DỮ LIỆU CHO BIỂU ĐỒ ---
        StoreInventoryDAO inventoryDAO = new StoreInventoryDAO();

        // 1. Dữ liệu cho biểu đồ "Top 5 sản phẩm tồn kho nhiều nhất"
        List<StoreInventory> top5MostStockedProducts = inventoryDAO.getTopNMostStockedProducts(5);
        request.setAttribute("top5MostStockedProducts", top5MostStockedProducts);

        // 2. Dữ liệu cho biểu đồ "Top 5 sản phẩm tồn kho ít nhất"
        List<StoreInventory> top5LeastStockedProducts = inventoryDAO.getTopNLeastStockedProducts(5);
        request.setAttribute("top5LeastStockedProducts", top5LeastStockedProducts);

        // 3. Dữ liệu cho biểu đồ "Tỷ lệ tồn kho theo danh mục"
        List<CategoryStock> categoryStockDistribution = inventoryDAO.getCategoryStockDistribution();
        request.setAttribute("categoryStockDistribution", categoryStockDistribution);
        // --- KẾT THÚC BỔ SUNG ---


        // Forward sang đúng file JSP cho admin
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
    // Không cần doPost nếu bạn chỉ xử lý GET cho dashboard
}