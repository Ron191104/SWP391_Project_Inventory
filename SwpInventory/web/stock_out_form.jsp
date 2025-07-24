<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Phiếu xuất kho</title>
    </head>
    <body>

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
            .btn-approve {
                background: #82CAFA;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                margin-right: 8px;
                font-size: 1rem;
                transition: background-color 0.3s ease;
            }
            .btn-approve:hover {
                background: #787FF6;
            }
            .links {
                display: flex;
                justify-content: space-between;
                margin-left: 20px;
                color: #1976D2;
                text-decoration: underline;
                font-size: 0.98rem;
            }
            table th:first-child,
            table td:first-child {
                width: 10px;
            }
        </style>
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
        <div class="container">
            <a href="stock_out_list" class="links" >Quay lại</a>

            <h2 style="text-align: center;">Phiếu xuất kho</h2>


            <div style="display: flex; flex-direction: column; align-items: center;">

                <div style="text-align: center;">
                    <p><b>Mã đơn:</b> ${so.stockOutId}</p>

                </div>
            </div>
            <p><b>Ghi chú:</b> ${so.note}</p>

            <table>
                <tr>
                    <th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Đơn vị</th>
                </tr>

                <c:forEach items="${details}" var="d">
                    <tr>
                        <td>${d.productId}</td>
                        <td>${d.productName}</td>
                        <td>${d.quantity}</td>
                        <td>${d.unitName}</td>

                    </tr>
                </c:forEach>



            </table>

            <form method="post" action="stock_out" style="margin-top: 12px; display: flex; justify-content: center; margin-top: 50px">
                <input type="hidden" name="id" value="${so.stockOutId}" />
                <button type="submit" class="btn-approve">
                    Xác nhận xuất kho
                </button>
            </form>

        </div>



    </body>