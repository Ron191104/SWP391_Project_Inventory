/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InventoryStockDAO;
import dao.StockInDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.StockIn;
import model.StockOut;

/**
 *
 * @author User
 */
@WebServlet(name = "InventoryStockReportController", urlPatterns = {"/stock_report"})
public class InventoryStockReportController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InventoryStockReportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InventoryStockReportController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fromRaw = request.getParameter("from");
            String toRaw = request.getParameter("to");

            List<StockIn> stockInList = new ArrayList<>();
            List<StockOut> stockOutList = new ArrayList<>();

            InventoryStockDAO dao = new InventoryStockDAO();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false); // tránh parse sai

            Date today = new Date();

            if (fromRaw != null && toRaw != null && !fromRaw.isEmpty() && !toRaw.isEmpty()) {
                try {
                    Date from = sdf.parse(fromRaw);
                    Date to = sdf.parse(toRaw);

                    if (from.after(to)) {
                        request.setAttribute("error", "Ngày bắt đầu không được lớn hơn ngày kết thúc.");
                    } else if (to.after(today)) {
                        request.setAttribute("error", "Ngày kết thúc không được lớn hơn ngày hiện tại.");
                    } else {
                        stockInList = dao.getStockInListByDateRange(from, to);
                        stockOutList = dao.getStockOutListByDateRange(from, to);
                    }
                } catch (Exception e) {
                    request.setAttribute("error", "Định dạng ngày không hợp lệ.");
                }
            } else {
                stockInList = dao.getStockInListByDateRange(new Date(0), today);
                stockOutList = dao.getStockOutListByDateRange(new Date(0), today);
            }

            for (StockIn s : stockInList) {
                String name = dao.getSupplierNameById(s.getSupplierId());
                s.setSupplierName(name);
            }

            request.setAttribute("stockInList", stockInList);
            request.setAttribute("stockOutList", stockOutList);
            request.getRequestDispatcher("stock_report.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi xử lý thống kê");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
