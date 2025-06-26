/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Supplier;


/**
 *
 * @author LENOVO
 */
@WebServlet("/supplier-login")
public class SupplierLoginServlet extends HttpServlet {

    private SupplierDAO supplierDAO = new SupplierDAO(); // ✅ đúng class DAO

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        Supplier supplier = supplierDAO.getSupplierById(supplierId); // ✅ đúng class model.Supplier

        if (supplier != null) {
            // ✅ Reset session để tránh lỗi cast từ SupplierAdmin
            HttpSession session = request.getSession();
            session.invalidate(); // xóa session cũ
            session = request.getSession(); // tạo mới session
            session.setAttribute("supplier", supplier); // lưu đúng Supplier

            response.sendRedirect("supplier_dashboard.jsp"); // hoặc "supplier_order" nếu muốn
        } else {
            request.setAttribute("error", "ID không tồn tại");
            request.getRequestDispatcher("supplier_login.jsp").forward(request, response);
        }
    }
}

