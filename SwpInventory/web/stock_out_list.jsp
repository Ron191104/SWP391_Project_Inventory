<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderDetails" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
        <link rel="stylesheet" href="assets/css/filter-icon.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách đơn hàng</title>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }
            a {
                text-decoration: none;
                color: inherit;
            }

            .header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background-color: #82CAFA; /* Màu chủ đạo */
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
            }
            .nav a:hover,
            .nav a.active {
                background-color: #787ff6;
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            /*            .search-box {
                            position: relative;
                        }*/
            .search-box input[type="search"] {
                padding: 6px 28px 6px 12px;
                border-radius: 20px;
                border: none;
                outline: none;
                font-size: 0.8rem;
                width: 150px;
            }

            .notification-wrapper {
                position: relative;
                cursor: pointer;
                color: white;
            }
            .notification-icon {
                width: 24px;
                height: 24px;
                fill: currentColor;
                transition: color 0.3s ease;
            }
            .notification-wrapper:hover, .notification-wrapper:focus-within {
                color: #FDF9DA;
            }
            .notification-badge {
                position: absolute;
                top: -4px;
                right: -4px;
                background-color: #e53935;
                color: white;
                font-size: 0.7rem;
                font-weight: 700;
                border-radius: 50%;
                padding: 2px 6px;
                user-select: none;
                line-height: 1;
            }
            .notification-dropdown {
                position: absolute;
                top: 34px;
                right: 0;
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 240px;
                max-height: 250px;
                overflow-y: auto;
                display: none;
                flex-direction: column;
                padding: 10px 0;
                z-index: 1000;
            }
            .notification-wrapper:hover .notification-dropdown,
            .notification-wrapper:focus-within .notification-dropdown {
                display: flex;
            }
            .notification-dropdown div {
                padding: 8px 16px;
                border-bottom: 1px solid #eee;
                font-size: 0.9rem;
            }
            .notification-dropdown div:last-child {
                border-bottom: none;
            }
            .user-menu {
                position: relative;
                user-select: none;
            }
            .user-menu input[type="checkbox"] {
                display: none;
            }
            .user-menu label {
                cursor: pointer;
                display: flex;
                align-items: center;
                border: 2px solid white;
                border-radius: 50%;
                overflow: hidden;
                width: 40px;
                height: 40px;
                transition: border-color 0.3s ease;
            }
            .user-menu label img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .user-menu label:hover,
            .user-menu label:focus {
                border-color: #FDF9DA;
                outline: none;
            }
            .user-menu nav.dropdown-menu {
                position: absolute;
                top: 50px;
                right: 0;
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 180px;
                flex-direction: column;
                overflow: hidden;
                display: none;
                z-index: 1000;
            }
            .user-menu input[type="checkbox"]:checked + label + nav.dropdown-menu {
                display: flex;
            }
            .user-menu nav.dropdown-menu a {
                padding: 12px 16px;
                border-bottom: 1px solid #eee;
                font-weight: 600;
                white-space: nowrap;
            }
            .user-menu nav.dropdown-menu a:last-child {
                border-bottom: none;
                color: #e53935;
            }
            .user-menu nav.dropdown-menu a:hover {
                background-color: #FDF9DA;
            }
            .container {
                max-width: 800px;
                margin: 32px auto;
                padding: 24px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
            }
            form label {
                display: block;
                margin: 12px 0 6px;
                font-weight: 600;
                color: #333;
            }
            form input[type="text"],
            form input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                font-size: 1rem;
                border-radius: 6px;
                border: 1.8px solid #ccc;
                transition: border-color 0.3s ease;
            }
            form input[type="text"]:focus,
            form input[type="number"]:focus {
                outline: none;
                border-color: #82CAFA;
                box-shadow: 0 0 5px #82CAFAaa;
            }
            form input[type="submit"] {
                margin-top: 10px;
                width: 300px;
                padding: 12px;
                font-size: 1.1rem;
                font-weight: 700;
                border: none;
                color: white;
                background-color: #82CAFA;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            form input[type="submit"]:hover {
                background-color: #21a5fc;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 28px;
                table-layout: fixed;
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
            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tbody tr:hover {
                background-color: #FDF9DA;
            }
            .button-container {
                display: flex;
                justify-content: space-between;
                width: 100%;
            }
            .action-column {
                width: 120px;
            }
            @media (max-width: 600px) {
                .header {
                    flex-wrap: wrap;
                    gap: 10px;
                    padding: 12px 12px;
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
                .header-right {
                    flex-basis: 100%;
                    justify-content: center;
                    gap: 12px;
                }
                .search-box input[type="search"] {
                    width: 120px;
                }
                .search-box input[type="search"]:focus {
                    width: 180px;
                }
            }

            .product-select {
                height: 37px;
                width: 170px;
                padding: 10px 15px;
                border: 2px solid #82CAFA;
                border-radius: 9px;
                font-size: 11px;
                outline: none;

            }
            .form-group {
                position: relative;
                width: 200px;
            }
            .form-control{
                border: none;
                outline: none;
            }
            .form-group .search-icon {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: #aaa;
                pointer-events: none;
            }
            .fas.fa-search.search-icon{
                border: none;
                outline: none;
                color: #89D0F0;
                background-color: white;
            }

        </style>
    </head>
    <body>
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

        <div class="container" style="text-align: center">
            <h2>Danh sách đơn hàng cần xuất kho</h2>



            <c:if test="${totalPages > 1}">
                <div style="margin: 20px auto 0 auto; max-width: 600px; font-weight: bold; text-align: left;">
                    <c:if test="${currentPage > 1}">
                        <a href="stock_out_list?page=${currentPage - 1}" style="margin-right: 10px; text-decoration: none; color: #0b5ed7;">&laquo;</a>
                    </c:if>
                    Trang ${currentPage}/${totalPages}
                    <c:if test="${currentPage < totalPages}">
                        <a href="stock_out_list?page=${currentPage + 1}" style="margin-left: 10px; text-decoration: none; color: #0b5ed7;">&raquo;</a>
                    </c:if>
                </div>
            </c:if>
            <c:if test="${empty stockOutList}">
                <p>Chưa có đơn hàng nào.</p>
            </c:if>
            <c:forEach var="so" items="${stockOutList}">
                <a href="stock_out_detail?id=${so.stockOutId}" style="text-decoration: none; color: inherit;"><!-- forward đến stock out form -->
                    <div style="
                         border: 2px solid #82CAFA;
                         border-radius: 12px;
                         margin: 20px auto;
                         max-width: 600px;
                         box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                         background-color: #f9fcff;
                         font-family: 'Segoe UI', sans-serif;
                         transition: transform 0.2s ease;
                         position: relative;
                         padding-bottom: 40px;">
                        <h3 style="color: #0b5ed7;">Mã đơn #${so.stockOutId}</h3>
                        <p><strong>Xuất tới:</strong> ${storeNameMap[so.storeId]} </p>
                        <p><strong>Ngày tạo:</strong> <fmt:formatDate value="${so.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></p>

                        <c:if test="${so.stockOutDate != null}">
                            <p><strong>Ngày xuất kho:</strong> 
                                <fmt:formatDate value="${so.stockOutDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </p>
                        </c:if>
                        <c:if test="${not empty od.note}">
                            <p><strong>Ghi chú:</strong> ${so.note}</p>
                        </c:if>
                        <p><strong>Trạng thái:</strong>
                            <c:choose>
                                <c:when test="${so.status == 0}">
                                    <span style="color: #17a2b8;">Đã duyệt</span>
                                </c:when>
                                <c:when test="${so.status == 1}">
                                    <span style="color: #ffc107;">Đang vận chuyển</span>
                                </c:when>
                                <c:when test="${so.status == 2}">
                                    <span style="color: #28a745;">Đã xuất kho</span>
                                </c:when>
                            </c:choose>
                        </p>
                        <c:choose>
                            <c:when test="${so.status == 0}">
                                <form method="get" action="stock_out" style="margin-top: 12px;">
                                    <input type="hidden" name="id" value="${so.stockOutId}" />
                                    <button type="submit" style="
                                            background-color: #28a745;
                                            color: white;
                                            border: none;
                                            padding: 8px 16px;
                                            border-radius: 6px;
                                            font-size: 14px;
                                            cursor: pointer;
                                            " onmouseover="this.style.backgroundColor = '#218838'"
                                            onmouseout="this.style.backgroundColor = '#28a745'">
                                        ➤ Tạo phiếu xuất kho
                                    </button>
                                </form>
                            </c:when>
                            <c:when test="${so.status == 2}">
                                <span style="
                                      bottom: 10px;
                                      right: 10px;
                                      background: #cccccc;
                                      color: #666666;
                                      padding: 6px 12px;
                                      border-radius: 4px;
                                      font-size: 12px;
                                      cursor: not-allowed;">
                                    Đã xuất kho
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span style="
                                      bottom: 10px;
                                      right: 10px;
                                      background: #cccccc;
                                      color: #666666;
                                      padding: 6px 12px;
                                      border-radius: 4px;
                                      font-size: 12px;
                                      cursor: not-allowed;">
                                    Đã tạo phiếu xuất kho
                                </span>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </a>

            </c:forEach>
            <c:if test="${totalPages > 1}">
                <div style="text-align: center; margin-top: 20px;">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span style="margin: 0 5px; font-weight: bold; color: #82CAFA;">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="order_list?page=${i}" style="margin: 0 5px; color: #0b5ed7;">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>

        </div>