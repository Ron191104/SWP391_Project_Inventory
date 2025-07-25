
<%@ page import="java.util.*, model.StoreOrderDetails" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    List<StoreOrderDetails> cart = (List<StoreOrderDetails>) session.getAttribute("cart");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
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

            .container {
                max-width: 100%;
                padding: 10px 24px 24px 24px;
                background: white;
                margin-left: 10px;
                margin-top: 0px;
            }

            table tr th:first-child {
                width: 35px;
            }
            
            table tr th:nth-child(2) {
                width: 35px;
            }


            input[type="number"],
            input[type="text"]{
                width: 250px;
                padding: 8px 12px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 6px;
                outline: none;
            }


            select {
                width: 270px;
                padding: 8px 12px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 6px;
                outline: none;
            }

            button {
                background-color: #82CAFA;
                border: none;
                width: 70px;
                height: 30px;
                border-radius: 6px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                margin-top: 10px;
            }

            button:hover {
                background-color: #787FF6;
            }

        </style>
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


        <div class="container">



            <div style="width: 100%;">
                <h2>Nhập hàng từ kho</h2>
                <div style="width: 30%; display: inline-block; vertical-align: top; padding-left: 60px;">
                    <h3>Chọn sản phẩm</h3>
                    <form action="store_stock_in" method="post">
                        <label>Sản phẩm:</label><br>
                        <select name="productId" required>
                            <c:forEach items="${listP}" var="p">
                                <option value="${p.id}">${p.name}</option>
                            </c:forEach>
                        </select><br><br>

                        <label>Số lượng:</label><br>
                        <input type="number" name="quantity" min="1" value="1" required><br><br>

                        <button type="submit">Add</button>
                    </form>
                </div>

                <div style="width: 60%; display: inline-block; vertical-align: top; margin-left: 2%;">
                    <h3>Giỏ hàng:</h3>
                    <table border="1" width="100%">
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Barcode</th>
                            <th>Số lượng</th>
                            <th>Đơn vị</th>
                            <th>Giá</th>
                            <th>Thành tiền</th>
                            <th>Action</th>
                        </tr>
                        <c:set var="total" value="0" />

                        <c:choose>
                            <c:when test="${not empty cart}">
                                <c:forEach var="od" items="${cart}">
                                    <tr>
                                        <td>
                                            <c:forEach items="${listP}" var="p">
                                                <c:if test="${p.id == od.productId}">
                                                    ${p.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                            <td>${od.barcode}</td>
                                        <td>${od.quantity}</td>
                                        <td>${od.unit}</td>
                                        <td><fmt:formatNumber value="${od.price}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>

                                        <td>
                                            <c:set var="subtotal" value="${od.quantity * od.price}" />
                                            <fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            <c:set var="total" value="${total + subtotal}" />
                                        </td>
                                        <td>
                                            <form action="remove_cart_item" method="post" style="display:inline;">
                                                <input type="hidden" name="productId" value="${od.productId}" />
                                                <button type="submit">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align:center;">Giỏ hàng trống</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>

                        <tr>
                            <td colspan="6"><b>Tổng:</b></td>
                            <td><b><fmt:formatNumber value="${total}" type="currency" currencySymbol="₫" groupingUsed="true"/></b></td>


                        </tr>
                    </table>

                    <br>
                    <form action="store_stock_in_confirm" method="post">
                        <label>Ghi chú:</label>
                        <input type="text" name="note">
                        <button type="submit">Đặt hàng</button>
                    </form>
                </div>


            </div>
        </div>
    </body>
</html>
