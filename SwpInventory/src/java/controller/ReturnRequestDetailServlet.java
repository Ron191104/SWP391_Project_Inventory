package controller;

import dao.ReturnRequestDAO;
import model.ReturnRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/return_request_details")
public class ReturnRequestDetailServlet extends HttpServlet {

    private ReturnRequestDAO returnRequestDAO = new ReturnRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int returnId = Integer.parseInt(request.getParameter("returnId"));

        // Lấy thông tin yêu cầu trả hàng từ DAO
        ReturnRequest returnRequest = returnRequestDAO.getReturnRequestById(returnId);

        if (returnRequest != null) {
            // Truyền thông tin yêu cầu trả hàng và chi tiết trả hàng vào request
            request.setAttribute("returnRequest", returnRequest);
            request.getRequestDispatcher("return_request_details.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy yêu cầu trả hàng.");
        }
    }
}
