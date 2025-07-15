
package controller;

import dao.ReturnRequestDAO;
import model.ReturnRequest;
import model.ReturnRequestDetail;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/create_return_request")
public class CreateReturnRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

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

        ReturnRequest req = new ReturnRequest();
        req.setSupplierId(supplierId);
        req.setEmployeeId(employeeId);
        req.setReason(reason);
        req.setNote(note);

        List<ReturnRequestDetail> details = new ArrayList<>();
        for (int i = 0; i < productIds.length; i++) {
            ReturnRequestDetail d = new ReturnRequestDetail();
            d.setProductId(Integer.parseInt(productIds[i]));
            d.setQuantity(Integer.parseInt(quantities[i]));
            details.add(d);
        }

        ReturnRequestDAO dao = new ReturnRequestDAO();
        int result = dao.createReturnRequest(req, details);

        if (result > 0) {
            request.getSession().setAttribute("successMessage", "Tạo yêu cầu trả hàng thành công.");
        } else {
            request.getSession().setAttribute("errorMessage", "Lỗi khi tạo yêu cầu trả hàng.");
        }

        response.sendRedirect("create_return_request");
    }
}
