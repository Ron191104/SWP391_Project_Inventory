
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/menu.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <title>JSP Page</title>
        <style>

            .container {
                max-width: 100%;
                padding: 10px 24px 24px 24px;
                background: white;
                margin-left: 20px;
            }
            .dashboard-cards {
                display: flex;
                justify-content: center;
                gap: 25px;
                margin-top:  20px;
                margin-bottom: 20px;
            }

            .dashboard-cards .card {
                background: #FFFEED;
                padding: 20px;
                border-radius: 10px;
                width: 150px;
                height: 55px;
                text-align: center;
                font-weight: bold;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .dashboard-cards .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            }
            .card-inf{
                font-size: 26px;
                padding-top: 10px;
                color: #FEB3C7;
            }

            .product-list {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 30px;
            }

            .product-item {
                width: 180px;
                border: 1px solid #ddd;
                border-radius: 8px;
                text-align: center;
                padding: 10px;
                background: #fff;
            }

            .product-item img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 4px;
                margin-bottom: 8px;
            }

            select{
                border-radius: 10px;
                height: 30px;
                width: 120px;
                outline: none;
                border: 2px solid #82CAFA;

            }


            .selling-container {
                display: flex;
                gap: 16px;
                flex-wrap: wrap;
                justify-content: start;
                margin-top: 16px;
            }

            .product-box {
                width: 85px;
                background-color: #ffffff;
                border: 1.5px solid #82CAFA;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 6px;
                text-align: center;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .product-box:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            }

            .product-image {
                width: 60px;
                height: 60px;
                margin-bottom: 6px;
                border-radius: 8px;
            }

            .product-name {
                font-weight: 600;
                font-size: 16px;
                color: #333;
                margin-bottom: 4px;
            }
            .quantity {
                font-size: 13px;
                color: #666;
            }

            .two-column-section {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }

            .left-column {
                flex: 1;
            }

            .right-column {
                flex: 1;
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 10px;
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
                     <c:if test="${sessionScope.userRole == 4}">
            <a href="AdminDashboardServlet" class="nav-link" style="color: #4CAF50; font-weight: bold;">
                <i class="fas fa-arrow-left"></i> Trở về Dashboard Admin
            </a>
        </c:if>
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
            <div style="margin-bottom: 12px;">
                <form action="store_dashboard" method="get">
                    <select name="filter" onchange="this.form.submit()">
                        <option value="today" ${filter == 'today' ? 'selected' : ''}>Hôm nay</option>
                        <option value="week" ${filter == 'week' ? 'selected' : ''}>Tuần</option>
                        <option value="month" ${filter == 'month' ? 'selected' : ''}>Tháng</option>
                    </select>
                </form>
            </div>

            <div class="dashboard-cards">
                <div class="card">
                    <div>Tổng sản phẩm</div>
                    <div class="card-inf">${totalProducts}</div>
                </div>
                <div class="card">
                    <div>Tổng đơn nhập</div>
                    <div class="card-inf">${totalStockIn}</div>
                </div>
                <div class="card">
                    <div>Tổng đơn bán</div>
                    <div class="card-inf">${totalSales}</div>
                </div>

                <div class="card">
                    <div>Tổng doanh thu</div>
                    <div class="card-inf"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫"/></div>
                </div>
            </div>
            <div class="two-column-section">
                <div class="left-column">
                    <h3>Top 5 sản phẩm bán chạy</h3>
                    <div class="selling-container">
                        <c:forEach var="item" items="${topSellingProducts}">
                            <div class="product-box">
                                <img src="assets/image/${item.product.image}" class="product-image"/>
                                <div class="product-name">${item.product.name}</div>
                                <div class="quantity">${item.quantity} sp đã bán</div>
                            </div>
                        </c:forEach>
                    </div>
                    <h3>Top 5 sản phẩm sắp hết hàng</h3>
                    <div class="selling-container">
                        <c:forEach var="item" items="${lowStockProducts}">
                            <div class="product-box">
                                <img src="assets/image/${item.product.image}" class="product-image" />
                                <div class="product-name">${item.product.name}</div>
                                <div class="quantity">Còn: ${item.quantity} sp</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="right-column">
                    <h3>Biểu đồ doanh thu</h3>
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>



            <h3 style="padding-top: 30px">Số lượng bán ra theo từng sản phẩm</h3>

            <canvas id="salesChart" style="width: 100%; height: 300px; margin: 0 auto; display: block;"></canvas>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                        const labels = [
                <c:forEach var="item" items="${chartData}">
                            '${item.product.name}',
                </c:forEach>
                        ];

                        const data = {
                            labels: labels,
                            datasets: [{
                                    label: 'Số lượng bán',
                                    data: [
                <c:forEach var="item" items="${chartData}">
                    ${item.quantity},
                </c:forEach>
                                    ],
                                    backgroundColor: '#FEB3C7'
                                }]
                        };

                        const config = {
                            type: 'bar',
                            data: data,
                        };

                        new Chart(document.getElementById('salesChart'), config);
            </script>

            <canvas id="revenueChart"></canvas>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

            <script>
                        const revenueLabels = [
                <c:forEach var="entry" items="${dailyRevenueMap.entrySet()}" varStatus="loop">
                        '${entry.key}'<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
                        ];

                        const revenueData = [
                <c:forEach var="entry" items="${dailyRevenueMap.entrySet()}" varStatus="loop">
                    ${entry.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
                        ];

                        const revenueChartData = {
                            labels: revenueLabels,
                            datasets: [{
                                    label: 'Doanh thu (₫)',
                                    data: revenueData,
                                    fill: false,
                                    borderColor: '#82CAFA',
                                    backgroundColor: '#82CAFA',
                                    tension: 0.2,
                                    pointRadius: 4,
                                    pointHoverRadius: 6
                                }]
                        };

                        new Chart(
                                document.getElementById('revenueChart'),
                                {
                                    type: 'line',
                                    data: revenueChartData,
                                    options: {
                                        responsive: true,
                                        plugins: {
                                            legend: {display: true}
                                        },
                                        scales: {
                                            y: {
                                                ticks: {
                                                    callback: function (value) {
                                                        return value.toLocaleString('vi-VN') + ' ₫';
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                        );
            </script>


        </div>
    </body>
</html>
