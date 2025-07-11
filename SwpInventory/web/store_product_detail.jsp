
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Chi tiết sản phẩm</title>
        <style>
            .container {
                max-width: 960px;
                margin: 30px auto;
                background: #fff;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
                border-radius: 10px;
                padding: 24px 32px;
            }
            .product-detail {
                display: flex;
                gap: 40px;
                padding-top: 20px;
            }

            h1.product-name {
                font-size: 2rem;
                font-weight: 700;
                color: #1470e2;
                padding-left: 100px;
            }
            .product-image {
                max-width: 320px;
                padding-left: 30px;
                padding-top: 0px;
            }
            .product-image img {
                width: 100%;
                height: auto;
            }
            .product-info {
                display: flex;
                flex-direction: column;
                gap: 12px;
                padding-left: 80px;
            }
            .info-row {
                display: flex;
                justify-content: space-between;
                padding-bottom: 6px;
                border-bottom: 1px solid #e1eaea;
            }
            .info-label {
                font-weight: 600;
                color: #89D0F0;
                min-width: 150px;
            }

            .info-value {
                font-weight: 400;
                max-width: 400px;
                word-wrap: break-word;
                padding: 6px 10px;
                border: 1px solid #89D0F0;
                border-radius: 6px;
                background-color: white;
                color: #333;
                width: 280px;
                height: 20px;
            }

            .info-value.description {
                width: auto;
                height: auto;
                max-width: 100%;
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
                        <input type="checkbox" id="store-dropdown" />
                        <label for="store-dropdown" class="dropdown-label">
                            <i class="fas fa-box"></i> <span style="font-weight:600">Sản phẩm</span>
                        </label>
                        <div class="dropdown-menu">
                            <a href="store_product_list"><i class="fas fa-bars"></i>Danh sách sản phẩm</a>
                            <a href="store_inventory"><i class="fas fa-bars"></i> Danh sách hàng tồn</a>
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
                    </div>                     <a href="stats.html"><i class="fas fa-shopping-cart"></i> Bán hàng</a>

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

        <div class="container" role="main" aria-label="Thông tin chi tiết sản phẩm">

            <h1 class="title" style="text-align: center;">Chi tiết sản phẩm</h1>

            <h1 class="product-name" tabindex="0">${detail.product.name}</h1>
            <div class="product-detail">
                <div class="product-image" role="img" aria-label="Ảnh sản phẩm">
                    <img src="assets/image/${detail.product.image}" alt="Ảnh sản phẩm" />
                </div>
                <div class="product-info">
                    <div class="info-row">
                        <div class="info-label">ID:</div>
                        <div class="info-value">${detail.product.id}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Barcode:</div>
                        <div class="info-value">${detail.product.barcode}</div>
                    </div>
                    <c:forEach items="${listStoreCategory}" var="c">
                        <c:if test="${c.id == detail.product.category_id}">
                            <div class="info-row">
                                <div class="info-label">Category :</div> 
                                <div class="info-value">${c.name}</div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <div class="info-row">
                        <div class="info-label">Price In:</div>
                        <div class="info-value"><fmt:formatNumber value="${detail.product.price}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>

                    </div>
                    <div class="info-row">
                        <div class="info-label">Price Out:</div>
                        <div class="info-value"><fmt:formatNumber value="${detail.priceOut}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>

                    </div>
                    <div class="info-row">
                        <div class="info-label">Unit:</div>
                        <div class="info-value">${detail.product.unit}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Manufacture Date:</div>
                        <div class="info-value">${detail.product.manufacture_date}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Expired Date:</div>
                        <div class="info-value">${detail.product.expired_date}</div>
                    </div>
                    <div class="info-row" style="flex-direction: column; border-bottom: none;">
                        <div class="info-label" style="margin-bottom: 6px;">Description:</div>
                        <div class="info-value description">
                            ${detail.product.description}
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </body>
</html>

