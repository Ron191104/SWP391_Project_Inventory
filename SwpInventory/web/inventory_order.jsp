<%-- 
    Document   : inventory_order
    Created on : Jul 12, 2025, 12:05:17 PM
    Author     : User
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
                        <i class="fas fa-box"></i> <span style="font-weight:600">Sản phẩm</span>
                    </label>
                    <div class="dropdown-menu">
                        <a href="product_list"><i class="fas fa-list"></i> Danh sách sản phẩm</a>

                        <a href=""><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                        <a href=""><i class="fas fa-list"></i> Danh sách phân loại</a>


                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/inventory_dashboard">
                    <i class="fas fa-warehouse"></i> Kho Hàng
                </a>
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
                <nav class="dropdown-menu" id="user-menu-dropdown">
                    <a href="myprofile.html">My Profile</a>
                    <a href="change_password.html">Change Password</a>
                    <a href="login.html">Log Out</a>
                </nav>
            </div>
        </div>
    </div>
    <link rel="stylesheet" href="assets/css/menu.css">
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
            table th:first-child,
            table td:first-child {
                width: 10px;
            }

            tbody tr:hover {
                background-color: #FDF9DA;
            }

            .container {
                max-width: 100%;
                padding: 10px 24px 24px 24px;
                background: white;
                margin-left: 10px;
                margin-top: 0px;
            }


            .btn-view {
                background-color: #128bfc;
                color: white;
                border: none;
                height: 23px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
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
            .container {
                max-width: 1200px;
                margin: 40px auto;
                background: #fff;
                padding: 24px;
                border-radius: 8px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
            }
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }


        </style>
</head>
<body>
    <div class="container">
    <h3>Danh sách đơn nhập hàng</h3>
    <c:if test="${empty stockInList}">
        <p>Không có đơn nhập nào.</p>
    </c:if>

    <c:if test="${not empty stockInList}">
        <table border="1" width="100%">
            <tr style="height: 35px">
                <th>Mã đơn</th>
                <th>Chi nhánh</th>
                <th>Thời gian</th>
                <th>Trạng thái</th>
                <th>Ghi chú</th>
                <th>Thao tác</th>
            </tr>

            <c:forEach items="${stockInList}" var="si">
                <tr>
                    <td>${si.id}</td>
                    <td>${storeNameMap[si.storeId]}</td>
                    <td><fmt:formatDate value="${si.importDate}" pattern="dd/MM/yyyy HH:mm:ss" /></td>                          
                    <td>
                        <c:choose>
                            <c:when test="${si.status == 0}">
                                <span class="status-processing">Chờ duyệt</span>
                            </c:when>
                            <c:when test="${si.status == 1}">
                                <span class="status-approved">Đã duyệt</span>
                            </c:when>
                            <c:when test="${si.status == 2}">
                                <span class="status-rejected">Từ chối</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>${si.note}</td>

                    <td>
                        <form action="inventory_order_detail" style="margin: 0;">
                            <input type="hidden" name="id" value="${si.id}">
                            <button type="submit" class="btn-view">Xem đơn</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </c:if>
    </div>
</body>
</html>
