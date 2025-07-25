package dao;

import dal.DBConnect;
import model.FinancialReport;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO extends DBConnect {

    public List<FinancialReport> getFinancialReport(String filterType) throws SQLException {
        List<FinancialReport> reports = new ArrayList<>();
        String timeExpr;

        // Chuyển filterType thành biểu thức SQL cụ thể
        switch (filterType) {
            case "day":
                timeExpr = "FORMAT(ISNULL(s.sale_date, si.stock_in_date), 'yyyy-MM-dd')";
                break;
            case "quarter":
                timeExpr = "CONCAT('Q', DATEPART(QUARTER, ISNULL(s.sale_date, si.stock_in_date)), '-', YEAR(ISNULL(s.sale_date, si.stock_in_date)))";
                break;
            case "year":
                timeExpr = "FORMAT(ISNULL(s.sale_date, si.stock_in_date), 'yyyy')";
                break;
            default: // mặc định là theo tháng
                timeExpr = "FORMAT(ISNULL(s.sale_date, si.stock_in_date), 'yyyy-MM')";
        }

        // Ghép chuỗi SQL với timeExpr thay vì dùng tham số
        String sql = "SELECT " + timeExpr + " AS ThoiGian, "
                + "SUM(sd.quantity * sd.price_out) AS DoanhThu, "
                + "SUM(sid.quantity * sid.price_in) AS ChiPhi, "
                + "COUNT(DISTINCT s.sale_id) AS SoDonBan, "
                + "COUNT(DISTINCT si.stock_in_id) AS SoDonNhap, "
                + "SUM(ISNULL(sd.quantity * sd.price_out, 0)) - SUM(ISNULL(sid.quantity * sid.price_in, 0)) AS LoiNhuan, "
                + "CASE WHEN SUM(ISNULL(sid.quantity * sid.price_in, 0)) > 0 "
                + "THEN ROUND(100.0 * (SUM(ISNULL(sd.quantity * sd.price_out, 0)) - SUM(ISNULL(sid.quantity * sid.price_in, 0))) / SUM(sid.quantity * sid.price_in), 2) ELSE 0 END AS TySuatLoiNhuan "
                + "FROM sales s "
                + "LEFT JOIN sales_details sd ON s.sale_id = sd.sale_id "
                + "FULL OUTER JOIN stock_in si ON " + timeExpr + " = " + timeExpr + " "
                + "LEFT JOIN stock_in_details sid ON si.stock_in_id = sid.stock_in_id "
                + "GROUP BY " + timeExpr + " "
                + "ORDER BY " + timeExpr;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FinancialReport fr = new FinancialReport(
                        rs.getString("ThoiGian"),
                        rs.getDouble("DoanhThu"),
                        rs.getDouble("ChiPhi"),
                        rs.getDouble("LoiNhuan"),
                        rs.getInt("SoDonBan"),
                        rs.getInt("SoDonNhap"),
                        rs.getDouble("TySuatLoiNhuan")
                );
                reports.add(fr);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return reports;
    }
}
