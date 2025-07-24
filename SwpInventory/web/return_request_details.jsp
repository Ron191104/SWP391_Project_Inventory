<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết yêu cầu trả hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                background-color: #f4f4f4;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #82CAFA;
                padding: 10px 24px;
                color: white;
            }

            .header h1 {
                font-size: 1.4rem;
                font-weight: bold;
                margin: 0;
            }

            .nav {
                display: flex;
                gap: 16px;
                align-items: center;
            }

            .nav a {
                color: white;
                font-weight: bold;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 6px;
            }

            .nav a:hover {
                background: rgba(255, 255, 255, 0.2);
            }

            .nav a.active {
                background: rgba(0,0,0,0.15);
            }

            .notification-wrapper {
                position: relative;
                margin-right: 20px;
                font-size: 1.2rem;
            }

            .notification-badge {
                position: absolute;
                top: -8px;
                right: -8px;
                background-color: red;
                color: white;
                font-size: 0.7rem;
                font-weight: bold;
                padding: 2px 6px;
                border-radius: 50%;
            }

            .user-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid white;
            }

            .container {
                max-width: 900px;
                margin: 30px auto;
                background: white;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                text-align: center;
            }

            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                color: #007bff;
                font-weight: bold;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            h2 {
                color: #2c3e50;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #82CAFA;
                color: white;
            }

            .total-row td {
                font-weight: bold;
                background-color: #f8f8f8;
            }

            .status-approved {
                color: green;
                font-weight: bold;
                margin-top: 10px;
            }
        </style>
    </head>

    <body>

        <!-- HEADER -->
        <div class="header">
            <h1>Quản lý sản phẩm</h1>
            <div class="nav">
                <a href="product_list" class="active">Sản phẩm</a>
                <a href="import_goods.html">Nhập kho</a>
                <a href="export_goods.html">Xuất kho</a>
                <a href="stats.html">Thống kê</a>

                <div class="notification-wrapper">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
                </div>

                <img src="https://i.pravatar.cc/40" alt="Avatar người dùng" class="user-avatar">
            </div>
        </div>

        <!-- NỘI DUNG CHI TIẾT -->
        <div class="container">

            <a href="return_requests" class="back-link">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách yêu cầu trả hàng
            </a>

            <h2>Chi tiết yêu cầu hoàn trả #${returnRequest.id}</h2>

            <p><strong>Ngày tạo:</strong> ${returnRequest.createdDate}</p>
            <p><strong>Nhân viên gửi:</strong> ${returnRequest.employeeName}</p>
            <p><strong>Lý do:</strong> ${returnRequest.reason}</p>
            <p><strong>Ghi chú:</strong> ${returnRequest.note}</p>
            <p><strong>Trạng thái:</strong>
                <c:choose>
                    <c:when test="${returnRequest.status == 1}">
                        ✔ Đã duyệt
                    </c:when>
                    <c:when test="${returnRequest.status == 2}">
                        ✘ Đã bị từ chối
                    </c:when>
                    <c:otherwise>
                        ⏳ Đang chờ duyệt
                    </c:otherwise>
                </c:choose>
            </p>

            <c:choose>
                <c:when test="${returnRequest.status == 1}">
                    <p class="status-approved">✔ Yêu cầu hoàn trả đã được duyệt.</p>
                </c:when>
                <c:when test="${returnRequest.status == 2}">
                    <p style="color: red; font-weight: bold;">✘ Yêu cầu hoàn trả đã bị từ chối.</p>
                </c:when>
                <c:otherwise>
                    <p style="color: orange; font-weight: bold;">⏳ Yêu cầu đang chờ duyệt.</p>
                </c:otherwise>
            </c:choose>


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
                    <c:set var="total" value="0"/>
                    <c:forEach var="item" items="${returnRequest.details}">
                        <tr>
                            <td>${item.productName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.unit}</td>
                            <td>
                                <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> đ
                            </td>
                            <td>
                                <c:set var="subtotal" value="${item.quantity * item.price}"/>
                                <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/> đ
                                <c:set var="total" value="${total + subtotal}"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr class="total-row">
                        <td colspan="4" style="text-align: right;">Tổng cộng:</td>
                        <td>
                            <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> đ
                        </td>
                    </tr>
                </tbody>
            </table>

        </div>

    </body>
</html>
