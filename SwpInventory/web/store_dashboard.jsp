
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <title>JSP Page</title>
        <style>
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

            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }

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
                left: -50%;
                transform: translateX(-50%);
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 180px;
                flex-direction: column;
                overflow: hidden;
                display: none;
                z-index: 1000;
                max-height: 240px;
                overflow-y: auto;
                scrollbar-width: none;
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

            table {
                width: 50%;
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

                font-weight: 600;
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
            .card {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin: 30px;
                padding-left: 30px;

                display: inline-block;
                width: 160px;
                height: 80px;
            }
            .card h3 {
                font-size: 18px;
            }
            .card .value {
                font-size: 1em;
                font-weight: bold;
            }
            .tooltip {
                position: relative;
                display: inline-block;
                cursor: help;
            }
            .tooltip .tooltiptext {
                visibility: hidden;
                width: 180px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 6px;
                position: absolute;
                z-index: 10;
                bottom: 125%;
                left: 50%;
                margin-left: -90px;
                opacity: 0;
                transition: opacity 0.3s;
                font-size: 0.75rem;
            }
            .tooltip:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }

        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-left">
                <h1>Tên kho</h1>
                <div class="nav">
                    <a href="store_dashboard.jsp">

                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <div class="dropdown">
                        <input type="checkbox" id="product-dropdown" />
                        <label for="product-dropdown" class="dropdown-label">
                            <i class="fas fa-box"></i> Sản phẩm
                        </label>
                        <div class="dropdown-menu">
                            <a href="store_product_list"><i class="fas fa-list"></i> Danh sách sản phẩm</a>

                            <a href="store_product_add"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                            <a href="store_category_list"><i class="fas fa-list"></i> Danh sách phân loại</a>

                        </div>
                    </div>
                    <a href="import_goods.html"><i class="fas fa-box-open"></i> Nhập hàng</a>
                    <a href="stats.html"><i class="fas fa-chart-bar"></i> Thống kê</a>
                    <a href="stats.html"><i class="fas fa-shopping-cart"></i> Bán hàng</a>

                    <a href="choose_store"><i class="fas fa-store"></i>Chi nhánh</a>





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
                    <nav class="dropdown-menu" id="user-menu-dropdown">
                        <a href="myprofile.html">My Profile</a>
                        <a href="change_password.html">Change Password</a>
                        <a href="login.html">Log Out</a>
                    </nav>
                </div>
            </div>
        </div>

        <div class="card">
        <h3>Clicks <span class="tooltip">
                <i class="fas fa-info-circle"></i>
                <span class="tooltiptext">Số lần nhấp chuột trên các sản phẩm hoặc quảng cáo.</span>
            </span>
            <div class="value">100</div>
            <div>-13,04%</div>
        </div>

     <div class="card">
        <h3>Clicks <span class="tooltip">
                <i class="fas fa-info-circle"></i>
                <span class="tooltiptext">Số lần nhấp chuột trên các sản phẩm hoặc quảng cáo.</span>
            </span>
            <div class="value">100</div>
            <div>-13,04%</div>
        </div>

    </body>
</html>
