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

        // Xử lý lỗi thiếu hoặc sai kiểu returnId
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

        // Truy vấn dữ liệu
        ReturnRequest returnInfo = dao.getReturnRequestById(returnId);
        if (returnInfo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy yêu cầu trả hàng với returnId = " + returnId);
            return;
        }

        List<ReturnRequestDetail> details = dao.getReturnRequestDetailInfo(returnId);

        // Đặt dữ liệu vào request
        request.setAttribute("returnInfo", returnInfo);
        request.setAttribute("details", details);

        // Forward sang JSP
        request.getRequestDispatcher("supplier_return_details.jsp").forward(request, response);
    }
}
