<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Chi tiết sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f8ff; /* Nền xanh nhạt */
                margin: 0;
                padding: 0;
            }

            .container[role="main"] {
                max-width: 800px;
                margin: 40px auto;
                background: #ffffff;
                padding: 20px 30px;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }

            .back-button {
                background-color: #82CAFA;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                font-size: 14px;
                padding: 8px 14px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 10px;
                width: fit-content;
            }
            .back-button:hover {
                background-color: #787FF6;
                text-decoration: none;
                color: white;
            }

            .back-button i {
                margin-right: 6px;
            }


            h3 {
                font-size: 1.5rem;
                color: #82CAFA;
                text-align: center;
                margin-bottom: 20px;
            }

            form label {
                display: block;
                font-weight: bold;
                margin-bottom: 8px;
                color: #555;
            }

            form input,
            form select {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #82CAFA;
                border-radius: 8px;
                font-size: 1rem;
                box-sizing: border-box;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            form input:focus,
            form select:focus {
                border-color: #5bb5e6;
                box-shadow: 0 0 8px rgba(130, 202, 250, 0.8);
                outline: none;
            }

            .product-select {
                font-size: 1rem;
                padding: 12px;
            }

            .form-actions {
                display: flex;
                justify-content: flex-start;
                gap: 10px;
            }

            .form-actions input[type="submit"],
            .form-actions button {
                padding: 10px 20px;
                font-size: 1rem;
                border: none;
                border-radius: 8px;
                color: #ffffff;
                background-color: #82CAFA;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .form-actions input[type="submit"]:hover,
            .form-actions button:hover {
                background-color: #5bb5e6;
            }

            .form-actions button {
                background-color: #adb5bd;
            }

            .form-actions button:hover {
                background-color: #868e96;
            }
            input:not([readonly]),
            select {
                background-color: #eaf5ff;       /* nền xanh rất nhạt */
                border: 2px solid #82cafa;       /* viền màu chủ đạo */
                font-weight: 500;
                transition: 0.3s;
            }

            /* Khi người dùng focus vào */
            input:not([readonly]):focus,
            select:focus {
                outline: none;
                border-color: #429de2;           /* viền xanh đậm hơn khi focus */
                box-shadow: 0 0 5px rgba(66, 157, 226, 0.5);
            }
            .form-buttons {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 16px;
            }

            /* Nút Save */
            .form-buttons input[type="submit"] {
                width: 20%;
                background-color: #82cafa;
                color: white;
                border: none;
                padding: 12px 0;
                font-size: 1rem;
                border-radius: 6px;
                cursor: pointer;
                margin-bottom: 10px;
                transition: background-color 0.3s ease;
                text-align: center;
            }

            /* Nút Cancel */
            .form-buttons button {
                width: auto;
                background-color: #82cafa;
                color: white;
                border: none;
                padding: 6px 16px;
                font-size: 0.9rem;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            /* Hover effect */
            .form-buttons input[type="submit"]:hover,
            .form-buttons button:hover {
                background-color: #429de2;
            }


        </style>
    </head>
    <body>
    </head>
<body>
    <div class="header">
        <div class="header-left">
            <h1>Cửa hàng</h1>
            <div class="nav">
                <a href="store_dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <div class="dropdown">
                    <input type="checkbox" id="store-dropdown" />
                    <label for="store-dropdown" class="dropdown-label">
                        <i class="fas fa-box"></i> <span style="font-weight:600">Sản phẩm</span>
                    </label>
                    <div class="dropdown-menu">
                        <a href="store_product_list"><i class="fas fa-bars"></i>Danh sách sản phẩm</a>
                        <a href="store_inventory"><i class="fas fa-bars"></i> Danh sách hàng tồn</a>
                        <a href="store_set_price"><i class="fas fa-cog"></i> Đặt giá sản phẩm</a>
                    </div>
                </div>

                <div class="dropdown">
                    <input type="checkbox" id="stock-dropdown" />
                    <label for="stock-dropdown" class="dropdown-label">
                        <i class="fas fa-truck-loading"></i> <span style="font-weight:600">Nhập hàng</span>
                    </label>
                    <div class="dropdown-menu">
                        <a href="store_stock_in"><i class="fas fa-plus-circle"></i>Tạo đơn</a>
                        <a href="store_stock_in_list"><i class="fas fa-bars"></i> Danh sách đơn</a>
                    </div>
                </div>                   
                <a href="sales"><i class="fas fa-shopping-cart"></i> Bán hàng</a>
                <a href="customer_list"><i class="fas fa-users"></i> Khách hàng</a>
                <c:if test="${not empty sessionScope.storeId}">
                    <c:forEach var="store" items="${listStore}">
                        <c:if test="${store.storeId == sessionScope.storeId}">
                            <a href="choose_store"><i class="fas fa-store"></i>${store.storeName}</a>
                            </c:if>
                        </c:forEach>
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
                    <span style="padding:12px 16px; color:#4CAF50; font-weight:bold;">
                        <%= session.getAttribute("userName") %>
                    </span>
                    <a href="<%= request.getContextPath() %>/myprofile">Profile</a>
                    <a href="<%= request.getContextPath() %>/changepassworduser">Change Password</a>
                    <a href="<%= request.getContextPath() %>/logout">Logout</a>
                </nav>
            </div>
        </div>
    </div>
    <div class="container" role="main" aria-label="Thông tin chi tiết sản phẩm">
        <a href="store_product_list" class="back-button">            
            <i class="fas fa-arrow-left "></i>
            Quay lại
        </a>

        <h3>Sửa sản phẩm:</h3>

        <div class="container">
            <form action="edit_product" method="post" enctype="multipart/form-data">
                <label>ID</label>
                <input type="text" name="productId" value="${detail.product.id}" readonly>

                <label>Barcode</label>
                <input type="text" name="barcode" value="${detail.product.barcode}" readonly>

                <label>Product Name</label>
                <input type="text" name="name" value="${detail.product.name}" required>
                <c:if test="${not empty error}">
                    <div style="color: red; font-size: 0.9em;">${error}</div>
                </c:if>
                    <br>

                <label>Category</label>
                <select name="storeCategoryId" required>
                    <c:forEach var="c" items="${listStoreCategory}">
                        <option value="${c.id}" <c:if test="${c.id == detail.storeCategoryId}">selected</c:if>>${c.name}</option>
                    </c:forEach>
                </select>

                <label>Price In</label>
                <input type="number" name="priceIn" value="${detail.product.price}" readonly>

                <label>Price Out</label>
                <input type="number" name="priceOut" value="${detail.priceOut}" readonly>

                <label>Quantity</label>
                <input type="number" name="quantity" value="${detail.quantity}" readonly>

                <label>Unit</label>
                <input type="text" name="unit" value="${detail.product.unit}" readonly>

                <label>Manufactured Date</label>
                <input type="text" name="manufacture_date" value="${detail.product.manufacture_date}" readonly>

                <label>Expired Date</label>
                <input type="text" name="expired_date" value="${detail.product.expired_date}" readonly>

                <label>Description</label>
                <input type="text" name="description" value="${detail.product.description}" required>

                <label>Upload New Image</label>
                <input type="file" name="image" accept="image/*">

                <input type="hidden" name="oldImage" value="${detail.product.image}">
                <input type="hidden" name="storeProductId" value="${detail.storeProductId}">

                <div class="form-buttons">
                    <input type="submit" value="Save">
                    <button type="button" onclick="window.location.href = 'store_product_list'">Cancel</button>
                </div>
            </form>

        </div>

    </div>
</body>
</html>
