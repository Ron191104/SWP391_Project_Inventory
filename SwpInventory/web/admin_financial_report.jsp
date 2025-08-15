<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Báo cáo tài chính</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            background-color: #f7fafd;
        }

        .financial-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 40px;
            background-color: #f0f8ff;
            min-height: 100vh;
        }

        h2 {
            text-align: center;
            color: #0288d1;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .filter-form {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            margin-bottom: 20px;
            gap: 10px;
        }

        

        select {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 10px 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #e6f2ff;
            color: #005fa3;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f0f8ff;
        }

        canvas {
            margin-top: 40px;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 16px;
            background-color: #007bff;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .back-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<jsp:include page="admin_sidebar.jsp" />

<div class="financial-container">
    <h2>Báo cáo tài chính</h2>

    <!-- Bộ lọc thời gian -->
    <form class="filter-form" method="get" action="financial-report">
        <label>Thống kê theo:</label>
        <select name="filter" onchange="this.form.submit()">
            <option value="day" <c:if test="${filter == 'day'}">selected</c:if>>Ngày</option>
            <option value="month" <c:if test="${filter == 'month'}">selected</c:if>>Tháng</option>
            <option value="quarter" <c:if test="${filter == 'quarter'}">selected</c:if>>Quý</option>
            <option value="year" <c:if test="${filter == 'year'}">selected</c:if>>Năm</option>
        </select>
    </form>

    <!-- Bảng dữ liệu -->
    <table>
        <thead>
        <tr>
            <th>Thời gian</th>
            <th>Doanh thu</th>
            <th>Chi phí</th>
            <th>Lợi nhuận</th>
            <th>Số đơn bán</th>
            <th>Số đơn nhập</th>
            <th>Tỷ suất LN (%)</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="r" items="${reports}">
            <tr>
                <td>${r.timeLabel}</td>
                <td>${r.revenue}</td>
                <td>${r.cost}</td>
                <td>${r.profit}</td>
                <td>${r.saleOrders}</td>
                <td>${r.stockInOrders}</td>
                <td>${r.profitMargin}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Biểu đồ -->
    <canvas id="financialChart" height="100"></canvas>

    <script>
        const labels = [
            <c:forEach var="r" items="${reports}" varStatus="i">
                "${r.timeLabel}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];
        const revenueData = [
            <c:forEach var="r" items="${reports}" varStatus="i">
                ${r.revenue}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];
        const costData = [
            <c:forEach var="r" items="${reports}" varStatus="i">
                ${r.cost}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];
        const profitData = [
            <c:forEach var="r" items="${reports}" varStatus="i">
                ${r.profit}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];

        const ctx = document.getElementById('financialChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Doanh thu',
                        data: revenueData,
                        backgroundColor: 'rgba(0, 123, 255, 0.6)'
                    },
                    {
                        label: 'Chi phí',
                        data: costData,
                        backgroundColor: 'rgba(255, 99, 132, 0.6)'
                    },
                    {
                        label: 'Lợi nhuận',
                        data: profitData,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        type: 'line',
                        borderColor: 'rgba(0, 0, 0, 0.3)',
                        borderWidth: 2,
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>

    <a href="AdminDashboardServlet" class="back-link">← Quay về trang chính</a>
</div>
</body>
</html>
