<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Yêu cầu trả hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #82CAFA;
                padding: 12px 24px;
                color: white;
            }
            .header h1 {
                font-size: 1.8rem;
                font-weight: 700;
                margin: 0;
            }
            .nav a {
                color: white;
                margin-left: 16px;
                font-weight: bold;
                text-decoration: none;
            }
            .nav a:hover {
                text-decoration: underline;
            }
            .container {
                max-width: 1000px;
                margin: 40px auto;
                background: #fff;
                padding: 24px;
                border-radius: 8px;
            }
            h2 {
                text-align: center;
                color: #82CAFA;
                margin-bottom: 24px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #82CAFA;
                color: white;
            }
            .status-label {
                font-weight: 600;
            }
            .btn-view {
                background-color: #007bff;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                display: inline-block;
            }
            .btn-view:hover {
                background-color: #0056b3;
            }
            .no-data {
                text-align: center;
                font-style: italic;
                color: #888;
                background: #fefefe;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
            }
        </style>
    </head>

    <body>

        <div class="header">
            <h1>Nhà Cung Cấp</h1>
            <div class="nav">
                <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
                <a href="supplier-dashboard?view=approved"><i class="fas fa-check"></i> Đã cung cấp</a>
                <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <div class="container">
            <h2>Danh sách yêu cầu trả hàng từ kho</h2>

            <p style="color:blue;">Supplier ID đang đăng nhập: ${sessionScope.supplier.supplierId}</p>
            <p style="color:red;">Tổng số yêu cầu trả hàng: ${fn:length(returnRequests)}</p>

            <!-- Bộ lọc trạng thái -->
            <form method="get" action="supplier_return_requests" style="margin-bottom:20px;">
                <label for="statusFilter"><b>Trạng thái yêu cầu:</b></label>
                <select name="status" id="statusFilter"
                        style="padding:8px;border-radius:6px;border:1px solid #ccc;"
                        onchange="this.form.submit()">
                    <option value="">Tất cả</option>
                    <option value="0" ${param.status == '0' ? 'selected' : ''}>Chờ duyệt</option>
                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Đã duyệt</option>
                    <option value="2" ${param.status == '2' ? 'selected' : ''}>Từ chối</option>
                </select>
            </form>

            <c:if test="${not empty returnRequests}">
                <table>
                    <thead>
                        <tr>
                            <th>Mã yêu cầu</th>
                            <th>Ngày tạo</th>
                            <th>Lý do</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${returnRequests}">
                            <tr>
                                <td>${r.id}</td>
                                <td>${r.createdDate}</td>
                                <td>${r.reason}</td>
                                <td>
                                    <span class="status-label">
                                        <c:choose>
                                            <c:when test="${r.status == 0}">⏳ Chờ duyệt</c:when>
                                            <c:when test="${r.status == 1}">✔ Đã duyệt</c:when>
                                            <c:when test="${r.status == 2}">✖ Từ chối</c:when>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <a href="supplier_return_details?returnId=${r.id}" class="btn-view">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty returnRequests}">
                <div class="no-data">Không có yêu cầu trả hàng nào.</div>
            </c:if>

        </div>

    </body>
</html>
