package controller;

import dao.ProductDAO;
import dao.ReturnRequestDAO;
import model.ReturnRequest;
import model.ReturnRequestDetail;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Supplier;
import dao.SupplierDAO;
import dao.ProductDAO;
import model.Product;


@WebServlet("/create_return_request")
public class CreateReturnRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String supplierIdRaw = request.getParameter("supplierId");
        int supplierId = -1;
        if (supplierIdRaw != null && !supplierIdRaw.isEmpty()) {
            supplierId = Integer.parseInt(supplierIdRaw);
            request.setAttribute("selectedSupplierId", supplierId);
        }

        // Lấy danh sách nhà cung cấp
        SupplierDAO supplierDAO = new SupplierDAO();
        List<Supplier> listSuppliers = supplierDAO.getAllSuppliers();
        request.setAttribute("listSuppliers", listSuppliers);

        // Lấy danh sách sản phẩm
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = new ArrayList<>();
        if (supplierId != -1) {
            productList = productDAO.getProductsBySupplierId(String.valueOf(supplierId));
        }

        request.setAttribute("productList", productList);

        request.getRequestDispatcher("create_return_request.jsp").forward(request, response);
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    int supplierId = Integer.parseInt(request.getParameter("supplierId"));
    int employeeId = 1; // giả định ID nhân viên từ session hoặc cố định
    String reason = request.getParameter("reason");
    String note = request.getParameter("note");

    String[] productIds = request.getParameterValues("productId");
    String[] quantities = request.getParameterValues("quantity");

    if (productIds == null || quantities == null || productIds.length == 0 || quantities.length == 0) {
        request.getSession().setAttribute("errorMessage", "Vui lòng chọn ít nhất một sản phẩm để trả.");
        response.sendRedirect("create_return_request?supplierId=" + supplierId);
        return;
    }

    ReturnRequest req = new ReturnRequest();
    req.setSupplierId(supplierId);
    req.setEmployeeId(employeeId);
    req.setReason(reason);
    req.setNote(note);

    List<ReturnRequestDetail> details = new ArrayList<>();
    try {
        for (int i = 0; i < productIds.length; i++) {
            ReturnRequestDetail d = new ReturnRequestDetail();
            d.setProductId(Integer.parseInt(productIds[i]));
            d.setQuantity(Integer.parseInt(quantities[i]));
            details.add(d);
        }
    } catch (NumberFormatException e) {
        request.getSession().setAttribute("errorMessage", "Dữ liệu sản phẩm không hợp lệ.");
        response.sendRedirect("create_return_request?supplierId=" + supplierId);
        return;
    }

    ReturnRequestDAO dao = new ReturnRequestDAO();
    int result = dao.createReturnRequest(req, details);

    if (result > 0) {
        request.getSession().setAttribute("successMessage", "Tạo yêu cầu trả hàng thành công.");
    } else {
        request.getSession().setAttribute("errorMessage", "Lỗi khi tạo yêu cầu trả hàng.");
    }

    response.sendRedirect("create_return_request?supplierId=" + supplierId);
}
}
