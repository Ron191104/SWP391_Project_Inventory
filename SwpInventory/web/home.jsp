<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <link rel="stylesheet" href="assets/css/filter-icon.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tên kho - Quản lý kho</title>
    <style>
        /* Các style không thay đổi */
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
            position: relative;
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
            margin-right: 8px; /* Space icon from text */
            min-width: 16px;
            text-align: center;
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

        .login-register {
            display: flex;
            align-items: center;
            gap: 10px;
            color: white;
        }

        .login-register a {
            display: flex;
            align-items: center;
            color: white;
        }

        .login-register .fas {
            margin-right: 5px;
        }

        /* Dropdown styles */
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
            transition: background-color 0.3s ease;
            color: white; /* Light yellow for distinct color */
            display: flex;
            align-items: center;
        }
        .dropdown-label i {
            margin-right: 8px; /* Space icon from text */
            min-width: 16px;
            text-align: center;
        }
        .dropdown-label:hover {
            background-color: #787ff6; /* Same hover color as other links */
            color: white; /* Ensure text color remains white */
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
            z-index: 1000;
        }
        .dropdown input[type="checkbox"]:checked + .dropdown-label + .dropdown-menu {
            display: flex;
        }
        .dropdown-menu a {
            padding: 12px 16px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            white-space: nowrap;
            color: #333;
            display: block;
        }
        .dropdown-menu a:last-child {
            border-bottom: none;
        }
        .dropdown-menu a:hover {
            background-color: #FDF9DA;
        }

        /* Các style khác không thay đổi */
        .container {
            max-width: 100%;
            padding: 24px;
            background: white;
            border-radius: 8px;
        }
        .info-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            margin-top: 20px; /* Add some space above */
        }
        .info-container img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .info-container h2 {
            font-size: 1.5rem;
            margin: 10px 0;
        }
        .info-container p {
            font-size: 1rem;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left">
            <h1>Tên kho</h1>
            <div class="nav">
                <a href="dashboard.html">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <div class="dropdown">
                    <input type="checkbox" id="product-dropdown" />
                    <label for="product-dropdown" class="dropdown-label">
                        <i class="fas fa-box"></i> Sản phẩm
                    </label>
                    <div class="dropdown-menu">
                        <a href="product_list"><i class="fas fa-list"></i> Danh sách sản phẩm</a>
                        <a href="add_product.html"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                    </div>
                </div>
                <a href="import_goods.html"><i class="fas fa-truck-loading"></i> Nhập kho</a>
                <a href="export_goods.html"><i class="fas fa-truck"></i> Xuất kho</a>
                <a href="stats.html"><i class="fas fa-chart-bar"></i> Thống kê</a>
            </div>
        </div>
        <div class="header-right">
            <div class="login-register">
                <a href="login.jsp">
                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                </a>
                <a href="register.jsp">
                    <i class="fas fa-user-plus"></i> Đăng ký
                </a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="info-container">
            <img src="assets/image/ngu.jpg" alt="Warehouse Image" />
            <h2>Thông tin kho</h2>
            <p>Kho của chúng tôi được trang bị đầy đủ các thiết bị hiện đại, giúp quản lý hàng hóa một cách hiệu quả và an toàn. Chúng tôi cung cấp dịch vụ lưu trữ và quản lý hàng hóa cho các doanh nghiệp với nhiều loại hình dịch vụ khác nhau.</p>
            <p>Địa chỉ: 123 Đường ABC, Thành phố XYZ</p>
            <p>Điện thoại: (012) 345-6789</p>
        </div>
    </div>
</body>
</html>
