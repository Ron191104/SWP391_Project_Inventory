package controller;

import dao.ReportDAO;
import model.FinancialReport;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/financial-report")
public class AdminFinancialReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "month"; // mặc định
        }

        ReportDAO dao = new ReportDAO();
        try {
            List<FinancialReport> reports = dao.getFinancialReport(filter);
            request.setAttribute("reports", reports);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể truy vấn dữ liệu tài chính!");
        }

        request.setAttribute("filter", filter); 

        request.getRequestDispatcher("/admin_financial_report.jsp").forward(request, response);
    }
}
