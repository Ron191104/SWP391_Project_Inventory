<%-- 
    Document   : store_stock_in_receive
    Created on : Jul 22, 2025, 11:05:43 PM
    Author     : ADMIN
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">
        <title>JSP Page</title>
        <title>Nhập hàng vào kho cửa hàng</title>
        <style>
            .container {
                max-width: 100%;
                padding: 10px 24px 24px 24px;
                background: white;
                margin-left: 10px;
                margin-top: 0px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #82CAFA;
                color: white;
            }
            input[type="number"] {
                width: 80px;
                padding: 4px;
                text-align: center;
            }
            button {
                margin-top: 15px;
                padding: 8px 16px;
                background-color: #82CAFA;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
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
        <div class="container">
            <h2>Xác nhận nhập hàng vào cửa hàng</h2>
            <form action="store_stock_in_receive" method="post">
                <input type="hidden" name="storeStockInId" value="${storeStockIn.id}">

                <table>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Đơn vị</th>
                        <th>Số lượng đặt</th>
                        <th>Số lượng nhập thực tế</th>
                    </tr>
                    <c:forEach items="${details}" var="item">
                        <tr>
                            <td>${item.productName}</td>
                            <td>${item.unitName}</td>
                            <td>${item.quantity}</td>
                            <td>
                                <input type="number" name="actualQuantity" min="0" value="${item.quantity}" placeholder="${item.quantity}">
                                <input type="hidden" name="productId" value="${item.productId}">
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <button type="submit">Xác nhận</button>
            </form> 
        </div>
    </body>
</html>
