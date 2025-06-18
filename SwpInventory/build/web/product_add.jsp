<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Thêm Sản Phẩm</title>
        <style>


            form {
                background: #fff;
                padding: 24px 32px;
                border-radius: 8px;
                max-width: 800px;
                margin: 40px auto;
            }

            h2 {
                text-align: center;
                color: #82CAFA;
                margin-bottom: 32px;
                font-weight: 700;
                font-size: 32px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }


            form label {
                display: block;
                color: #82CAFA;
                font-weight: 450;
                margin-bottom: 10px;
            }

            input[type="text"],
            input[type="number"],
            input[type="date"],textarea
            {
                width: 95%;
                padding: 12px 14px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 12px;
                font-size: 16px;
                height: 10px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }
            select{
                width: 99%;
            }
            .product-select {
                padding: 12px 14px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 12px;
                font-size: 16px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }


            textarea {
                width: 95%;

                height: 30px;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            input[type="date"]:focus,
            select:focus,
            textarea:focus {
                border-color: #5c6ac4;
                outline: none;
            }

            button {
                background-color: #82CAFA;
                border: none;
                padding: 12px 16px;
                color: white;
                font-size: 1rem;
                font-weight: 600;
                border-radius: 8px;
                width: 100%;

            }

            button:hover {
                background-color: #787FF6;
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
                margin-right: 8px;
                min-width: 16px;
                text-align: center;
            }
            .nav a:hover,
            .nav a.active {
                background-color: #787ff6;
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
                transition: background-color 0.3s ease;
                color: white;
                display: flex;
                align-items: center;
            }
            .dropdown-label i {
                margin-right: 8px;
                min-width: 16px;
                text-align: center;
            }
            .dropdown-label:hover {
                background-color: #787ff6;
                color: white;
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

            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
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

            @media (max-width: 600px) {
                .header {
                    flex-wrap: wrap;
                    gap: 10px;
                    padding: 12px 12px;
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

                            <a href="product_add.jsp"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                        </div>
                    </div>
                    <a href="import_goods.html"><i class="fas fa-truck-loading"></i> Nhập kho</a>
                    <a href="export_goods.html"><i class="fas fa-truck"></i> Xuất kho</a>
                    <a href="stats.html"><i class="fas fa-chart-bar"></i> Thống kê</a>
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
                    <label for="user-menu-toggle" aria-haspopup="true" aria-expanded="false" aria-controls="user-menu-dropdown" aria-label="Menu người dùng">
                        <img src="https://i.pravatar.cc/40" alt="Avatar người dùng" class="user-avatar" />
                    </label>
                    <nav class="dropdown-menu" id="user-menu-dropdown" role="menu" aria-hidden="true">
                        <a href="myprofile.html" role="menuitem" tabindex="0">My Profile</a>
                        <a href="change_password.html" role="menuitem" tabindex="0">Change Password</a>
                        <a href="login.html" role="menuitem" tabindex="0">Log Out</a>
                    </nav>
                </div>
            </div>
        </div>

        <form action="addproduct" method="post">
            <h2>Thêm Sản Phẩm</h2>

            <label for="name">Tên sản phẩm</label>
            <input type="text" id="name" name="name" required />

            <label for="barcode">Barcode</label>
            <input type="text" id="barcode" name="barcode" required />

            <label for="category_id">Loại sản phẩm</label>
            <select id="category_id" name="category_id" class="product-select" required>
                <option value="" selected>Chọn category</option>
                <c:forEach var="c" items="${listC}">
                    <option value="${c.id}">${c.name}</option>
                </c:forEach>
            </select>

            <label for="supplier_id">Mã nhà cung cấp</label>
            <input type="text" id="supplier_id" name="supplier_id" required />

            <label for="price_in">Giá nhập</label>
            <input type="number" id="price_in" name="price_in" step="0.01" min="0" required />

            <label for="price_out">Giá bán</label>
            <input type="number" id="price_out" name="price_out" step="0.01" min="0" required />

            <label for="quantity">Số lượng</label>
            <input type="number" id="quantity" name="quantity" min="0" required />

            <label for="unit">Đơn vị tính</label>
            <input type="text" id="unit" name="unit" required />

            <label for="mfd">Ngày sản xuất</label>
            <input type="date" id="manufacture_date" name="manufacture_date" />

            <label for="exp">Ngày hết hạn</label>
            <input type="date" id="expired_date" name="expired_date" />

            <label for="image">Ảnh</label>
            <input type="text" id="image" name="image" />

            <label for="description">Mô tả</label>
            <textarea id="description" name="description" rows="4"></textarea>

            <button type="submit">Thêm sản phẩm</button>
        </form>
    </body>
</html>

