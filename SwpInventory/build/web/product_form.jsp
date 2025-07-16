<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/S?a s?n ph?m - Qu?n lý kho</title>
    <style>
        /* Reset and base */
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
        /* Header */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #4caf50;
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
            background-color: #388e3c;
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
            fill: #4caf50;
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
            border-color: #4caf50;
            box-shadow: 0 0 5px #4caf50aa;
        }
        form input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            border: none;
            color: white;
            background-color: #4caf50;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        form input[type="submit"]:hover {
            background-color: #388e3c;
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
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left">
            <h1>Thêm/S?a s?n ph?m</h1>
            <div class="nav">
                <a href="product_list.html" class="active">S?n ph?m</a>
                <a href="import_goods.html">Nh?p kho</a>
                <a href="export_goods.html">Xu?t kho</a>
                <a href="stats.html">Th?ng kê</a>
                <a href="login.html">??ng xu?t</a>
            </div>
        </div>
        <div class="header-right">
            <div class="search-box" role="search">
                <input type="search" placeholder="Tìm ki?m..." aria-label="Tìm ki?m s?n ph?m ho?c xu?t kho..." id="searchInput" />
                <svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M15.5 14h-.79l-.28-.27a6.471 6.471 0 001.48-5.34C14.77 5.4 12.61 3.5 9.99 3.5S5.22 5.4 5.22 8.39c0 3 2.13 5.41 4.77 5.41a4.87 4.87 0 003.22-1.3l.27.28v.79l5 4.99L20.49 19l-4.99-5zM9.99 13.29a4.43 4.43 0 01-4.43-4.42c0-2.44 2-4.42 4.43-4.42s4.42 1.97 4.42 4.41c0 2.48-1.98 4.43-4.42 4.43z"/></svg>
            </div>
            <div class="notification-wrapper" tabindex="0" aria-label="Thông báo" role="button">
                <svg class="notification-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
                    <path d="M12 22c1.1 0 1.99-.9 1.99-2H10c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 00-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1.99 2H20l-2-2z"/>
                </svg>
                <span class="notification-badge" aria-label="S? thông báo">3</span>
                <div class="notification-dropdown" tabindex="-1" aria-hidden="true" aria-label="Danh sách thông báo">
                    <div>B?n có ??n hàng m?i c?n x? lý.</div>
                    <div>S?n ph?m SP002 s?p h?t hàng.</div>
                    <div>Báo cáo tháng 5 ?ã ???c c?p nh?t.</div>
                </div>
            </div>
            <div class="user-menu">
                <input type="checkbox" id="user-menu-toggle" />
                <label for="user-menu-toggle" aria-haspopup="true" aria-expanded="false" aria-controls="user-menu-dropdown" aria-label="Menu ng??i dùng">
                    <img src="https://i.pravatar.cc/40" alt="Avatar ng??i dùng" class="user-avatar" />
                </label>
                <nav class="dropdown-menu" id="user-menu-dropdown" role="menu" aria-hidden="true">
                    <a href="myprofile.html" role="menuitem" tabindex="0">My Profile</a>
                    <a href="change_password.html" role="menuitem" tabindex="0">Change Password</a>
                    <a href="login.html" role="menuitem" tabindex="0">Log Out</a>
                </nav>
            </div>
        </div>
    </div>
    <div class="container">
        <form action="/product" method="post">
            <label for="id">Mã s?n ph?m</label>
            <input type="text" id="id" name="id" required>

            <label for="name">Tên s?n ph?m</label>
            <input type="text" id="name" name="name" required>

            <label for="category">Lo?i s?n ph?m</label>
            <input type="text" id="category" name="category" required>

            <label for="price">Giá bán (VN?)</label>
            <input type="number" id="price" name="price" min="0" required>

            <label for="quantity">S? l??ng t?n</label>
            <input type="number" id="quantity" name="quantity" min="0" required>

            <div class="form-actions">
                <input type="submit" value="L?u">
                <a href="product_list.html"><button type="button">H?y</button></a>
            </div>
        </form>
    </div>
</body>
</html>
