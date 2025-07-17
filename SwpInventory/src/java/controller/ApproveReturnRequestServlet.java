/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReturnRequestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
@WebServlet("/approve_return_request")
public class ApproveReturnRequestServlet extends HttpServlet {
    private ReturnRequestDAO dao = new ReturnRequestDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");

        int newStatus = action.equals("approve") ? 1 : 2; // 1: approved, 2: rejected
        boolean success = dao.updateRequestStatus(requestId, newStatus);

        if (success) {
            request.getSession().setAttribute("successMessage", "Đã cập nhật trạng thái yêu cầu.");
        } else {
            request.getSession().setAttribute("errorMessage", "Không thể cập nhật yêu cầu.");
        }

        response.sendRedirect("supplier_return_requests");
    }
}

