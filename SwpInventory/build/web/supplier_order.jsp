<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Dashboard Nhà Cung Cấp</title>
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
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: 600;
                text-decoration: none;
                transition: background-color 0.3s ease;
                display: inline-block;
                margin-left: 12px;
            }
            .nav a:hover {
                background-color: #787ff6;
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
                font-size: 28px;
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
            .btn-approve {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn-approve:hover {
                background-color: #218838;
            }
            .btn-reject {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn-reject:hover {
                background-color: #c82333;
            }
            .status-label {
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Dashboard Nhà Cung Cấp</h1>
            <div class="nav">
                <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
                <a href="supplier-dashboard?view=approved"><i class="fas fa-check"></i> Đã cung cấp</a>
                <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <div class="container">
            <h2>Danh sách đơn hàng từ cửa hàng</h2>
            <p style="color:red;">Tổng số đơn hàng: ${fn:length(orderList)}</p>
            <p style="color:blue;">Supplier ID đang đăng nhập: ${sessionScope.supplier.supplier_id}</p>
            <p style="color:green;">Số đơn hàng tìm thấy: ${fn:length(orderList)}</p>
            <!-- Bộ lọc trạng thái đơn hàng -->
            <form method="get" action="supplier_order" style="display:inline-block; margin-bottom: 20px;">
                <label for="statusFilter"><b>Trạng thái đơn hàng:</b></label>
                <select name="status" id="statusFilter" style="padding: 8px 16px; border: 2px solid #82CAFA; border-radius: 8px; font-size: 1em;" onchange="this.form.submit()">
                    <option value="">Tất cả trạng thái</option>
                    <option value="0" ${param.status == '0' ? 'selected' : ''}>Chờ duyệt</option>
                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Đã duyệt</option>
                    <option value="2" ${param.status == '2' ? 'selected' : ''}>Từ chối</option>
                    <option value="3" ${param.status == '3' ? 'selected' : ''}>Đã cung cấp</option>
                </select>
            </form>
                
            <table>
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Ngày tạo</th>
                        <th>Nhân viên tạo</th>
                        <th>Ghi chú</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.employeeId}</td>
                            <td>${order.note}</td>
                            <td>
                                <span class="status-label">
                                    <c:choose>
                                        <c:when test="${order.status == 0}">⏳ Chờ duyệt</c:when>
                                        <c:when test="${order.status == 1}">✔ Đã duyệt</c:when>
                                        <c:when test="${order.status == 2}">✖ Từ chối</c:when>
                                        <c:otherwise> 🚚 Đã cung cấp</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <a href="supplier_orderdetails?orderId=${order.orderId}" class="btn-detail" style="background-color:#007bff;color:white;padding:6px 12px;border-radius:4px;text-decoration:none;">
                                    <i class="fas fa-eye"></i> Xem đơn hàng
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
