<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            tbody tr:hover {
                background-color: #FDF9DA;
            }

            .action-column {
                width: 120px;
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

                height: 13px;
                width: 130px;
                padding: 10px 15px;
                border: 2px solid #82CAFA;
                border-radius: 9px;
                font-size: 11px;
                outline: none;
            }

            .fas.fa-search.search-icon{
                border: none;
                outline: none;
                color: #89D0F0;
                background-color: white;
            }



            table td:nth-child(10),
            table th:nth-child(10) {
                width: 25px;
            }
            .form-control1 {
                height: 13px;
                width: 55px;
                padding: 10px 15px;
                border: 2px solid #82CAFA;
                border-radius: 9px;
                font-size: 11px;
                outline: none;
            }
            .formPrice{
                padding-right:42%;
            }
            .filterType{
                height: 20px;
                border: none;
                outline: none;
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
            <h3>Quản lí sản phẩm:</h3>

            <div class="product-select-container" style="display: flex; align-items: center; justify-content: space-between;">
                <form action="store_product_list">
                    <select id="product-type" name="id" class="product-select" onchange="this.form.submit()">
                        <option value="" ${empty tag ? "selected" : ""}>Tất cả sản phẩm</option>
                        <c:forEach items="${listStoreCategory}" var="c">
                            <option value="${c.id}" ${c.id  == tag ? "selected" : ""}>${c.name}</option>
                        </c:forEach>
                    </select>

                </form>
                <div class="formPrice">
                    <form action="FilterByPriceController" method="get">
                        <select class="filterType" name="filterType">
                            <option value="in">Giá nhập</option>
                            <option value="out">Giá bán</option>
                        </select>
                        <input type="number" name="minPrice" placeholder="Giá từ" class="form-control1" >
                        <span style="font-size: 12px">đến</span>
                        <input type="number" name="maxPrice" placeholder="Giá đến" class="form-control1" >

                        <button type="submit" style="display: none">Lọc</button>
                    </form>
                </div>

                <form action="search">
                    <div class="form-group">
                        <input name="txt" type="text" class="form-control" placeholder="Search...">

                        <button type="submit" class="fas fa-search search-icon"></button>
                    </div>
                </form>
            </div>


            <table>
                <thead>
                    <tr>
                        <th style="width: 5px">ID</th>
                        <th>Image</th>
                        <th style="width: 40px">Name</th>
                        <th style="width: 30px">Barcode</th>
                        <th style="width: 10px">Unit</th>
                        <th>Import price</th>
                        <th>Sale price</th>
                        <th>MFD</th>
                        <th>EXP</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach items="${storeProduct}" var="o">
                        <tr>
                            <td>${o.storeProductId}</td>
                            <td>
                                <a href="store_product_detail?did=${o.storeProductId}" title="Xem chi tiết">
                                    <img src="assets/image/${o.product.image}" width="50" height="50" alt="Product Image" style="border-radius: 4px;"/>
                                </a>       
                            </td>
                            <td>${o.product.name}</td>
                            <td>${o.product.barcode}</td>
                            <td>${o.product.unit}</td>
                            <td><fmt:formatNumber value="${o.product.price}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                            <td><fmt:formatNumber value="${o.priceOut}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                            <td>${o.product.manufacture_date}</td>
                            <td>${o.product.expired_date}</td>

                            <td>
                                <div style="display: flex; gap: 4px;">
                                    <a href="store_product_detail?did=${o.storeProductId}"
                                       style="background: #787FF6; color: white; padding: 3px 5px; border-radius: 3px; font-size: 10px; display: inline-block; margin-right:  3px; margin-left: 4px">
                                        Detail
                                    </a>

                                    <form action="edit_product" method="get" style="margin: 0;">
                                        <input type="hidden" name="id" value="${o.storeProductId}" />
                                        <input type="submit" value="Edit"
                                               style="background: #787FF6; color: white; padding: 5px 6px; border-radius: 3px; font-size: 10px; border: none; cursor: pointer;margin-right:  3px;" />
                                    </form>

                                    <a href="delete?id=${o.storeProductId}"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm có ID=${o.storeProductId} không?')"
                                       style="background: #787FF6; color: white; padding: 3px 5px; border-radius: 3px; font-size: 10px; display: inline-block;">
                                        Delete
                                    </a>
                                </div>
                            </td>


                        </tr>
                    </c:forEach>

                </tbody>
            </table>

            <div style="margin-top: 20px; text-align: center;">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="store_product_list?page=${i}"
                       style="display: inline-block; width: 20px; padding: 6px ; margin: 7px;background-color: ${i == currentPage ? '#82CAFA' : '#eee'};
                       color: ${i == currentPage ? 'white' : '#333'}; text-decoration: none; border-radius: 4px;">
                        ${i}
                    </a>
                </c:forEach>
            </div>

        </div>
    </body>
</html>
