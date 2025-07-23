<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>

            .product-list table tr {
                height: 160px;
            }
            .container {
                padding: 7px 20px;
                background: white;
            }
            .flex-wrapper {
                display: flex;
                gap: 24px;
                margin-top: 24px;
            }
            .product-list {
                width: 70%;
            }
            .cart-container {
                width: 40%;
                background: white;
                padding: 16px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .product-td {
                width: 110px;
                padding: 10px;
                text-align: center;
                border: none;
            }
            .product {
                display: flex;
                flex-direction: column;
                gap: 4px;
                align-items: center;
                font-size: 11px;
            }

            .product img {
                width: 65px;
                height: 65px;
                border-radius: 4px;
            }
            .product p {
                font-size: 10px;
                margin: 0;
            }

            .product div {
                font-size: 10px;

            }

            .product button {
                background-color: #82CAFA;
                border: none;
                width: 30px;
                height: 20px;
                border-radius: 4px;
                color: white;
                font-size: 9px;
                cursor: pointer;
                padding: 0;
            }
            .product button:hover {
                background-color: #787FF6;
            }

            .custom-input,
            .product-select{
                height: 28px;
                width: 150px;
                border: 2px solid #82CAFA;
                border-radius: 8px;
                font-size: 11px;
                padding-left: 8px;
                outline: none;
            }

            .search-button {
                cursor: pointer;
                outline: none;
                border: none;
                background-color: white;
            }

            .search-icon {
                color: #82CAFA;
            }

            .cart-container table {
                width: 100%;
                border-collapse: collapse;
            }

            .cart-container table th,
            .cart-container table td {
                text-align: center;
                vertical-align: middle;
                padding: 8px 4px;
                font-size: 12px;
            }

            .quantity-control button {
                background: none;
                border: none;
                color: black;
                font-weight: bold;
                cursor: pointer;
                font-size: 14px;
            }

            .checkout-btn {
                background-color: #82CAFA;
                border: none;
                width: 100%;
                height: 35px;
                border-radius: 6px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                font-size: 14px;
                margin-top: 20px;
            }

            .checkout-btn:hover {
                background-color: #787FF6;
            }

            .pagination {
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                padding: 10px;
                gap: 9px;
                display: flex;
                justify-content: center;
            }

            .pagination-link{
                display: inline-flex;
                justify-content: center;
                align-items: center;
                width: 25px;
                height: 25px;
                background-color: #eee;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 500;
            }


            .pagination-link.active {
                background-color: #82CAFA;
                color: white;
                font-weight: bold;
            }

            .cart-container tbody td {
                font-size: 12px;
            }
            .custom-input-cart{
                height: 20px;
                border: 1px solid #82CAFA;
                border-radius: 5px;
                outline: none;
                margin-bottom: 10px;
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

            <div class="flex-wrapper">
                <div class="product-list">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 16px;">

                        <form action="sales" method="get">
                            <select id="product-type" name="categoryId" class="product-select" onchange="this.form.submit()">
                                <option value="" <c:if test="${empty tag || tag == -1}">selected</c:if>>Tất cả sản phẩm</option>
                                <c:forEach items="${listStoreCategory}" var="c">
                                    <option value="${c.id}" <c:if test="${c.id == tag}">selected</c:if>>${c.name}</option>
                                </c:forEach>
                            </select>
                        </form>

                        <form action="sales" method="get" style="padding-left: 50%">
                            <input name="barcode" type="text" class="custom-input" placeholder="Search..." />
                            <button type="submit" class="search-button">
                                <i class="fas fa-search search-icon"></i>
                            </button>
                        </form>


                    </div>


                    <table>
                        <c:choose>
                            <c:when test="${empty storeProduct}">
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 20px; font-weight: bold; font-size: 14px; color: #888;">
                                        Chưa có sản phẩm nào.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${storeProduct}" var="o" varStatus="status">
                                    <c:if test="${status.index % 6 == 0}">
                                        <tr>
                                        </c:if>
                                        <td class="product-td" style="border: none; text-align: center;">
                                            <form action="sales" method="post" class="product">
                                                <div><img src="assets/image/${o.product.image}"></div>
                                                <div style="font-weight: 600;">${o.product.name}</div>
                                                <div style="color: red">${o.product.barcode}</div>
                                                <div><p></p><fmt:formatNumber value="${o.priceOut_unit}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                                                <input type="hidden" name="productId" value="${o.product.id}">
                                                <input type="hidden" name="price" value="${o.priceOut_unit}">
                                                <input type="hidden" name="customerName" value="${customerName}" />
                                                <input type="hidden" name="phone" value="${phone}" />

                                                <button type="submit">Add</button>
                                            </form>
                                        </td>
                                        <c:if test="${status.index % 6 == 5 || status.last}">
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </table>
                    <c:if test="${paginationEnabled}">
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="sales?page=${i}&categoryId=${tag}" class="
                                   pagination-link ${i == currentPage ? 'active' : ''}">
                                    ${i}
                                </a>

                            </c:forEach>
                        </div>
                    </c:if>
                </div>

                <div class="cart-container">
                    <form action="processCheckout" method="post">
                        <div style="display: flex; gap: 5px;">

                            <div>
                                <label for="customerName" style="font-size: 10px; font-weight: bold;">Tên khách hàng:</label>
                                <input type="text" id="customerName" name="customerName" class="custom-input-cart" />
                            </div>
                            <div>
                                <label for="phone" style="font-size: 10px; font-weight: bold;">Số điện thoại:</label>
                                <input type="text" id="phone" name="phone" class="custom-input-cart" />
                            </div>                         

                            <input type="hidden" name="customerId" value="${customerId}">

                        </div>
                        <table style="width: 100%;">
                            <thead>
                                <tr>
                                    <th style="width: 5%;">STT</th>
                                    <th style="width: 25%;">Tên sản phẩm</th>
                                    <th style="width: 15%;">Số lượng</th>
                                    <th style="width: 15%;">Đơn giá</th>
                                    <th style="width: 30%;">Thành tiền</th>
                                    <th></th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:set var="index" value="0"/>
                                <c:set var="total" value="0"/>

                                <c:forEach var="od" items="${cart}">
                                    <c:set var="index" value="${index + 1}" />
                                    <tr>
                                        <td>${index}</td>
                                        <td>
                                            <c:forEach items="${sessionScope.storeProductAllPage}" var="sp">
                                                <c:if test="${sp.product.id == od.productId}">
                                                    ${sp.product.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <div class="quantity-control">
                                                <form action="sales" method="post" style="display: inline;">
                                                    <input type="hidden" name="productId" value="${od.productId}">
                                                    <input type="hidden" name="action" value="decrease">


                                                    <button type="submit">-</button>
                                                </form>
                                                <span>${od.quantity}</span>
                                                <form action="sales" method="post" style="display: inline;">
                                                    <input type="hidden" name="productId" value="${od.productId}">
                                                    <input type="hidden" name="action" value="increase">


                                                    <button type="submit">+</button>
                                                </form>
                                            </div>
                                        </td>
                                        <td><fmt:formatNumber value="${od.price}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                                        <td>
                                            <c:set var="subtotal" value="${od.price * od.quantity}" />
                                            <fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>                                        <c:set var="total" value="${total + subtotal}" />
                                        </td>
                                        <td>
                                            <form action="sales" method="post" style="display:inline;">
                                                <input type="hidden" name="productId" value="${od.productId}" />
                                                <input type="hidden" name="action" value="remove" />
                                                <button type="submit" style="color:red; background: none; border: none; font-size: 10px">Xóa</button>
                                            </form>
                                        </td>

                                    </tr>
                                </c:forEach>

                                <tr><td colspan="6" style="height: 20px;"></td></tr>

                                <tr>
                                    <td colspan="4" style="text-align: left; font-weight: bold;">Thành tiền:</td>
                                    <td colspan="2" style="font-weight: bold;"><fmt:formatNumber value="${total}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="text-align: left; font-weight: bold;">Tổng tiền:</td>
                                    <td colspan="2" style="font-weight: bold;">
                                        <fmt:formatNumber value="${total - pointBalance}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="text-align: left; font-weight: bold;">
                                        Dùng điểm:
                                        <label>
                                            <input type="checkbox" name="usePoints" value="true"  />
                                        </label>
                                    </td>

                                </tr>

                            </tbody>
                        </table>
                        <button class="checkout-btn" type="submit">Thanh toán</button>


                    </form>
                </div>
            </div>

        </div>



    </body>
</html>
