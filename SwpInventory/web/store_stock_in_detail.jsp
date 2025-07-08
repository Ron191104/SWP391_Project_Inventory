<%-- 
    Document   : store_stock_in_detail
    Created on : Jul 6, 2025, 4:15:23 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/menu.css">

        <title>JSP Page</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            h2 {
                margin-top: 0px;
            }
            p {
                font-size: 16px;
            }
            h3{
                padding-left: 26px;
            }
            .info{
                font-size: 12px;
                padding-left: 30px;
                padding-top:   0px;
            }
            .container {
                padding: 24px;
                background: white;
                margin: 30px auto;
                width: 800px;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
                border-radius: 8px;
                height: 680px;
            }

            .status-processing {
                font-weight: bold;
            }

            .status-approved {
                font-weight: bold;
                color: green;
            }

            .status-rejected {
                font-weight: bold;
                color: red;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 7px;
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
                    <a href="store_product_list"><i class="fas fa-box"></i>Sản phẩm</a>

                    <div class="dropdown">
                        <input type="checkbox" id="store-dropdown" />
                        <label for="store-dropdown" class="dropdown-label">
                            <i class="fas fa-truck-loading"></i> <span style="font-weight:600">Nhập hàng</span>
                        </label>
                        <div class="dropdown-menu">
                            <a href="store_stock_in"><i class="fas fa-plus-circle"></i>Tạo đơn</a>
                            <a href="store_stock_in_list"><i class="fas fa-file-alt"></i> Danh sách đơn</a>
                        </div>
                    </div>                    <a href="stats.html"><i class="fas fa-shopping-cart"></i> Bán hàng</a>

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
                    <nav class="dropdown-menu" id="user-menu-dropdown" role="menu" aria-hidden="true">
                        <a href="myprofile.html" role="menuitem" tabindex="0">My Profile</a>
                        <a href="change_password.html" role="menuitem" tabindex="0">Change Password</a>
                        <a href="login.html" role="menuitem" tabindex="0">Log Out</a>
                    </nav>
                </div>
            </div>
        </div>


        <div class="container">
            <c:forEach var="store" items="${listStore}">
                <c:if test="${store.storeId == stockIn.storeId}">
                    <h3>Chi nhánh ${store.storeName}</h3>
                    <div class="info">

                        <div>Địa chỉ: ${store.address}</div>
                        <div>Số điện thoại: ${store.phone}</div>
                        <div>Email: ${store.email}</div>
                    </div>

                </c:if>
            </c:forEach>

            <h2 style="text-align: center;">Đơn nhập hàng</h2>


            <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                <div>
                    <p><b>Ngày tạo:</b> <fmt:formatDate value="${stockIn.importDate}" pattern="dd-MM-yyyy"/></p>
                    <p><b>Thời gian:</b> <fmt:formatDate value="${stockIn.importDate}" pattern="HH:mm:ss"/></p>

                </div>

                <div>
                    <p><b>Mã đơn: </b> ${stockIn.id}</p>
                    <p><b>Trạng thái:</b>
                        <c:choose>
                            <c:when test="${stockIn.status == 0}">
                                <span class="status-processing">Đang xử lý</span>
                            </c:when>
                            <c:when test="${stockIn.status == 1}">
                                <span class="status-approved">Đã duyệt</span>
                            </c:when>
                            <c:when test="${stockIn.status == 2}">
                                <span class="status-rejected">Từ chối</span>
                            </c:when>
                        </c:choose>
                    </p>
                </div>
            </div>


            <table>
                <tr>
                    <th>Product ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá nhập</th>
                    <th>Thành tiền</th>
                </tr>

                <c:set var="totalAmount" value="0" />
                <c:forEach items="${details}" var="d">
                    <tr>
                        <td>${d.productId}</td>
                        <td>${d.productName}</td>
                        <td>${d.quantity}</td>
                        <td><fmt:formatNumber value="${d.priceIn}" type="currency"/></td>
                        <td>
                            <fmt:formatNumber value="${d.quantity * d.priceIn}" type="currency"/>
                        </td>
                    </tr>
                    <c:set var="totalAmount" value="${totalAmount + (d.quantity * d.priceIn)}"/>
                </c:forEach>

                <tr>
                    <td colspan="4" style=" font-weight:bold">Tổng cộng:</td>
                    <td style=" font-weight:bold"><fmt:formatNumber value="${totalAmount}" type="currency"/></td>
                </tr>
                <tr>
                    <td colspan="5" style="text-align: left; font-style: italic; font-weight: 650">
                        Số tiền bằng chữ: ${amountInWords} đồng
                    </td>
                </tr>

            </table>
            <p><b>Ghi chú:</b> ${stockIn.note}</p>

            <div style="text-align: right; padding-right: 60px; padding-top: 35px">
                Người lập phiếu:<br>
                <span style="padding-right: 10px">
                    (Ký rõ họ tên)
                </span>
            </div>

        </div>
    </body>
</html>
