package controller;

import dao.ReturnRequestDAO;
import model.ReturnRequest;
import model.ReturnRequestDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/supplier_return_details")
public class SupplierReturnDetailServlet extends HttpServlet {

    private final ReturnRequestDAO dao = new ReturnRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String param = request.getParameter("returnId");

        if (param == null || param.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số returnId.");
            return;
        }

        int returnId;
        try {
            returnId = Integer.parseInt(param);
            if (returnId <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "returnId không hợp lệ.");
            return;
        }

        ReturnRequest returnInfo = dao.getReturnRequestById(returnId);
        if (returnInfo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy yêu cầu trả hàng.");
            return;
        }

        List<ReturnRequestDetail> details = dao.getReturnRequestDetailInfo(returnId);

        request.setAttribute("returnInfo", returnInfo);
        request.setAttribute("details", details);

        request.getRequestDispatcher("supplier_return_details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String param = request.getParameter("returnId");

        if (param == null || param.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu returnId trong POST.");
            return;
        }

        int returnId;
        try {
            returnId = Integer.parseInt(param);
            if (returnId <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "returnId không hợp lệ.");
            return;
        }

        String action = request.getParameter("action");

        if ("approve".equals(action)) {
            dao.updateRequestStatus(returnId, 1); // Đã duyệt
        } else if ("reject".equals(action)) {
            dao.updateRequestStatus(returnId, 2); // Từ chối
        }

        // Sau khi xử lý, chuyển về lại trang chi tiết
        response.sendRedirect("supplier_return_details?returnId=" + returnId);
    }
}
