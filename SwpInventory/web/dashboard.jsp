<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="assets/css/filter-icon.css">
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
                max-width: 100%;
                padding: 24px;
                background: white;
                margin-left: 10px;


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

            .action-column {
                width: 120px;
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
            }
            .fas.fa-search.search-icon{
                border: none;
                outline: none;
                color: #89D0F0;
                background-color: white;
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



            /* Dashboard Cards */
            .cards {
                display: flex;
                justify-content: space-between;
                margin: 20px 0;
            }

            .card {
                background-color: #FDF9DA;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 10px;
                flex: 1;
                margin: 0 10px;
                text-align: center;
                position: relative;
                height: 60px;
                width: 30px;
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
            }

            /* Section Card for Purchase & Sales */
            .section-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin: 20px 0;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .section-header h2 {
                margin: 0;
                font-size: 1.5rem;
            }

            .section-header button {
                background: none;
                border: none;
                cursor: pointer;
            }

            /* Recently Added Products Table */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            th {
                background-color: #82CAFA;
                color: white;
                font-weight: bold;
            }

            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tbody tr:hover {
                background-color: #FDF9DA;
            }
            .dashboard-grid {
                display: flex;
                justify-content: space-between;
                gap: 20px; /* Khoảng cách giữa biểu đồ và danh sách sản phẩm */
            }

            .dashboard-content {
                display: flex;
                flex-direction: row; /* Sắp xếp theo hàng */
                width: 100%; /* Đảm bảo chiếm toàn bộ chiều rộng */
            }

            .section-card {
                flex: 1; /* Cho phép các phần chiếm không gian đều nhau */
                margin: 20px; /* Khoảng cách giữa các phần */
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
                    <a href="${pageContext.request.contextPath}/inventory_dashboard">
                    <i class="fas fa-warehouse"></i> Kho Hàng
                </a>
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

        <!-- Content -->
        <main class="main-content">
            <!-- Cards -->
            <section aria-label="Summary cards" class="cards">
                <article aria-label="100 Customers" class="card orange">
                    <div>
                        <p>
                            100
                        </p>
                        <p>
                            Customers
                        </p>
                    </div>
                    <i class="fas fa-user">
                    </i>
                </article>
                <article aria-label="100 Suppliers" class="card cyan">
                    <div>
                        <p>
                            100
                        </p>
                        <p>
                            Suppliers
                        </p>
                    </div>
                    <i class="fas fa-user-check">
                    </i>
                </article>
                <article aria-label="100 Purchase Invoice" class="card indigo">
                    <div>
                        <p>
                            100
                        </p>
                        <p>
                            Purchase Invoice
                        </p>
                    </div>
                    <i class="fas fa-file-alt">
                    </i>
                </article>
                <article aria-label="105 Sales Invoice" class="card green">
                    <div>
                        <p>
                            105
                        </p>
                        <p>
                            Sales Invoice
                        </p>
                    </div>
                    <i class="fas fa-file-invoice">
                    </i>
                </article>
            </section>
            <!-- Dashboard grid -->
            <section class="dashboard-grid">
                <!-- Left: Purchase & Sales chart -->
                <section aria-labelledby="purchase-sales-title" class="section-card">
                    <div class="section-header">
                        <h2 id="purchase-sales-title">
                            Purchase &amp; Sales
                        </h2>
                        <div style="display:flex; align-items:center; gap:1rem; font-size:0.875rem; color:#475569;">
                            <div style="display:flex; align-items:center; gap:0.25rem;">
                                <span style="width:0.75rem; height:0.75rem; background:#22c55e; border-radius:9999px; display:inline-block;">
                                </span>
                                <span>
                                    Sales
                                </span>
                            </div>
                            <div style="display:flex; align-items:center; gap:0.25rem;">
                                <span style="width:0.75rem; height:0.75rem; background:#ef4444; border-radius:9999px; display:inline-block;">
                                </span>
                                <span>
                                    Purchase
                                </span>
                            </div>
                            <select aria-label="Select year" style="border:1px solid #cbd5e1; border-radius:0.375rem; padding:0.25rem 0.5rem; font-size:0.875rem; color:#475569;">
                                <option>
                                    2022
                                </option>
                                <option>
                                    2023
                                </option>
                                <option>
                                    2024
                                </option>
                            </select>
                        </div>
                    </div>
                    <img alt="Bar chart showing purchase and sales data for 2022 with green bars above zero and red bars below zero" height="300" src="https://storage.googleapis.com/a1aa/image/c868b569-edcd-49f6-34db-68201db812a0.jpg" style="width:100%; height:auto;" width="600"/>
                </section>
                <!-- Right: Recently Added Products -->
                <section aria-labelledby="recent-products-title" class="section-card">
                    <div class="section-header">
                        <h2 id="recent-products-title">
                            Recently Added Products
                        </h2>
                        <button aria-label="More options">
                            <i class="fas fa-ellipsis-v">
                            </i>
                        </button>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th class="sno" scope="col">
                                    Sno
                                </th>
                                <th scope="col">
                                    Products
                                </th>
                                <th class="price" scope="col">
                                    Price
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="sno" scope="row">
                                    1
                                </td>
                                <td class="product">
                                    <img alt="Apple Earpods product image, white wireless earbuds with charging case" height="32" src="https://storage.googleapis.com/a1aa/image/d89970b7-10b9-42d3-9bfb-112bbb41696d.jpg" width="32"/>
                                    Apple Earpods
                                </td>
                                <td class="price">
                                    $891.2
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    2
                                </td>
                                <td class="product">
                                    <img alt="iPhone 11 product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/51afd909-b603-4c36-8c52-b04ccc1a2f01.jpg" width="32"/>
                                    iPhone 11
                                </td>
                                <td class="price">
                                    $668.51
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    3
                                </td>
                                <td class="product">
                                    <img alt="Samsung product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/5fec6a85-5dab-4942-c504-2388d0ae8592.jpg" width="32"/>
                                    samsung
                                </td>
                                <td class="price">
                                    $522.29
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    4
                                </td>
                                <td class="product">
                                    <img alt="Motorola Razr product image, foldable smartphone" height="32" src="https://storage.googleapis.com/a1aa/image/e4f3a196-123d-4b64-749a-6fa0cba4ac8c.jpg" width="32"/>
                                    Motorola Razr
                                </td>
                                <td class="price">
                                    $891.91
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    5
                                </td>
                                <td class="product">
                                    <img alt="OnePlus 8T product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/80065068-99af-4d2a-1b56-0a17c0e0fbe1.jpg" width="32"/>
                                    OnePlus 8T
                                </td>
                                <td class="price">
                                    $799.99
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    6
                                </td>
                                <td class="product">
                                    <img alt="Google Pixel 5 product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/56201929-41c5-4189-fc13-a577967675a5.jpg" width="32"/>
                                    Google Pixel 5
                                </td>
                                <td class="price">
                                    $699.00
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    7
                                </td>
                                <td class="product">
                                    <img alt="Sony WH-1000XM4 product image, wireless noise-cancelling headphones" height="32" src="https://storage.googleapis.com/a1aa/image/b66bb397-abb4-4108-21d6-ed55eee10439.jpg" width="32"/>
                                    Sony WH-1000XM4
                                </td>
                                <td class="price">
                                    $348.00
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    8
                                </td>
                                <td class="product">
                                    <img alt="Apple Watch Series 6 product image, smartwatch with red band" height="32" src="https://storage.googleapis.com/a1aa/image/6ff7c86a-a2d6-42bb-e447-f5dc39bf7162.jpg" width="32"/>
                                    Apple Watch Series 6
                                </td>
                                <td class="price">
                                    $399.99
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    9
                                </td>
                                <td class="product">
                                    <img alt="Amazon Echo Dot product image, smart speaker with fabric cover" height="32" src="https://storage.googleapis.com/a1aa/image/1e1bb74f-c69c-48d4-e593-db46062b2ce4.jpg" width="32"/>
                                    Amazon Echo Dot
                                </td>
                                <td class="price">
                                    $49.99
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    10
                                </td>
                                <td class="product">
                                    <img alt="Fitbit Charge 4 product image, fitness tracker with black band" height="32" src="https://storage.googleapis.com/a1aa/image/fe209010-4a01-4072-49a6-a8feaf2d7eb1.jpg" width="32"/>
                                    Fitbit Charge 4
                                </td>
                                <td class="price">
                                    $129.95
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    11
                                </td>
                                <td class="product">
                                    <img alt="DJI Mavic Air 2 product image, compact drone with camera" height="32" src="https://storage.googleapis.com/a1aa/image/00ad230c-89ca-49d4-699f-48c6cfa35d29.jpg" width="32"/>
                                    DJI Mavic Air 2
                                </td>
                                <td class="price">
                                    $799.00
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    12
                                </td>
                                <td class="product">
                                    <img alt="GoPro Hero 9 product image, action camera with waterproof housing" height="32" src="https://storage.googleapis.com/a1aa/image/cb1192d5-8b29-4ed2-979b-de3ebfe8142f.jpg" width="32"/>
                                    GoPro Hero 9
                                </td>
                                <td class="price">
                                    $399.99
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    13
                                </td>
                                <td class="product">
                                    <img alt="Kindle Paperwhite product image, e-reader with black bezel" height="32" src="https://storage.googleapis.com/a1aa/image/f0bdbded-0faa-41d7-9ed0-d0972e6b217c.jpg" width="32"/>
                                    Kindle Paperwhite
                                </td>
                                <td class="price">
                                    $129.99
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    14
                                </td>
                                <td class="product">
                                    <img alt="Nintendo Switch product image, gaming console with red and blue controllers" height="32" src="https://storage.googleapis.com/a1aa/image/89873458-d51d-4dea-ffda-2609a678b7cb.jpg" width="32"/>
                                    Nintendo Switch
                                </td>
                                <td class="price">
                                    $299.99
                                </td>
                            </tr>
                            <tr>
                                <td class="sno" scope="row">
                                    15
                                </td>
                                <td class="product">
                                    <img alt="MacBook Pro product image, laptop with silver body" height="32" src="https://storage.googleapis.com/a1aa/image/ed48439b-b586-4f09-a60d-9b8c172107f7.jpg" width="32"/>
                                    MacBook Pro
                                </td>
                                <td class="price">
                                    $2399.00
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </section>
            </section>
        </main>
    </div>
</div>
<script>
    // Toggle profile dropdown visibility on avatar click
    function toggleDropdown(event) {
        event.stopPropagation();
        const dropdown = document.getElementById('profileDropdown');
        const btn = event.currentTarget;
        const isShown = dropdown.classList.contains('show');
        if (isShown) {
            dropdown.classList.remove('show');
            btn.setAttribute('aria-expanded', 'false');
        } else {
            dropdown.classList.add('show');
            btn.setAttribute('aria-expanded', 'true');
        }
    }

    // Close dropdown if clicking outside
    window.addEventListener('click', () => {
        const dropdown = document.getElementById('profileDropdown');
        const btn = document.querySelector('.profile-button');
        if (dropdown.classList.contains('show')) {
            dropdown.classList.remove('show');
            btn.setAttribute('aria-expanded', 'false');
        }
    });
</script>
</body>
</html>
