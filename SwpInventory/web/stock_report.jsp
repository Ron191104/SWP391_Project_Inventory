<%-- 
    Document   : stock_report
    Created on : Jul 18, 2025, 1:26:24 AM
    Author     : User
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo xuất nhập kho</title>
    </head>
    <body>
        <style>

            .tab-container {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .tab-button {
                padding: 10px 20px;
                border: 1px solid #ccc;
                background-color: white;
                cursor: pointer;
                border-radius: 4px;
                transition: 0.3s;
            }

            .tab-button:hover {
                background-color: #e6f0ff;
            }

            .tab-button.active {
                background-color: #82CAFA;
                color: white;
                border-color: #82CAFA;
            }

            .tab-content-box {
                padding: 16px;
                border: 2px solid #82CAFA;
                border-top: none;
                border-radius: 0 0 8px 8px;
                background-color: #fff;
            }


            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 28px auto;
                table-layout: fixed;
                justify-content: center;

            }

            th, td {
                border: 1px solid #ddd;
                padding: 5px;
                text-align: left;
                width: 20px;
                font-size: 0.85rem;
                text-align: center;
            }
            th {
                background-color: #82CAFA;
                color: white;
                font-weight: 700;
            }
            .container {
                max-width: 100%;
                padding: 10px 24px 24px 24px;
                background: white;
                margin-left: 10px;
                margin-top: 0px;
            }
            .form-control1 {
                height: 13px;
                width: 80px;
                padding: 10px 15px;
                border: 2px solid #82CAFA;
                border-radius: 9px;
                font-size: 11px;
                outline: none;
            }
            .button-filter {
                margin-left: 10px;
                padding: 6px 12px;
                font-size: 0.85rem;
                font-weight: 600;
                border: none;
                color: white;
                background-color: #82CAFA;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.25s ease, transform 0.15s ease;
            }

            .button-filter:hover {
                background-color: #78AEE6;
                transform: scale(1.02);
            }
            .button-reset {
                margin-left: 10px;
                padding: 6px 12px;
                font-size: 0.85rem;
                font-weight: 600;
                border: none;
                color: white;
                background-color: #82CAFA;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.25s ease, transform 0.15s ease;
            }

            .button-reset:hover {
                background-color: #78AEE6;
                transform: scale(1.02);
            }
            .btn-view {
                background-color: #128bfc;
                color: white;
                border: none;
                height: 23px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }


        </style>
        <div class="header">
            <div class="header-left">
                <h1>Tên kho</h1>
                <div class="nav">
                    <a href="${pageContext.request.contextPath}/inventory_dashboard">
                        <i class="fas fa-warehouse"></i> Kho Hàng
                    </a>
                    <div class="dropdown">
                        <input type="checkbox" id="product-dropdown" />
                        <label for="product-dropdown" class="dropdown-label">
                            <i class="fas fa-box"></i> <span style="font-weight:600">Sản phẩm</span>
                        </label>
                        <div class="dropdown-menu">
                            <a href="product_list"><i class="fas fa-list"></i> Danh sách sản phẩm</a>

                            <a href=""><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                            <a href=""><i class="fas fa-list"></i> Danh sách phân loại</a>


                        </div>
                    </div>
                    <a href="stock_in"><i class="fas fa-truck-loading"></i> Nhập kho</a>
                    <a href="stock_out_list"><i class="fas fa-truck"></i> Xuất kho</a>
                    <a href="stats.html"><i class="fas fa-chart-bar"></i> Thống kê</a>

                    <div class="dropdown">
                        <input type="checkbox" id="store-dropdown" />
                        <label for="store-dropdown" class="dropdown-label">
                            <i class="fas fa-store"></i> <span style="font-weight:600">Cửa hàng</span>
                        </label>
                        <div class="dropdown-menu">
                            <a href="store_product_list"><i class="fas fa-list"></i> Danh sách sản phẩm</a>
                            <a href="store_product_add"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                            <a href="store_category_list"><i class="fas fa-list"></i> Danh sách phân loại</a>
                        </div>
                    </div>
                    <c:if test="${sessionScope.userRole == 4}">
                        <a href="AdminDashboardServlet" class="nav-link" style="color: #4CAF50; font-weight: bold;">
                            <i class="fas fa-arrow-left"></i> Trở về Dashboard Admin
                        </a>
                    </c:if>
                </div>
            </div>
            <div class="header-right">

                <div class="notification-wrapper" tabindex="0" aria-label="Thông báo" role="button">
                    <svg class="notification-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
                    <path d="M12 22c1.1 0 1.99-.9 1.99-2H10c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 00-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1.99 2H20l-2-2z"/>
                    </svg>
                    <span class="notification-badge" aria-label="Số thông báo">3</span>
                    <div class="notification-dropdown" tabindex="-1" aria-hidden="true" aria-label="Danh sách thông báo">
                        <div>Bạn có đơn hàng mới cần xử lý.</div>
                        <div>Sản phẩm SP002 sắp hết hàng.</div>
                        <div>Báo cáo tháng 5 đã được cập nhật.</div>
                    </div>
                </div>
                <div class="user-menu">
                    <input type="checkbox" id="user-menu-toggle" />
                    <label for="user-menu-toggle">
                        <img src="<%= request.getContextPath() + "/" +
                            (session.getAttribute("userImage") != null && !session.getAttribute("userImage").toString().isEmpty()
                                ? session.getAttribute("userImage")
                                : "images/default-avatar.png") %>"
                             alt="Avatar người dùng"
                             style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />
                    </label>
                    <nav class="dropdown-menu">
                        <span style="padding:12px 16px; color:#0080C0; font-weight:bold;">
                            <%= session.getAttribute("userName") %>
                        </span>
                        <a href="<%= request.getContextPath() %>/myprofile">Profile</a>
                        <a href="<%= request.getContextPath() %>/changepassworduser">Change Password</a>
                        <a href="login.jsp"><i class=""></i> Login</a>
                    </nav>
                </div>
            </div>
        </div>
        <link rel="stylesheet" href="assets/css/menu.css">

        <div class="container">
            <h3>Báo cáo xuất nhập kho:</h3>
            <form method="get" action="stock_report">
                Từ ngày: <input type="date" name="from" id="fromDate" value="${param.from}" class="form-control1" max="<%= java.time.LocalDate.now() %>" required>
                đến: <input type="date" name="to" id="toDate" value="${param.to}" class="form-control1" max="<%= java.time.LocalDate.now() %>" required>
                <input type="hidden" name="tab" id="tabInput" value="${param.tab != null ? param.tab : 'in'}">
                <c:if test="${not empty param.from or not empty param.to}">
                    <button type="button" onclick="window.location = 'stock_report?tab=${param.tab}'" class="button-reset">× Xóa bộ lọc</button>
                </c:if>
                <button type="submit" class="button-filter">Lọc</button>

            </form>
            <c:if test="${not empty error}">
                <p style="color: red; font-weight: bold;">${error}</p>
            </c:if>

            <br>

            <div class="tab-container">
                <button class="tab-button active" onclick="showTab('in')">Nhập kho</button>
                <button class="tab-button" onclick="showTab('out')">Xuất kho</button>
            </div>

            <div id="in-tab" class="tab-content active">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Nhà cung cấp</th>
                        <th>Ngày</th>
                        <th>Ghi chú</th>
                        <th>Thao tác</th>
                    </tr>
                    <c:forEach var="s" items="${stockInList}">
                        <tr>
                            <td>${s.stockInId}</td>
                            <td>${s.supplierName}</td>
                            <td><fmt:formatDate value="${s.stockInDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                            <td>${s.note}</td>
                            <td>
                                <form action="stock_in_detail" style="margin: 0;">
                                    <input type="hidden" name="id" value="${s.stockInId}">
                                    <button type="submit" class="btn-view">Xem chi tiết</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div id="out-tab" class="tab-content">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Lí do</th>
                        <th>Ngày</th>
                        <th>Ghi chú</th>
                        <th>Thao tác</th>
                    </tr>
                    <c:forEach var="s" items="${stockOutList}">
                        <tr>
                            <td>${s.stockOutId}</td>
                            <td>${s.reason}</td>
                            <td><fmt:formatDate value="${s.stockOutDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                            <td>${s.note}</td>
                            <td>
                                <form action="stock_out_detail" style="margin: 0;">
                                    <input type="hidden" name="id" value="${s.stockOutId}">
                                    <button type="submit" class="btn-view">Xem chi tiết</button>
                                </form>
                            </td>
                        </tr>
                        
                    </c:forEach>
                </table>
            </div>
        </div>  
        <script>
            function showTab(tab) {
                document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(div => div.classList.remove('active'));

                if (tab === 'in') {
                    document.querySelectorAll('.tab-button')[0].classList.add('active');
                    document.getElementById('in-tab').classList.add('active');
                } else {
                    document.querySelectorAll('.tab-button')[1].classList.add('active');
                    document.getElementById('out-tab').classList.add('active');
                }

                document.getElementById('tabInput').value = tab;
            }

            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const currentTab = urlParams.get('tab') || 'in';
                showTab(currentTab);
            }

            document.querySelector('form').addEventListener('submit', function (e) {
                const from = document.getElementById('fromDate').value;
                const to = document.getElementById('toDate').value;
                const today = new Date().toISOString().split('T')[0];

                if (from > to) {
                    alert("Khoảng thời gian không hợp lệ. Vui lòng nhập lại");
                    e.preventDefault();
                } else if (to > today || from > today) {
                    alert("Vui lòng chọn khoảng thời gian hợp lệ");
                    e.preventDefault();
                }
            });
        </script>

    </body>
</html>
