<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("userName") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Object roleObj = session.getAttribute("userRole");
    if (roleObj == null || !roleObj.toString().equals("4")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background: #eaf6ff;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #81D4FA;
                padding: 12px 24px;
                color: white;
                flex-wrap: nowrap;
            }
            .header-left {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .header-left h1 {
                font-size: 1.8rem;
                margin: 0;
                display: flex;
                align-items: center;
            }
            .header-left h1 i {
                margin-right: 10px;
            }
            .admin-role-label {
                background: #c62828;
                border-radius: 8px;
                padding: 2px 10px;
                font-weight: bold;
                color: #fff6c5;
                font-size: 0.9rem;
            }
            .nav {
                display: flex;
                gap: 10px;
                flex-wrap: nowrap;
                align-items: center;
            }
            .nav a {
                color: white;
                padding: 8px 16px;
                font-weight: 600;
                border-radius: 4px;
                transition: background 0.3s;
                display: flex;
                align-items: center;
                text-decoration: none;
            }
            .nav a i {
                margin-right: 6px;
                color: #1B608A;
            }
            .nav a:hover,
            .nav a.active {
                background-color: #1B608A;
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
                color: #1B608A;
            }
            .dropdown-menu {
                position: absolute;
                top: 100%;
                left: 0;
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
                gap: 10px;
                margin-right: 10px;
                position: relative;
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
                display: block;
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
                color: #0080C0;
            }
            .user-menu nav.dropdown-menu a:hover {
                background-color: #FDF9DA;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-left">
                <h1>
                    <a href="${pageContext.request.contextPath}/AdminDashboardServlet" style="color: white; text-decoration: none; display: flex; align-items: center;">
                        <i class="fas fa-user-shield"></i> Admin
                    </a>
                </h1>
                <span class="admin-role-label">(Administrator)</span>
                <div class="nav">
                    <a href="${pageContext.request.contextPath}/inventory_dashboard.jsp"><i class="fas fa-box"></i> Quản lý kho</a>
                    <a href="${pageContext.request.contextPath}/store_dashboard"><i class="fas fa-truck-loading"></i> Cửa hàng</a>
                    <a href="${pageContext.request.contextPath}/store-inventory-statistics"><i class="fas fa-chart-bar"></i> Thống kê số lượng</a>
                    <a href="${pageContext.request.contextPath}/financial-report"><i class="fas fa-chart-bar"></i> Thống kê doanh thu</a>
                    <div class="dropdown">
                        <input type="checkbox" id="admin-dropdown" />
                        <label for="admin-dropdown" class="dropdown-label">
                            <i class="fas fa-user-shield"></i> Quản trị
                        </label>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/user-management"><i class="fas fa-users-cog"></i> Quản lý người dùng</a>
                            <a href="${pageContext.request.contextPath}/system-logs"><i class="fas fa-file-alt"></i> Nhật ký hệ thống</a>
                            <a href="${pageContext.request.contextPath}/admin-approve"><i class="fas fa-user-check"></i> Duyệt tài khoản</a>
                            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-list"></i> Danh mục sản phẩm</a>
                            <a href="${pageContext.request.contextPath}/admin/suppliers"><i class="fas fa-handshake"></i> Nhà cung cấp</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-right">
                <div class="user-menu">
                    <input type="checkbox" id="user-menu-toggle" />
                    <label for="user-menu-toggle">
                        <img src="<%= request.getContextPath() + "/" +
                            (session.getAttribute("userImage") != null && !session.getAttribute("userImage").toString().isEmpty()
                                ? session.getAttribute("userImage")
                                : "images/default-avatar.png") %>" alt="Avatar người dùng" />
                    </label>
                    <nav class="dropdown-menu">
                        <span style="padding:12px 16px; color:#0080C0; font-weight:bold;">
                            <%= session.getAttribute("userName") %>
                        </span>
                        <a href="${pageContext.request.contextPath}/myprofile">Profile</a>
                        <a href="${pageContext.request.contextPath}/changepassworduser">Change Password</a>
                        <a href="${pageContext.request.contextPath}/login.jsp">Logout</a>
                    </nav>
                </div>
                <span style="color:#fff6c5; font-size:x-small;">
                    Role: <%= session.getAttribute("userRole") %>
                </span>
            </div>
        </div>
    </body>
</html>
