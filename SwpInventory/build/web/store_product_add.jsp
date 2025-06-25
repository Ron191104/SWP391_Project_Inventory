<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm sản phẩm</title>

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
            input[type="date"],textarea, select
            {
                width: 95%;
                padding: 12px 14px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                font-size: 16px;
                height: 40px;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }
            select{
                width: 95%;
                height: 50px;
                font-size: 15px;
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

                height: 80px;
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

        <script>
            function fillProductInfo() {
                var select = document.getElementById("productSelect");
                var option = select.options[select.selectedIndex];
                if (option.value === "") {
                    ['barcode', 'price_in', 'unit', 'manufacture_date', 'expired_date', 'quantity', 'description'].forEach(id => document.getElementById(id).value = "");
                    document.getElementById("productImage").style.display = "none";
                    return;
                }
                document.getElementById("barcode").value = option.dataset.barcode;
                document.getElementById("price_in").value = option.dataset.price;
                document.getElementById("unit").value = option.dataset.unit;
                document.getElementById("manufacture_date").value = option.dataset.mfd;
                document.getElementById("expired_date").value = option.dataset.exp;
                document.getElementById("quantity").value = option.dataset.quantity;
                document.getElementById("description").value = option.dataset.description;

                var image = option.dataset.image;
                var imgElement = document.getElementById("productImage");
                imgElement.src = "assets/image/" + image;
                imgElement.style.display = "block";
            }
        </script>

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
                            <a href="category?action=category"><i class="fas fa-list"></i> Danh sách phân loại</a>

                        </div>
                    </div>
                    <a href="import_goods.html"><i class="fas fa-truck-loading"></i> Nhập kho</a>
                    <a href="export_goods.html"><i class="fas fa-truck"></i> Xuất kho</a>
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
        <form action="addstoreproduct" method="post">
            <h2>Thêm sản phẩm</h2>

            <label for="productSelect">Chọn sản phẩm từ kho</label>
            <select id="productSelect" name="product_id" onchange="fillProductInfo()" required>
                <option value="">-- Chọn sản phẩm --</option>
                <c:forEach var="p" items="${listProduct}">
                    <option 
                        value="${p.id}"
                        data-barcode="${p.barcode}"
                        data-price="${p.price}"
                        data-unit="${p.unit}"
                        data-mfd="${p.manufacture_date}"
                        data-exp="${p.expired_date}"
                        data-quantity="${p.quantity}"
                        data-image="${p.image}"
                        data-description="${p.description}">
                        ${p.name}
                    </option>
                </c:forEach>

            </select>

            <label>Barcode</label>
            <input type="text" id="barcode" readonly />

            <label>Giá nhập</label>
            <input type="text" id="price_in" readonly />

            <label>Đơn vị tính</label>
            <input type="text" id="unit" readonly />

            <label>Ngày sản xuất</label>
            <input type="text" id="manufacture_date" readonly />

            <label>Hạn sử dụng</label>
            <input type="text" id="expired_date" readonly />

            <label>Số lượng tồn trong kho</label>
            <input type="text" id="quantity" readonly />

            <label>Hình ảnh</label>
            <img id="productImage" src="" alt="Hình ảnh sản phẩm" style="display:none; max-width:200px; margin:10px 0;" />

            <label for="storeCategorySelect">Chọn danh mục cửa hàng</label>
            <select id="storeCategorySelect" name="store_category_id" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="c" items="${listCategory}">
                    <option value="${c.storeCategoryId}">${c.categoryName}</option>
                </c:forEach>
            </select>


            <label>Giá bán</label>
            <input type="number" name="price_out" step="0.01" min="0" required />

            <label>Mô tả</label>
            <textarea id="description" readonly rows="3"></textarea>


            <button type="submit">Thêm vào cửa hàng</button>
        </form>
    </body>
</html>
