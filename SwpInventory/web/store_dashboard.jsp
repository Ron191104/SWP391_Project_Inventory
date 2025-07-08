
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/menu.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <title>JSP Page</title>
        <style>
            .card {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin: 30px;
                padding-left: 30px;

                display: inline-block;
                width: 160px;
                height: 80px;
            }
            .card h3 {
                font-size: 18px;
            }
            .card .value {
                font-size: 1em;
                font-weight: bold;
            }
            .tooltip {
                position: relative;
                display: inline-block;
                cursor: help;
            }
            .tooltip .tooltiptext {
                visibility: hidden;
                width: 180px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 6px;
                position: absolute;
                z-index: 10;
                bottom: 125%;
                left: 50%;
                margin-left: -90px;
                opacity: 0;
                transition: opacity 0.3s;
                font-size: 0.75rem;
            }
            .tooltip:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
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
                    <nav class="dropdown-menu" id="user-menu-dropdown">
                        <a href="myprofile.html">My Profile</a>
                        <a href="change_password.html">Change Password</a>
                        <a href="login.html">Log Out</a>
                    </nav>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>Clicks <span class="tooltip">
                    <i class="fas fa-info-circle"></i>
                    <span class="tooltiptext">Số lần nhấp chuột trên các sản phẩm hoặc quảng cáo.</span>
                </span>
                <div class="value">100</div>
                <div>-13,04%</div>
        </div>

        <div class="card">
            <h3>Clicks <span class="tooltip">
                    <i class="fas fa-info-circle"></i>
                    <span class="tooltiptext">Số lần nhấp chuột trên các sản phẩm hoặc quảng cáo.</span>
                </span>
                <div class="value">100</div>
                <div>-13,04%</div>
        </div>

    </body>
</html>
