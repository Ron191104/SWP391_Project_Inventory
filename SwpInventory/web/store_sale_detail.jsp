<%-- 
    Document   : store_sale_detail
    Created on : Jul 19, 2025, 11:04:20 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <title>Chi tiết hóa đơn</title>
        <link rel="stylesheet" href="assets/css/menu.css">
        <style>

            .invoice {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 8px #ccc;
                max-width: 440px;
                margin: 20px auto;
                font-size: 11px;
            }

            .invoice h3 {
                font-size: 15px;
            }

            table {
                width: 100%;
                font-size: 12px;
            }

            th, td {
                padding: 4px;
                text-align: center;
                font-size: 11px;
            }

            table th:first-child,
            table td:first-child {
                width: 22px;
            }

            .total-row td {
                font-weight: bold;
                font-size: 13px;
            }


            .button-group {
                display: flex;
                justify-content: center;
                margin-top: 15px;
            }

            .button-link {
                display: inline-block;
                background-color: #82CAFA;
                color: white;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: bold;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .button-link:hover {
                background-color: #787FF6;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-left">
                <h1>Tên kho</h1>
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


        <div class="invoice">

            <div style="text-align: center;">
                <c:forEach var="store" items="${listStore}">
                    <c:if test="${store.storeId == sale.storeId}">
                        <h3>Chi nhánh ${store.storeName}</h3>
                        <div style="font-size: 12px; margin-bottom: 10px;">
                            <div>Địa chỉ: ${store.address}</div>
                            <div>Điện thoại: ${store.phone}</div>
                            <div>Email: ${store.email}</div>
                        </div>
                    </c:if>
                </c:forEach>

                <h2 style="margin-top: 15px;">HÓA ĐƠN THANH TOÁN</h2>
                <p><strong>Mã hóa đơn:</strong> ${sale.saleId}</p>

                <p>
                    Ngày lập hóa đơn:
                    <fmt:formatDate value="${sale.saleDate}" pattern="dd-MM-yyyy"/>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    Giờ:
                    <fmt:formatDate value="${sale.saleDate}" pattern="HH:mm:ss"/>
                </p>
            </div>

            <p><strong>Khách hàng:</strong> ${customer.name}</p>
            <p><strong>Số điện thoại:</strong> ${customer.phone}</p>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên sản phẩm</th>
                        <th>Đơn vị</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${saleDetails}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${item.productName}</td>
                            <td>${item.unit}</td>
                            <td><fmt:formatNumber value="${item.priceOut}" type="currency" currencySymbol="₫"/></td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.priceOut * item.quantity}" type="currency" currencySymbol="₫"/></td>
                        </tr>
                    </c:forEach>
                    <tr class="total-row">
                        <td colspan="5">Tổng cộng:</td>
                        <td><fmt:formatNumber value="${sale.totalAmount}" type="currency" currencySymbol="₫"/></td>
                    </tr>

                </tbody>
            </table>

            <div class="center" style="margin-top: 20px;text-align: center;">
                Xin cảm ơn quý khách!
            </div>
        </div>
        <div class="button-group">
            <a href="store_invoice_list" class="button-link">Danh sách hóa đơn</a>
        </div>

    </body>
</html>
