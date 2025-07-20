<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Chi tiết yêu cầu hoàn trả</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1" />

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
        </style>
    </head>

    <body>

        <div class="header">
            <h1>Nhà Cung Cấp</h1>
            <div class="nav">
                <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
                <a href="supplier_return_requests"><i class="fas fa-undo"></i> Yêu cầu hoàn trả</a>
                <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <div class="container">

            <h2>Chi tiết yêu cầu hoàn trả #${returnInfo.id}</h2>

            <p><strong>Nhà cung cấp:</strong> ${returnInfo.supplierName}</p>
            <p><strong>Ngày tạo:</strong> ${returnInfo.createdDate}</p>
            <p><strong>Nhân viên gửi:</strong> ${returnInfo.employeeName}</p>
            <p><strong>Lý do:</strong> ${returnInfo.reason}</p>
            <c:if test="${not empty returnInfo.note}">
                <p><strong>Ghi chú:</strong> ${returnInfo.note}</p>
            </c:if>
            <p><strong>Trạng thái:</strong>
                <span class="status-label">
                    <c:choose>
                        <c:when test="${returnInfo.status == 0}">Chờ duyệt</c:when>
                        <c:when test="${returnInfo.status == 1}">Đã gửi đi</c:when>
                        <c:when test="${returnInfo.status == 2}">Đã từ chối</c:when>
                    </c:choose>
                </span>
            </p>

            <table>
                <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn vị</th>
                        <th>Giá nhập</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="total" value="0" />
                    <c:forEach var="d" items="${details}">
                        <tr>
                            <td>${d.productName}</td>
                            <td>${d.quantity}</td>
                            <td>${d.unit}</td>
                            <td>${d.price}</td>
                            <td>${d.quantity * d.price}</td>
                            <c:set var="total" value="${total + (d.quantity * d.price)}"/>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" style="text-align: right;"><strong>Tổng cộng:</strong></td>
                        <td><strong>${total}</strong></td>
                    </tr>
                </tbody>
            </table>

        </div>

    </body>
</html>
