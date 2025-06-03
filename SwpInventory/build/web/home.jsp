 <!DOCTYPE html>
/<!-- Kiem tra role -->
<span style="padding:0 16px; color:#999; font-size:x-small;">
    <%= session.getAttribute("userRole") %>
</span>
/<!-- Kiem tra dang nhap -->
<%
    if (session.getAttribute("userName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Nhập kho - Quản lý kho</title>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1" name="viewport"/>
        <title>
            Product Selection
        </title>
        <script src="https://cdn.tailwindcss.com">
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <style>
            /* Reset and base */
            /* Custom scrollbar for the right product list */
            .scrollbar-thin::-webkit-scrollbar {
                width: 6px;
            }
            .scrollbar-thin::-webkit-scrollbar-thumb {
                background-color: #f97316; /* orange-500 */
                border-radius: 9999px;
            }
            * {
                box-sizing: border-box;
            }
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #82CAFA;
                color: #333;
            }
            a {
                text-decoration: none;
                color: inherit;
            }
            /* Header */
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
            /* Navigation */
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
                background-color: #787FF6;
            }

            /* Header right - search, notifications, user */
            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            /* Search */
            .search-box {
                position: relative;
            }
            .search-box input[type="search"] {
                padding: 6px 28px 6px 12px;
                border-radius: 20px;
                border: none;
                outline: none;
                font-size: 0.9rem;
                width: 180px;
                transition: width 0.3s ease;
            }
            .search-box input[type="search"]:focus {
                width: 240px;
            }
            .search-box svg {
                position: absolute;
                right: 8px;
                top: 50%;
                transform: translateY(-50%);
                fill: #82CAFA;
                pointer-events: none;
                width: 16px;
                height: 16px;
            }
            /* Notification */
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
                color: #c8e6c9;
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
            /* Notification dropdown */
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
            /* Show notification dropdown on focus-within or hover */
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
            /* User avatar & dropdown - pure CSS toggle */
            .user-menu {
                position: relative;
                user-select: none;
            }
            /* Hidden checkbox to toggle dropdown */
            .user-menu input[type="checkbox"] {
                display: none;
            }
            /* Avatar style */
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
            /* Change border on hover or focus */
            .user-menu label:hover,
            .user-menu label:focus {
                border-color: #c8e6c9;
                outline: none;
            }
            /* Dropdown menu */
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
            /* Show dropdown when checkbox is checked */
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
                background-color: #f0f0f0;
            }
            /* Container */
            .container {
                max-width: 800px;
                margin: 32px auto;
                padding: 24px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
            }
            /* Form */
            form label {
                display: block;
                margin: 12px 0 6px;
                font-weight: 600;
                color: #333;
            }
            form input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                font-size: 1rem;
                border-radius: 6px;
                border: 1.8px solid #ccc;
                transition: border-color 0.3s ease;
            }
            form input[type="number"]:focus {
                outline: none;
                border-color: #82CAFA;
                box-shadow: 0 0 5px #82CAFAaa;
            }
            form input[type="submit"] {
                margin-top: 20px;
                width: 100%;
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
                background-color: #787FF6;
            }
            /* Table */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 28px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px 10px;
                text-align: left;
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
                background-color: #e2f0d9;
            }
            /* Responsive */
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
            select {
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                background-image: url("data:image/svg+xml;charset=US-ASCII,%3csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='none' stroke='%23666' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' class='feather feather-chevron-down' viewBox='0 0 24 24'%3e%3cpolyline points='6 9 12 15 18 9'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 0.5rem center;
                background-size: 1em;
                padding-right: 2rem;
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="header-left">
                <h1>Xuất kho</h1>
                <nav class="nav" role="navigation" aria-label="?i?u h??ng chính">
                    <a href="product_list.html">Sản phẩm</a>
                    <a href="import_goods.html">Nhập kho</a>
                    <a href="export_goods.html" class="active" aria-current="page">Xuất kho</a>
                    <a href="stats.html">Thống kê</a>
                    <a href="login.html">Đăng xuất</a>
                </nav>
            </div>
            <div class="header-right">
                <div class="search-box" role="search">
                    <input type="search" placeholder="Tìm kiếm..." aria-label="Tìm kiếm sản phẩm hoặc xuất kho..." id="searchInput" />
                    <svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M15.5 14h-.79l-.28-.27a6.471 6.471 0 001.48-5.34C14.77 5.4 12.61 3.5 9.99 3.5S5.22 5.4 5.22 8.39c0 3 2.13 5.41 4.77 5.41a4.87 4.87 0 003.22-1.3l.27.28v.79l5 4.99L20.49 19l-4.99-5zM9.99 13.29a4.43 4.43 0 01-4.43-4.42c0-2.44 2-4.42 4.43-4.42s4.42 1.97 4.42 4.41c0 2.48-1.98 4.43-4.42 4.43z"/></svg>
                </div>
                <div class="notification-wrapper" tabindex="0" aria-label="Thông báo" role="button">
                    <svg class="notification-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
                    <path d="M12 22c1.1 0 1.99-.9 1.99-2H10c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 00-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1.99 2H20l-2-2z"/>
                    </svg>
                    <span class="notification-badge" aria-label="S? thông báo">3</span>
                    <div class="notification-dropdown" tabindex="-1" aria-hidden="true" aria-label="Danh sách thông báo">
                        <div>Bạn có đơn hàng cần xử lý.</div>
                        <div>Sản phẩm SP002 sắp hết hàng.</div>
                        <div>Báo cáo tháng 5 đã cập nhật.</div>
                    </div>
                </div>
                <div class="user-menu">
                    <input type="checkbox" id="user-menu-toggle" />
                    <label for="user-menu-toggle" aria-haspopup="true" aria-expanded="false" aria-controls="user-menu-dropdown" aria-label="Menu người dùng">
                        <img src="images/<%= session.getAttribute("userAvatar") %>" alt="Avatar người dùng" class="user-avatar" />
                    </label>
                    <nav class="dropdown-menu" id="user-menu-dropdown" role="menu" aria-hidden="true">
                        <span style="padding:12px 16px; color:#82CAFA; font-weight:bold;">
                            <%= session.getAttribute("userName") %>
                        </span>
                        <a href="myprofile.jsp" role="menuitem" tabindex="0">My Profile</a>
                        <a href="change_password.jsp" role="menuitem" tabindex="0">Change Password</a>
                        <a href="logout" role="menuitem" tabindex="0">Log Out</a>
                    </nav>
                </div>
        </header>

    <body class="bg-white font-sans">
        <div class="max-w-7xl mx-auto p-4 space-y-4">
            <!-- Top cards container -->
            <div class="flex flex-col sm:flex-row sm:space-x-4 space-y-4 sm:space-y-0">
                <div class="flex-1 bg-[#f89f2b] rounded-md p-4 flex items-center justify-between">
                    <div>
                        <p class="text-white font-bold text-lg leading-none">
                            100
                        </p>
                        <p class="text-white text-xs mt-1">
                            Customers
                        </p>
                    </div>
                    <i class="fas fa-user text-white text-3xl">
                    </i>
                </div>
                <div class="flex-1 bg-[#1ad1e8] rounded-md p-4 flex items-center justify-between">
                    <div>
                        <p class="text-white font-bold text-lg leading-none">
                            100
                        </p>
                        <p class="text-white text-xs mt-1">
                            Suppliers
                        </p>
                    </div>
                    <i class="fas fa-user-check text-white text-3xl">
                    </i>
                </div>
                <div class="flex-1 bg-[#152a4a] rounded-md p-4 flex items-center justify-between">
                    <div>
                        <p class="text-white font-bold text-lg leading-none">
                            100
                        </p>
                        <p class="text-white text-xs mt-1">
                            Purchase Invoice
                        </p>
                    </div>
                    <i class="far fa-file-alt text-white text-3xl">
                    </i>
                </div>
                <div class="flex-1 bg-[#2bb673] rounded-md p-4 flex items-center justify-between">
                    <div>
                        <p class="text-white font-bold text-lg leading-none">
                            105
                        </p>
                        <p class="text-white text-xs mt-1">
                            Sales Invoice
                        </p>
                    </div>
                    <i class="far fa-file text-white text-3xl">
                    </i>
                </div>
            </div>
            <!-- Main content container -->
            <div class="flex flex-col lg:flex-row lg:space-x-4 space-y-4 lg:space-y-0">
                <!-- Left panel: Purchase & Sales -->
                <div class="flex-1 bg-white rounded-md shadow p-4">
                    <div class="flex justify-between items-center mb-2">
                        <h2 class="font-bold text-gray-900 text-base">
                            Purchase &amp; Sales
                        </h2>
                        <div class="flex items-center space-x-2 text-xs text-gray-600">
                            <div class="flex items-center space-x-1">
                                <span class="w-3 h-3 rounded-full bg-green-600 inline-block">
                                </span>
                                <span>
                                    Sales
                                </span>
                            </div>
                            <div class="flex items-center space-x-1">
                                <span class="w-3 h-3 rounded-full bg-red-500 inline-block">
                                </span>
                                <span>
                                    Purchase
                                </span>
                            </div>
                            <select aria-label="Select year" class="border border-gray-300 rounded text-xs text-gray-700 py-1 px-2">
                                <option>
                                    2022
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <img alt="Bar chart showing purchase and sales data for months January to August with green bars for sales and red bars for purchase" class="w-full h-auto" height="300" src="https://storage.googleapis.com/a1aa/image/d6d7b68e-710e-4faf-cd8c-82d58374f48d.jpg" width="600"/>
                    </div>
                </div>
                <!-- Right panel: Recently Added Products -->
                <div class="w-full lg:w-96 bg-white rounded-md shadow p-4">
                    <div class="flex justify-between items-center mb-2">
                        <h2 class="font-bold text-gray-900 text-base">
                            Recently Added Products
                        </h2>
                        <i class="fas fa-ellipsis-v text-gray-500 cursor-pointer">
                        </i>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm text-gray-700 border-collapse border border-gray-200">
                            <thead class="border-b border-gray-300">
                                <tr>
                                    <th class="py-2 px-3 cursor-pointer select-none">
                                        Sno
                                        <i class="fas fa-sort">
                                        </i>
                                    </th>
                                    <th class="py-2 px-3 cursor-pointer select-none">
                                        Products
                                        <i class="fas fa-sort">
                                        </i>
                                    </th>
                                    <th class="py-2 px-3 cursor-pointer select-none">
                                        Price
                                        <i class="fas fa-sort">
                                        </i>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-gray-200">
                                    <td class="py-2 px-3 align-middle">
                                        1
                                    </td>
                                    <td class="py-2 px-3 flex items-center space-x-3">
                                        <img alt="Apple Earpods product image white wireless earbuds with charging case" class="w-8 h-8 object-contain" height="32" src="https://storage.googleapis.com/a1aa/image/b38547d9-a007-4907-25d1-a815008c8735.jpg" width="32"/>
                                        <span>
                                            Apple Earpods
                                        </span>
                                    </td>
                                    <td class="py-2 px-3 align-middle text-gray-600">
                                        $891.2
                                    </td>
                                </tr>
                                <tr class="border-b border-gray-200">
                                    <td class="py-2 px-3 align-middle">
                                        2
                                    </td>
                                    <td class="py-2 px-3 flex items-center space-x-3">
                                        <img alt="iPhone 11 product image smartphone with colorful screen" class="w-8 h-8 object-contain" height="32" src="https://storage.googleapis.com/a1aa/image/71585b8e-da2a-4dbf-ad8f-4cc9054fec7a.jpg" width="32"/>
                                        <span>
                                            iPhone 11
                                        </span>
                                    </td>
                                    <td class="py-2 px-3 align-middle text-gray-600">
                                        $668.51
                                    </td>
                                </tr>
                                <tr class="border-b border-gray-200">
                                    <td class="py-2 px-3 align-middle">
                                        3
                                    </td>
                                    <td class="py-2 px-3 flex items-center space-x-3">
                                        <img alt="Samsung smartphone product image with colorful screen" class="w-8 h-8 object-contain" height="32" src="https://storage.googleapis.com/a1aa/image/39cda159-647b-4af8-90e6-7dc4714da2c7.jpg" width="32"/>
                                        <span>
                                            samsung
                                        </span>
                                    </td>
                                    <td class="py-2 px-3 align-middle text-gray-600">
                                        $522.29
                                    </td>
                                </tr>
                                <tr>
                                    <td class="py-2 px-3 align-middle">
                                        4
                                    </td>
                                    <td class="py-2 px-3 flex items-center space-x-3">
                                        <img alt="Macbook Pro laptop product image with screen and keyboard" class="w-8 h-8 object-contain" height="32" src="https://storage.googleapis.com/a1aa/image/a8a43d21-dcef-4d37-1a1c-a5e17104302d.jpg" width="32"/>
                                        <span>
                                            Macbook Pro
                                        </span>
                                    </td>
                                    <td class="py-2 px-3 align-middle text-gray-600">
                                        $291.01
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>


