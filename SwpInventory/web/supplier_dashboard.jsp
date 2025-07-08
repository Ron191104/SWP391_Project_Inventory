<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Nhà Cung Cấp</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            body {
                margin: 0;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #82CAFA;
                padding: 16px 32px;
                color: white;
            }
            .header h1 {
                margin: 0;
                font-size: 24px;
            }
            .nav {
                display: flex;
                align-items: center;
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

            /* ------ Notification Bell Dropdown ------ */
            .notification-dropdown-wrapper {
                position: relative;
                display: inline-block;
                margin-left: 16px;
            }
            .notification-bell {
                cursor: pointer;
                position: relative;
                color: white;
                font-size: 1.3rem;
                border: none;
                background: none;
                outline: none;
            }
            .notification-badge {
                position: absolute;
                top: -8px;
                right: -8px;
                background: red;
                color: white;
                border-radius: 50%;
                font-size: 0.8em;
                padding: 2px 7px;
                font-weight: bold;
            }
            .notification-dropdown-box {
                display: none;
                position: absolute;
                top: 30px;
                right: 0;
                background: #fff;
                color: #333;
                box-shadow: 0 0 8px #aaa;
                border-radius: 6px;
                min-width: 250px;
                max-width: 350px;
                z-index: 999;
                max-height: 320px;
                overflow-y: auto;
                flex-direction: column;
            }
            .notification-dropdown-box .notification-title {
                padding: 8px 12px;
                border-bottom: 1px solid #eee;
                font-weight: 600;
                background: #f4f4f4;
            }
            .notification-dropdown-box .notify-item {
                display: block;
                padding: 10px 12px;
                text-decoration: none;
                color: #333;
                border-bottom: 1px solid #f4f4f4;
                font-size: 0.95em;
            }
            .notification-dropdown-box .notify-item:last-child {
                border-bottom: none;
            }
            .notification-dropdown-box .notify-item:hover {
                background: #f2f8ff;
            }
            .notification-dropdown-box .no-notify {
                padding: 14px;
                color: #888;
                text-align: center;
            }
            /* ------ End Notification ------ */

            .main-content {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .cards {
                display: flex;
                gap: 20px;
                margin-bottom: 40px;
                flex-wrap: wrap;
            }

            .card {
                flex: 1;
                min-width: 200px;
                padding: 20px;
                color: white;
                border-radius: 8px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .card.orange {
                background-color: #FFA500;
            }
            .card.cyan {
                background-color: #00CED1;
            }
            .card.indigo {
                background-color: #4B0082;
            }
            .card.green {
                background-color: #28a745;
            }

            .dashboard-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 20px;
            }

            .section-card {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 16px;
            }

            .section-header h2 {
                margin: 0;
                font-size: 20px;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            th, td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #82CAFA;
                color: white;
                text-align: left;
            }

            .product {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .product img {
                width: 32px;
                height: 32px;
                border-radius: 4px;
            }

            .price {
                font-weight: bold;
                color: #333;
            }

            .sno {
                width: 40px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Nhà Cung Cấp</h1>
            <div class="nav">
                <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
                <a href="supplier-dashboard?view=approved"><i class="fas fa-check"></i> Đã cung cấp</a>
                <!-- Notification bell dropdown -->
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
                                        <div style="font-size:0.9em;color:#888;">${order.orderDate}</div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="no-notify">Không có đơn hàng mới</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <main class="main-content">

            <!-- Summary Cards -->
            <section class="cards">
                <div class="card orange">
                    <div>
                        <p>100</p>
                        <p>Customers</p>
                    </div>
                    <i class="fas fa-user"></i>
                </div>
                <div class="card cyan">
                    <div>
                        <p>100</p>
                        <p>Suppliers</p>
                    </div>
                    <i class="fas fa-user-check"></i>
                </div>
                <div class="card indigo">
                    <div>
                        <p>100</p>
                        <p>Purchase Invoice</p>
                    </div>
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="card green">
                    <div>
                        <p>105</p>
                        <p>Sales Invoice</p>
                    </div>
                    <i class="fas fa-file-invoice"></i>
                </div>
            </section>

            <!-- Dashboard Content Grid -->
            <section class="dashboard-grid">

                <!-- Purchase & Sales Chart -->
                <div class="section-card">
                    <div class="section-header">
                        <h2>Purchase & Sales</h2>
                        <select>
                            <option>2022</option>
                            <option>2023</option>
                            <option selected>2024</option>
                        </select>
                    </div>
                    <img src="https://storage.googleapis.com/a1aa/image/c868b569-edcd-49f6-34db-68201db812a0.jpg" alt="Chart" style="width: 100%; border-radius: 6px;">
                </div>

                <!-- Recently Added Products -->
                <div class="section-card">
                    <div class="section-header">
                        <h2>Recently Added Products</h2>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th class="sno">Sno</th>
                                <th>Products</th>
                                <th class="price">Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Ví dụ động -->
                            <c:forEach var="product" items="${recentProducts}">
                                <tr>
                                    <td class="sno">${product.id}</td>
                                    <td class="product">
                                        <img src="${product.image}" alt="${product.name}">
                                        ${product.name}
                                    </td>
                                    <td class="price">$${product.price}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </section>
        </main>
        <script>
            // Toggle notification dropdown on bell click
            const bell = document.getElementById('notifyBell');
            const box = document.getElementById('notifyBox');
            if (bell && box) {
                bell.addEventListener('click', function (e) {
                    e.stopPropagation();
                    box.style.display = box.style.display === 'flex' ? 'none' : 'flex';
                });
                window.addEventListener('click', function () {
                    box.style.display = 'none';
                });
                box.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            }
        </script>
    </body>
</html>