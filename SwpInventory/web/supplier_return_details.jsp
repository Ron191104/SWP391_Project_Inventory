<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết yêu cầu hoàn trả</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }
            .header {
                display: flex;
                justify-content: space-between;
                background-color: #82CAFA;
                color: white;
                padding: 12px 24px;
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
                max-width: 800px;
                margin: 32px auto;
                padding: 24px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 18px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
                font-size: 0.98rem;
            }
            th {
                background-color: #82CAFA;
                color: white;
                font-weight: 700;
            }
            .btn-approve, .btn-reject {
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                margin-right: 8px;
                font-size: 1rem;
            }
            .btn-approve {
                background: #28a745;
            }
            .btn-approve:hover {
                background: #218838;
            }
            .btn-reject {
                background: #dc3545;
            }
            .btn-reject:hover {
                background: #c82333;
            }
            .back-link {
                color: #007bff;
                text-decoration: none;
                margin-bottom: 14px;
                display: inline-block;
            }
            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>

        <div class="header">
            <h1>Nhà Cung Cấp</h1>
            <div class="nav">
                <a href="supplier_order">Đơn hàng</a>
                <a href="supplier_return_requests">Hoàn trả</a>
                <a href="supplier_logout.jsp">Đăng xuất</a>
            </div>
        </div>

        <div class="container" style="text-align: center">

            <a href="supplier_return_requests" class="back-link">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách yêu cầu trả hàng
            </a>

            <h2>Chi tiết yêu cầu hoàn trả #${returnInfo.id}</h2>

            <p><b>Ngày tạo:</b> ${returnInfo.createdDate}</p>
            <p><b>Nhân viên gửi:</b> ${returnInfo.employeeName}</p>
            <p><b>Lý do:</b> ${returnInfo.reason}</p>
            <p><b>Ghi chú:</b> ${returnInfo.note}</p>
            <p><b>Trạng thái:</b>
                <c:choose>
                    <c:when test="${returnInfo.status == 0}">⏳ Chờ duyệt</c:when>
                    <c:when test="${returnInfo.status == 1}">✔ Đã duyệt</c:when>
                    <c:when test="${returnInfo.status == 2}">✖ Từ chối</c:when>
                </c:choose>
            </p>

            <!-- Bảng sản phẩm -->
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
                            <td>
                                <fmt:formatNumber value="${d.price}" groupingUsed="true" maxFractionDigits="0"/>
                                ₫
                            </td>
                            <td>
                                <c:set var="subtotal" value="${d.quantity * d.price}" />
                                <fmt:formatNumber value="${subtotal}" groupingUsed="true" maxFractionDigits="0"/>
                                ₫
                                <c:set var="total" value="${total + subtotal}" />
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" style="text-align:right;"><strong>Tổng cộng:</strong></td>
                        <td><strong>
                                <fmt:formatNumber value="${total}" groupingUsed="true" maxFractionDigits="0"/>
                                ₫
                            </strong></td>
                    </tr>
                </tbody>

                <!-- Nút duyệt / từ chối -->
                <div style="margin-top: 24px;">
                    <c:if test="${returnInfo.status == 0}">
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="returnId" value="${returnInfo.id}" />
                            <button type="submit" name="action" value="approve"
                                    class="btn-approve"
                                    onclick="return confirm('Bạn có chắc muốn duyệt đơn hoàn trả này?');">
                                ✔ Duyệt đơn hoàn
                            </button>
                        </form>
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="returnId" value="${returnInfo.id}" />
                            <button type="submit" name="action" value="reject"
                                    class="btn-reject"
                                    onclick="return confirm('Bạn có chắc muốn từ chối đơn hoàn trả này?');">
                                ✖ Từ chối đơn hoàn
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${returnInfo.status == 1}">
                        <div style="margin-top:18px;color:green;font-weight:bold;">✔ Yêu cầu hoàn trả đã được duyệt.</div>
                    </c:if>
                    <c:if test="${returnInfo.status == 2}">
                        <div style="margin-top:18px;color:#dc3545;font-weight:bold;">✖ Yêu cầu hoàn trả đã bị từ chối.</div>
                    </c:if>
                </div>

        </div>

    </body>
</html>
