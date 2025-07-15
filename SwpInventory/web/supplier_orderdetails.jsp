

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng - Nhà cung cấp</title>
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
                align-items: center;
                justify-content: space-between;
                background-color: #82CAFA;
                color: white;
                padding: 12px 24px;
                position: relative;
            }
            .header-left {
                display: flex;
                align-items: center;
            }
            .header-left h1 {
                margin: 0;
                font-size: 1.8rem;
                font-weight: 700;
            }
            .nav {
                display: flex;
                gap: 12px;
                margin-left: 40px;
            }
            .nav a {
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: 600;
                transition: background-color 0.3s ease;
                white-space: nowrap;
                text-decoration: none;
            }
            .nav a:hover,
            .nav a.active {
                background-color: #787ff6;
            }
            .container {
                max-width: 800px;
                margin: 32px auto;
                padding: 24px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
            }
            h2 {
                color: #007bff;
                margin-bottom: 16px;
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
            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tbody tr:hover {
                background-color: #FDF9DA;
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
            @media (max-width: 600px) {
                .header, .container {
                    padding: 12px;
                }
                .header-left {
                    flex-basis: 100%;
                    justify-content: center;
                }
                .nav {
                    margin-left: 0;
                    flex-wrap: wrap;
                    justify-content: center;
                    gap: 6px;
                }
                .container {
                    max-width: 99vw;
                }
                th, td {
                    font-size: 0.86rem;
                    padding: 5px;
                }
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-left">
                <h1> Nhà Cung Cấp</h1>
                <div class="nav">
                    <a href="supplier_order">Đơn hàng</a>
                    <a href="supplier-dashboard?view=approved">Đã cung cấp</a>
                    <a href="supplier_logout.jsp">Đăng xuất</a>
                </div>
            </div>
        </div>

        <div class="container" style="text-align: center">
            <a href="supplier_order" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại danh sách đơn</a>
            <h2>Chi tiết đơn hàng #${order.orderId}</h2>

            <p><b>Mã đơn:</b> ${order.orderId}</p>
            <p><b>Ngày tạo:</b> ${order.orderDate}</p>
            <p><b>Nhân viên tạo:</b> ${order.employeeId}</p>
            <p><b>Ghi chú:</b> ${order.note}</p>
            <p><b>Trạng thái:</b>
                <c:choose>
                    <c:when test="${order.status == 0}">⏳ Chờ duyệt</c:when>
                    <c:when test="${order.status == 1}">✔ Đã duyệt</c:when>
                    <c:when test="${order.status == 2}">✖ Từ chối</c:when>
                    <c:when test="${order.status == 3}">🚚 Đã cung cấp</c:when>
                </c:choose>
            </p>

            <!-- Nút xác nhận đã giao hàng: chỉ hiện khi status == 1 -->
            <c:if test="${order.status == 1}">
                <form method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="${order.orderId}" />
                    <button type="submit" name="action" value="delivered"
                            class="btn-delivered"
                            onclick="return confirm('Xác nhận đã giao hàng cho cửa hàng này?');">
                        🚚 Đã giao hàng
                    </button>
                </form>
            </c:if>

            <!-- Bảng danh sách sản phẩm -->
            <table>
                <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn vị</th>
                        <th>Giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="total" value="0" />
                    <c:forEach var="od" items="${orderDetailsList}">
                        <tr>
                            <td><strong>${od.productName}</strong></td>
                            <td>${od.quantity}</td>
                            <td>${od.unit}</td>
                            <td>${od.price}</td>
                            <td>
                                <c:set var="subtotal" value="${od.quantity * od.price}" />
                                ${subtotal}
                                <c:set var="total" value="${total + subtotal}" />
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" style="text-align:right;"><strong>Tổng cộng:</strong></td>
                        <td><strong>${total}</strong></td>
                    </tr>
                </tbody>
            </table>

            <!-- Nút duyệt/từ chối -->
            <div style="margin-top: 24px;">
                <c:if test="${order.status == 0}">
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="orderId" value="${order.orderId}" />
                        <button type="submit" name="action" value="approve"
                                class="btn-approve"
                                onclick="return confirm('Bạn chắc chắn muốn duyệt đơn hàng này?');">
                            ✔ Duyệt đơn hàng
                        </button>
                    </form>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="orderId" value="${order.orderId}" />
                        <button type="submit" name="action" value="reject"
                                class="btn-reject"
                                onclick="return confirm('Bạn chắc chắn muốn từ chối đơn hàng này?');">
                            ✖ Từ chối đơn hàng
                        </button>
                    </form>
                </c:if>
                <c:if test="${order.status == 1}">
                    <div style="margin-top:18px;color:green;font-weight:bold;">✔ Đơn hàng đã được duyệt.</div>
                </c:if>
                <c:if test="${order.status == 2}">
                    <div style="margin-top:18px;color:#dc3545;font-weight:bold;">✖ Đơn hàng đã bị từ chối.</div>
                </c:if>
                <c:if test="${order.status == 3}">
                    <div style="margin-top:18px;color:#007bff;font-weight:bold;">🚚 Đơn hàng đã được cung cấp.</div>
                </c:if>
            </div>
        </div>
    </body>
</html>