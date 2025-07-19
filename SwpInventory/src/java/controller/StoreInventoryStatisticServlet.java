package controller;

import dao.StoreInventoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.StoreInventory;
import model.Category; // Import model Category
import model.Supplier; // Import model Supplier

@WebServlet(name = "StoreInventoryStatisticServlet", urlPatterns = {"/store-inventory-statistics"})
public class StoreInventoryStatisticServlet extends HttpServlet {

    private static final int DEFAULT_PAGE_SIZE = 10; // Số sản phẩm mặc định trên mỗi trang

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        StoreInventoryDAO dao = new StoreInventoryDAO();

        // 1. Lấy tham số từ request (tìm kiếm, lọc, sắp xếp, phân trang)
        String searchKeyword = request.getParameter("searchKeyword");
        String categoryId = request.getParameter("categoryId");
        String supplierId = request.getParameter("supplierId");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");

        // Tham số phân trang
        String pageIndexParam = request.getParameter("pageIndex");
        int pageIndex = 1; // Mặc định là trang 1
        try {
            if (pageIndexParam != null && !pageIndexParam.isEmpty()) {
                pageIndex = Integer.parseInt(pageIndexParam);
            }
        } catch (NumberFormatException e) {
            pageIndex = 1; // Đảm bảo pageIndex là số hợp lệ
        }

        // Đảm bảo các tham số không null để tránh lỗi (đặt lại thành rỗng nếu null)
        if (searchKeyword == null) searchKeyword = "";
        if (categoryId == null) categoryId = "";
        if (supplierId == null) supplierId = "";
        if (sortBy == null) sortBy = "productName"; // Mặc định sắp xếp theo tên sản phẩm
        if (sortOrder == null) sortOrder = "asc"; // Mặc định sắp xếp tăng dần


        // 2. Lấy tổng số bản ghi (để tính tổng số trang)
        int totalRecords = dao.getTotalInventoryCount(searchKeyword, categoryId, supplierId);
        int totalPages = (int) Math.ceil((double) totalRecords / DEFAULT_PAGE_SIZE);

        // Đảm bảo pageIndex không vượt quá tổng số trang
        if (pageIndex > totalPages && totalPages > 0) {
            pageIndex = totalPages;
        } else if (pageIndex <= 0) {
            pageIndex = 1;
        }
        if (totalPages == 0) { // Trường hợp không có bản ghi nào
            pageIndex = 1;
        }

        // 3. Gọi phương thức trong DAO để lấy dữ liệu với các tham số
        List<StoreInventory> inventoryList = dao.getProductInventoryStats(
                searchKeyword, categoryId, supplierId,
                sortBy, sortOrder, pageIndex, DEFAULT_PAGE_SIZE);

        // 4. Lấy danh sách danh mục và nhà cung cấp cho dropdown
        List<Category> categories = dao.getCategoriesForFilter();
        List<Supplier> suppliers = dao.getSuppliersForFilter();


        // 5. Đặt dữ liệu vào request attribute
        request.setAttribute("inventoryList", inventoryList);
        request.setAttribute("categories", categories); // Danh sách danh mục
        request.setAttribute("suppliers", suppliers);   // Danh sách nhà cung cấp
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("pageSize", DEFAULT_PAGE_SIZE); // Có thể truyền để JSP hiển thị

        // Đặt lại các tham số tìm kiếm/lọc/sắp xếp để giữ trạng thái trên form
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("selectedSupplierId", supplierId);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);


        // 6. Chuyển hướng đến trang JSP
        request.getRequestDispatcher("store_inventory_statistics.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    
}