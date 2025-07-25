package controller;

import dao.ReturnRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cancel_return_request")
public class CancelReturnRequestServlet extends HttpServlet {

    private final ReturnRequestDAO dao = new ReturnRequestDAO();

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
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "returnId không hợp lệ.");
            return;
        }

        // Gọi DAO để cập nhật status = 3 (đã hủy)
        dao.updateRequestStatus(returnId, 3);

        // Quay lại danh sách yêu cầu
        response.sendRedirect("return_requests");
    }
}
