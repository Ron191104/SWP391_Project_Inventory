package controller;

import dao.ReturnRequestDAO;
import model.ReturnRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/return_requests")
public class ReturnRequestListServlet extends HttpServlet {

    private ReturnRequestDAO dao = new ReturnRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Chỉ lấy các đơn hoàn trả đã gửi đi (đã duyệt)
        List<ReturnRequest> returnList = dao.getApprovedReturnRequests();

        request.setAttribute("returnList", returnList);

        request.getRequestDispatcher("return_request_list.jsp").forward(request, response);
    }
}
