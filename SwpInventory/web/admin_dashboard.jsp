<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("userName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Object roleObj = session.getAttribute("userRole");
    if (roleObj == null || !roleObj.toString().equals("4")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                font-size: 16px;
                overflow-x: hidden;
            }
            a {
                text-decoration: none;
                color: inherit;
            }

            .header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background-color: #4CAF50;
                color: white;
                padding: 12px 24px;
                flex-wrap: wrap;
            }
            .header-left {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
            }
            .header-left h1 {
                margin: 0;
                font-size: 2rem;
                font-weight: 700;
                display: flex;
                align-items: center;
            }
            .header-left h1 i {
                margin-right: 10px;
            }
            .admin-role-label {
                color: #fff6c5;
                font-weight: bold;
                background: #c62828;
                border-radius: 7px;
                padding: 2px 10px;
                margin-left: 10px;
                font-size: 1rem;
            }

            .nav {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-left: 30px;
            }
            .nav a {
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: 600;
                transition: background-color 0.3s ease;
                white-space: nowrap;
                display: flex;
                align-items: center;
            }
            .nav a i {
                margin-right: 8px;
                color: #4CAF50;
            }
            .nav a:hover, .nav a.active {
                background-color: #388E3C;
            }

            .dropdown {
                position: relative;
            }
            .dropdown input[type="checkbox"] {
                display: none;
            }
            .dropdown-label {
                cursor: pointer;
                padding: 8px 16px;
                border-radius: 4px;
                color: white;
                display: flex;
                align-items: center;
            }
            .dropdown-label i {
                margin-right: 8px;
                color: #4CAF50;
            }
            .dropdown-menu {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 200px;
                display: none;
                flex-direction: column;
                z-index: 1001;
            }
            .dropdown input[type="checkbox"]:checked + .dropdown-label + .dropdown-menu {
                display: flex;
            }
            .dropdown-menu a {
                padding: 12px 16px;
                border-bottom: 1px solid #eee;
                font-weight: 600;
                color: #333;
            }
            .dropdown-menu a:last-child {
                border-bottom: none;
            }
            .dropdown-menu a:hover {
                background-color: #FDF9DA;
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
                margin-top: 10px;
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
            }
            .notification-badge {
                position: absolute;
                top: -4px;
                right: -4px;
                background-color: #fff6c5;
                color: #d32f2f;
                font-size: 0.7rem;
                font-weight: 700;
                border-radius: 50%;
                padding: 2px 6px;
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
            .notification-wrapper:hover .notification-dropdown {
                display: flex;
            }
            .notification-dropdown div {
                padding: 8px 16px;
                border-bottom: 1px solid #eee;
                font-size: 0.9rem;
            }
            .user-menu {
                position: relative;
            }
            .user-menu input[type="checkbox"] {
                display: none;
            }
            .user-menu label {
                cursor: pointer;
                border: 2px solid white;
                border-radius: 50%;
                overflow: hidden;
                width: 40px;
                height: 40px;
            }
            .user-menu label img {
                width: 100%;
                height: 100%;
                object-fit: cover;
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
                display: none;
                flex-direction: column;
                overflow: hidden;
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
                color: #4CAF50;
            }
            .user-menu nav.dropdown-menu a:hover {
                background-color: #FDF9DA;
            }

            .cards {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                justify-content: flex-start;
                margin: 20px 10px;
            }
            .card {
                flex: 1 1 150px;
                max-width: 220px;
                background-color: #FDF9DA;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 10px;
                text-align: center;
                position: relative;
                height: 60px;
                min-width: 150px;
            }
            .card.orange {
                background: #FFF3E0;
            }
            .card.cyan {
                background: #E0F7FA;
            }
            .card.indigo {
                background: #E8EAF6;
            }
            .card.green {
                background: #E8F5E9;
            }
            .card p {
                margin: 0;
                font-size: 0.9rem;
                font-weight: bold;
            }
            .card i {
                font-size: 1rem;
                position: absolute;
                top: 10px;
                right: 10px;
                color: #4CAF50;
            }

            @media (max-width: 768px) {
                .header {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .nav {
                    justify-content: center;
                    margin-left: 0;
                }
                .header-right {
                    flex-wrap: wrap;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <form action="AddCustomerServlet" method="post">
        <div class="header">
            <div class="header-left">
                <h1><i class="fas fa-user-shield"></i> Admin Dashboard</h1>
                <span class="admin-role-label">(Administrator)</span>
                <div class="nav">
                    <a href="inventory_dashboard.jsp"><i class="fas fa-box"></i> Quản ký kho</a>
                    <a href="store_dashboard.jsp"><i class="fas fa-truck-loading"></i> Cửa hàng</a>
                    <a href="supplier_dashboard"><i class="fas fa-truck"></i> Nhà cung cấp</a>
                    <a href="stats.html"><i class="fas fa-chart-bar"></i> Thống kê</a>
                    <a href="login.jsp"><i class="fas fa-cash-register"></i> POS</a>
                    <div class="dropdown">
                        <input type="checkbox" id="admin-dropdown" />
                        <label for="admin-dropdown" class="dropdown-label">
                            <i class="fas fa-user-shield"></i> Quản trị
                        </label>
                        <div class="dropdown-menu">
                            <a href="user-management"><i class="fas fa-users-cog"></i> Quản lý người dùng</a>
                            <a href="system-logs"><i class="fas fa-file-alt"></i> Nhật ký hệ thống</a>
                            <a href="settings.jsp"><i class="fas fa-cogs"></i> Cấu hình hệ thống</a>
                            <a href="admin-approve"><i class="fas fa-user-check"></i> Duyệt tài khoản</a>
                            <a href="admin/categories">Quản lý danh mục sản phẩm</a>
                            <a href="admin/suppliers">Quản lý nhà cung cấp</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-right">
                <div class="notification-wrapper">
                    <svg class="notification-icon" viewBox="0 0 24 24">
                    <path d="M12 22c1.1 0 1.99-.9 1.99-2H10c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 00-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1.99 2H20l-2-2z"/>
                    </svg>
                    <span class="notification-badge">5</span>
                    <div class="notification-dropdown">
                        <div>Yêu cầu cấp quyền mới từ user.</div>
                        <div>Hệ thống phát hiện đăng nhập bất thường.</div>
                        <div>Báo cáo tháng 5 đã được cập nhật.</div>
                        <div>Bạn có đơn hàng mới cần xử lý.</div>
                        <div>Sản phẩm SP002 sắp hết hàng.</div>
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
        <span style="padding:12px 16px; color:#4CAF50; font-weight:bold;">
            <%= session.getAttribute("userName") %>
        </span>
        <a href="<%= request.getContextPath() %>/myprofile">Profile</a>
        <a href="<%= request.getContextPath() %>/changepassworduser">Change Password</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>
</div>
                <span style="padding:0 16px; color:#fff6c5; font-size:x-small;">
                    <%= session.getAttribute("userRole") %>
                </span>
            </div>
        </div>

        <!-- Main content -->
        <main class="main-content">
            <section class="cards">
    <article class="card orange">
        <p>${customerCount}</p>
        <p>Customers</p>
        <i class="fas fa-user"></i>
    </article>
    <article class="card cyan">
        <p>${supplierCount}</p>
        <p>Suppliers</p>
        <i class="fas fa-user-check"></i>
    </article>
    <article class="card indigo">
        <p>${purchaseInvoiceCount}</p>
        <p>Purchase Invoice</p>
        <i class="fas fa-file-alt"></i>
    </article>
    <article class="card green">
        <p>${salesInvoiceCount}</p>
        <p>Sales Invoice</p>
        <i class="fas fa-file-invoice-dollar"></i>
    </article>
</section>
        </main>
    </body>
</html>
