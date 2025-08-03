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

        switch (filterType) {
            case "day":
                timeExpr = "FORMAT(sale_date, 'yyyy-MM-dd')";
                break;
            case "quarter":
                timeExpr = "CONCAT('Q', DATEPART(QUARTER, sale_date), '-', YEAR(sale_date))";
                break;
            case "year":
                timeExpr = "FORMAT(sale_date, 'yyyy')";
                break;
            default:
                timeExpr = "FORMAT(sale_date, 'yyyy-MM')";
        }

        // Build the SQL with CTE
        String sql = "WITH DoanhThuCTE AS ( "
                + "    SELECT "
                + "        " + timeExpr + " AS ThoiGian, "
                + "        SUM(sd.quantity * sd.price_out) AS DoanhThu, "
                + "        COUNT(DISTINCT s.sale_id) AS SoDonBan "
                + "    FROM sales s "
                + "    LEFT JOIN sales_details sd ON s.sale_id = sd.sale_id "
                + "    GROUP BY " + timeExpr + " "
                + "), "
                + "ChiPhiCTE AS ( "
                + "    SELECT "
                + "        " + timeExpr.replace("sale_date", "stock_in_date") + " AS ThoiGian, "
                + "        SUM(sid.quantity * sid.price_in) AS ChiPhi, "
                + "        COUNT(DISTINCT si.stock_in_id) AS SoDonNhap "
                + "    FROM stock_in si "
                + "    LEFT JOIN stock_in_details sid ON si.stock_in_id = sid.stock_in_id "
                + "    GROUP BY " + timeExpr.replace("sale_date", "stock_in_date") + " "
                + ") "
                + "SELECT "
                + "    ISNULL(d.ThoiGian, c.ThoiGian) AS ThoiGian, "
                + "    ISNULL(d.DoanhThu, 0) AS DoanhThu, "
                + "    ISNULL(c.ChiPhi, 0) AS ChiPhi, "
                + "    ISNULL(d.SoDonBan, 0) AS SoDonBan, "
                + "    ISNULL(c.SoDonNhap, 0) AS SoDonNhap, "
                + "    (ISNULL(d.DoanhThu, 0) - ISNULL(c.ChiPhi, 0)) AS LoiNhuan, "
                + "    CASE WHEN ISNULL(c.ChiPhi, 0) > 0 "
                + "        THEN ROUND(100.0 * (ISNULL(d.DoanhThu, 0) - ISNULL(c.ChiPhi, 0)) / ISNULL(c.ChiPhi, 0), 2) "
                + "        ELSE 0 END AS TySuatLoiNhuan "
                + "FROM DoanhThuCTE d "
                + "FULL OUTER JOIN ChiPhiCTE c ON d.ThoiGian = c.ThoiGian "
                + "ORDER BY ThoiGian";

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
