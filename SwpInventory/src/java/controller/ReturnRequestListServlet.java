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

        // Lấy tất cả đơn hoàn trả với mọi trạng thái
        List<ReturnRequest> returnList = dao.getAllReturnRequests();

        request.setAttribute("returnList", returnList);

        request.getRequestDispatcher("return_request_list.jsp").forward(request, response);
    }
}
