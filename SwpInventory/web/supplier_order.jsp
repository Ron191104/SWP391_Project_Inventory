<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách đơn hàng từ cửa hàng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #82CAFA;
                padding: 0px 24px;
                color: white;
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .header-left h1 {
                font-size: 1.8rem;
                margin-right: 32px;
                color: white;
            }

            .nav {
                display: flex;
                gap: 16px;
            }

            .nav a {
                color: white;
                font-weight: bold;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 4px;
            }

            .nav a:hover {
                background-color: #5aa0e8;
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 16px;
            }

            .notification-dropdown-wrapper {
                position: relative;
            }

            .notification-bell {
                background: none;
                border: none;
                color: white;
                font-size: 1.3rem;
                position: relative;
                cursor: pointer;
            }

            .notification-badge {
                position: absolute;
                top: -6px;
                right: -6px;
                background: red;
                color: white;
                border-radius: 50%;
                font-size: 0.75rem;
                padding: 2px 6px;
            }

            .notification-dropdown-box {
                display: none;
                position: absolute;
                top: 36px;
                right: 0;
                background: white;
                color: #333;
                box-shadow: 0 0 8px #aaa;
                border-radius: 6px;
                min-width: 250px;
                z-index: 999;
            }

            .notification-title {
                padding: 8px 12px;
                font-weight: 600;
                background: #f4f4f4;
            }

            .notify-item {
                display: block;
                padding: 10px 12px;
                color: #333;
                border-bottom: 1px solid #eee;
                text-decoration: none;
                font-size: 0.95em;
            }

            .no-notify {
                padding: 14px;
                color: #888;
                text-align: center;
            }

            .user-menu {
                position: relative;
            }

            .user-menu img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid white;
                cursor: pointer;
            }

            .dropdown-menu {
                display: none;
                position: absolute;
                right: 0;
                top: 50px;
                background-color: white;
                box-shadow: 0 0 12px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
                overflow: hidden;
                min-width: 180px;
                z-index: 999;
            }

            .user-menu:hover .dropdown-menu {
                display: block;
            }

            .dropdown-menu a {
                display: block;
                padding: 10px 16px;
                color: #333;
                text-decoration: none;
                transition: background-color 0.2s;
            }

            .dropdown-menu a:hover {
                background-color: #f4f4f4;
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
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
                text-align: left;
            }

            th {
                background-color: #82CAFA;
                color: white;
            }

            .status-label {
                font-weight: bold;
            }

            .btn-detail {
                background-color: #007bff;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 0.9rem;
            }

            .btn-detail:hover {
                background-color: #0056b3;
            }

            select {
                padding: 6px 12px;
                border-radius: 6px;
                border: 2px solid #82CAFA;
                font-size: 1em;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-left">
                <h1>Nhà Cung Cấp</h1>
                <div class="nav">
                    <a href="${pageContext.request.contextPath}/supplier_dashboard">
                        <i class="fas fa-chart-pie"></i> Dashboard
                    </a>
                    <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
                    <a href="supplier_return_requests"><i class="fas fa-undo-alt"></i> Yêu cầu hoàn hàng</a>
                </div>
            </div>
            <div class="header-right">
                <div class="notification-dropdown-wrapper">
                    <button class="notification-bell" id="notifyBell" title="Thông báo đơn hàng mới">
                        <i class="fas fa-bell"></i>
                        <c:if test="${not empty newOrders}">
                            <span class="notification-badge">${fn:length(newOrders)}</span>
                        </c:if>
                    </button>
                    <div class="notification-dropdown-box" id="notifyBox">
                        <div class="notification-title">Thông báo đơn hàng mới</div>
                        <c:choose>
                            <c:when test="${not empty newOrders}">
                                <c:forEach var="order" items="${newOrders}">
                                    <a class="notify-item" href="supplier_orderdetails?orderId=${order.orderId}">
                                        Đơn hàng mới #${order.orderId} từ NV ${order.employeeId}
                                        <div style="font-size: 0.9em; color: #888;">${order.orderDate}</div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="no-notify">Không có đơn hàng mới</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="user-menu">
                    <img src="<%= request.getContextPath() + '/' + (session.getAttribute("userImage") != null && !session.getAttribute("userImage").toString().isEmpty() ? session.getAttribute("userImage") : "images/default-avatar.png") %>" alt="Avatar người dùng" />
                    <div class="dropdown-menu">
                        <span style="padding:12px 16px; color:#4CAF50; font-weight:bold;">
                            <%= session.getAttribute("userName") %>
                        </span>
                        <a href="<%= request.getContextPath() %>/myprofile">Hồ sơ</a>
                        <a href="<%= request.getContextPath() %>/changepassworduser">Đổi mật khẩu</a>
                        <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <h2>Danh sách đơn hàng từ cửa hàng</h2>
            <p style="color:red;">Tổng số đơn hàng: ${fn:length(orderList)}</p>
            <p style="color:blue;">Supplier ID đang đăng nhập: ${sessionScope.supplier.supplierId}</p>
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
                            <td>${order.employeeId} </td>
                            <td>${order.note}</td>
                            <td>
                                <span class="status-label">
                                    <c:choose>
                                        <c:when test="${order.status == 0}">⏳ Chờ duyệt</c:when>
                                        <c:when test="${order.status == 1}">✔ Đã duyệt</c:when>
                                        <c:when test="${order.status == 2}">✖ Từ chối</c:when>
                                        <c:when test="${order.status == 3}">🚚 Đã cung cấp</c:when>
                                        <c:otherwise> 🗑 Đã hủy</c:otherwise>
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
        <script>
            // Toggle notification dropdown on bell click
            const bell = document.getElementById('notifyBell');
            const box = document.getElementById('notifyBox');
            if (bell && box) {
                bell.addEventListener('click', function (e) {
                    e.stopPropagation();
                    box.style.display = box.style.display === 'flex' ? 'none' : 'flex';
                });
                // Click outside closes dropdown
                window.addEventListener('click', function () {
                    box.style.display = 'none';
                });
                // Prevent closing when clicking inside box
                box.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            }
        </script>
    </body>
</html>