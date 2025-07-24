<%-- 
    Document   : inventory_order_detail
    Created on : Jul 12, 2025, 1:39:25 PM
    Author     : User
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

        .links {
            display: flex;
            justify-content: space-between;
            margin-left: 20px;
            color: #1976D2;
            text-decoration: underline;
            font-size: 0.98rem;
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
        table th:first-child,
        table td:first-child {
            width: 15px;
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
            text-align: center
        }


        .btn-view {
            background-color: #82CAFA;
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
            max-width: 800px;
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
        .btn-approve {
            background: #28a745;
        }
        .btn-approve:hover {
            background: #218838;
        }
        .btn-reject {
            background: #dc3545;
        }
        .btn-reject:hover {
            background: #c82333;
        }
        .btn-approve, .btn-reject {
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-right: 8px;
            font-size: 1rem;
        }


    </style>
</head>
<body>
    <div class="container">
        <a href="inventory_order" class="links" >Quay lại</a>
        <h2>Chi tiết đơn hàng #${stockIn.id}</h2>

        <p><b>Ngày tạo:</b> <fmt:formatDate value="${stockIn.importDate}" pattern="dd-MM-yyyy HH:mm:ss"/></p>
        <p><b>Ghi chú:</b> ${stockIn.note}</p>
        <p><b>Trạng thái:</b>
            <c:choose>
                <c:when test="${stockIn.status == 0}">
                    <span class="status-processing">Chờ duyệt</span>
                </c:when>
                <c:when test="${stockIn.status == 1}">
                    <span class="status-approved">Đã duyệt</span>
                </c:when>
                <c:when test="${stockIn.status == 2}">
                    <span class="status-rejected">Đã từ chối</span>
                </c:when>
            </c:choose>
        </p>
        <table>
            <tr>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn vị</th>               
                <th>Giá nhập</th>
                <th>Thành tiền</th>
            </tr>

            <c:set var="totalAmount" value="0" />
            <c:forEach items="${details}" var="d">
                <tr>
                    <td>${d.productId}</td>
                    <td>${d.productName}</td>
                    <td>${d.quantity}</td>
                    <td>${d.unitName}</td>
                    <td>${d.priceIn}</td>
                    <td><fmt:formatNumber value="${d.quantity * d.priceIn}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                </tr>
                <c:set var="totalAmount" value="${totalAmount + (d.quantity * d.priceIn)}"/>
            </c:forEach>

            <tr>
                <td colspan="5" style="text-align: right;"><strong>Tổng cộng:</strong></td>
                <td><strong><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/></strong></td>


            </tr>
        </table>
        <div style="margin-top: 24px;">
            <c:if test="${stockIn.status == 0}">
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${stockIn.id}" />
                    <button type="submit" name="action" value="approve"
                            class="btn-approve"
                            onclick="return confirm('Bạn chắc chắn muốn duyệt đơn hàng này?');">
                        ✔ Duyệt đơn
                    </button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${stockIn.id}" />
                    <button type="submit" name="action" value="reject"
                            class="btn-reject"
                            onclick="return confirm('Bạn chắc chắn muốn từ chối đơn hàng này?');">
                        ✖ Từ chối đơn
                    </button>
                </form>
            </c:if>
            <c:if test="${stockIn.status == 1}">
                <div style="margin-top:18px;color:green;font-weight:bold;">Đơn hàng đã được duyệt.</div>
            </c:if>

            <c:if test="${stockIn.status == 2}">
                <div style="margin-top:18px;color:#dc3545;font-weight:bold;">Đơn hàng đã bị từ chối.</div>
            </c:if>
        </div>
    </div>
</body>
</html>
