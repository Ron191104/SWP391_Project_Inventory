<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("userName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Object roleObj = session.getAttribute("userRole");
    if (roleObj == null || !roleObj.toString().equals("4")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            /* CSS  */

            .notification-wrapper {
                position: relative;
                cursor: pointer;
                color: white;
            }
            .notification-icon {
                width: 24px;
                height: 24px;
                fill: currentColor;
            }
            .notification-badge {
                position: absolute;
                top: -4px;
                right: -4px;
                background-color: #fff6c5;
                color: #d32f2f;
                font-size: 0.7rem;
                font-weight: 700;
                border-radius: 50%;
                padding: 2px 6px;
            }
            .notification-dropdown {
                position: absolute;
                top: 34px;
                right: 0;
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 240px;
                max-height: 250px;
                overflow-y: auto;
                display: none;
                flex-direction: column;
                padding: 10px 0;
                z-index: 1000;
            }
            .notification-wrapper:hover .notification-dropdown {
                display: flex;
            }
            .notification-dropdown div {
                padding: 8px 16px;
                border-bottom: 1px solid #eee;
                font-size: 0.9rem;
            }
            .user-menu {
                position: relative;
            }
            .user-menu input[type="checkbox"] {
                display: none;
            }
            .user-menu label {
                cursor: pointer;
                border: 2px solid white;
                border-radius: 50%;
                overflow: hidden;
                width: 40px;
                height: 40px;
            }
            .user-menu label img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .user-menu nav.dropdown-menu {
                position: absolute;
                top: 50px;
                right: 0;
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 180px;
                display: none;
                flex-direction: column;
                overflow: hidden;
                z-index: 1000;
            }
            .user-menu input[type="checkbox"]:checked + label + nav.dropdown-menu {
                display: flex;
            }
            .user-menu nav.dropdown-menu a {
                padding: 12px 16px;
                border-bottom: 1px solid #eee;
                font-weight: 600;
                white-space: nowrap;
            }
            .user-menu nav.dropdown-menu a:last-child {
                border-bottom: none;
                color: #0080C0;
            }
            .user-menu nav.dropdown-menu a:hover {
                background-color: #FDF9DA;
            }

            .cards {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center; /* ✅ Căn giữa theo chiều ngang */
                margin: 20px auto;
                max-width: 1000px; /* tùy chọn để giới hạn chiều rộng */
            }

            .card {
                flex: 1 1 150px;
                max-width: 220px;
                background-color: #FDF9DA;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 10px;
                text-align: center;
                position: relative;
                height: 60px;
                min-width: 150px;
            }

            .card.orange {
                background: #FFF3E0;
            }
            .card.cyan {
                background: #E0F7FA;
            }
            .card.indigo {
                background: #E8EAF6;
            }
            .card.green {
                background: #E8F5E9;
            }
            .card p {
                margin: 0;
                font-size: 0.9rem;
                font-weight: bold;
            }
            .card i {
                font-size: 1rem;
                position: absolute;
                top: 10px;
                right: 10px;
                color: #0080C0;
            }

            /* --- CSS ĐÃ CHỈNH SỬA CHO BIỂU ĐỒ --- */
            .chart-section {
                display: flex;
                flex-wrap: wrap;
                gap: 30px; /* Giữ khoảng cách giữa các biểu đồ */
                justify-content: center; /* Căn giữa các biểu đồ trong section */
                margin-top: 30px;
                padding: 20px; /* Tăng padding để có khoảng trống xung quanh */
                align-items: flex-start; /* Quan trọng: căn chỉnh các item theo top */
            }

            .chart-card {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                /* Thay đổi: Sử dụng flex-basis thay vì flex: 1 1 calc(...) để kiểm soát kích thước chính xác hơn */
                flex-basis: calc(50% - 15px); /* Mỗi card chiếm gần 50% chiều rộng, trừ đi 1 nửa gap */
                max-width: calc(50% - 15px); /* Đảm bảo không quá rộng */
                min-width: 380px; /* Tăng giới hạn kích thước tối thiểu để biểu đồ không quá nhỏ */
                box-sizing: border-box; /* Đảm bảo padding không làm tăng width */
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                height: 400px; /* Giữ chiều cao cố định cho các biểu đồ cột và tròn */
                /* Nếu biểu đồ tròn cần ít chiều cao hơn, bạn có thể tạo một class riêng cho nó */
                /* Ví dụ: .chart-card.pie-chart { height: 350px; } */
            }

            /* Đảm bảo canvas chiếm hết không gian trong card */
            canvas {
                max-width: 100%;
                height: 100% !important; /* Buộc canvas chiếm toàn bộ chiều cao của phần tử cha */
                width: 100% !important; /* Buộc canvas chiếm toàn bộ chiều rộng của phần tử cha */
                box-sizing: border-box; /* Quan trọng để padding của card không ảnh hưởng đến kích thước canvas */
            }

            h2.chart-title {
                text-align: center;
                color: #555;
                margin-bottom: 20px;
                font-size: 1.5em;
                flex-shrink: 0; /* Ngăn tiêu đề bị co lại khi không gian hạn chế */
            }

            /* Di chuyển biểu đồ tròn xuống hàng mới và căn giữa */
            /* Thêm một container cho biểu đồ tròn để nó nằm riêng một hàng và cân đối hơn */
            .pie-chart-container {
                flex-basis: 100%; /* Chiếm toàn bộ chiều rộng */
                display: flex;
                justify-content: center; /* Căn giữa card biểu đồ tròn */
            }

            .chart-card.pie-chart {
                flex-basis: calc(60% - 15px); /* Đặt kích thước cụ thể cho biểu đồ tròn, ví dụ 60% */
                max-width: 500px; /* Giới hạn kích thước tối đa để không quá lớn */
                height: 450px; /* Điều chỉnh chiều cao cho biểu đồ tròn nếu cần */
                align-self: center; /* Tự căn giữa nếu nó là một item trong flex container */
                margin-top: 20px; /* Thêm khoảng cách với các biểu đồ trên */
            }
            /* --- KẾT THÚC CSS BỔ SUNG --- */

            @media (max-width: 768px) {
                .header {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .nav {
                    justify-content: center;
                    margin-left: 0;
                }
                .header-right {
                    flex-wrap: wrap;
                    justify-content: center;
                }
                .chart-card {
                    width: 95%; /* Trên màn hình nhỏ, biểu đồ chiếm gần toàn bộ chiều rộng */
                    max-width: 95%; /* Đảm bảo không tràn */
                    margin-bottom: 20px; /* Thêm khoảng cách dưới cho mobile */
                    height: auto; /* Trên mobile cho phép chiều cao tự động để không bị quá cao nếu nội dung ít */
                    min-height: 300px; /* Giữ chiều cao tối thiểu cho mobile */
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="admin_sidebar.jsp" />


        <main class="main-content">
            <section class="cards">

                <article class="card cyan">
                    <p>${supplierCount}</p>
                    <p>Suppliers</p>
                    <i class="fas fa-user-check"></i>
                </article>
                <article class="card indigo">
                    <p>${purchaseInvoiceCount}</p>
                    <p>Purchase Invoice</p>
                    <i class="fas fa-file-alt"></i>
                </article>
                <article class="card green">
                    <p>${salesInvoiceCount}</p>
                    <p>Sales Invoice</p>
                    <i class="fas fa-file-invoice-dollar"></i>
                </article>
            </section>

            <div class="chart-section">
                <div class="chart-card">
                    <h2 class="chart-title">Top 5 Sản phẩm Tồn kho nhiều nhất</h2>
                    <canvas id="top5MostStockedProductsChart"></canvas>
                </div>

                <div class="chart-card">
                    <h2 class="chart-title">Top 5 Sản phẩm Tồn kho ít nhất</h2>
                    <canvas id="top5LeastStockedProductsChart"></canvas>
                </div>

                <%-- Thêm một container riêng cho biểu đồ tròn --%>
                <div class="pie-chart-container">
                    <div class="chart-card pie-chart"> <%-- Thêm class 'pie-chart' --%>
                        <h2 class="chart-title">Tỷ lệ Tồn kho theo Danh mục</h2>
                        <canvas id="categoryStockChart"></canvas>
                    </div>
                </div>
            </div>
        </main>

        <script>
            // --- Biểu đồ Top 5 Sản phẩm Tồn kho nhiều nhất (Bar Chart) ---
            const top5MostStockedProductsLabels = [];
            const top5MostStockedProductsData = [];
            <c:forEach var="item" items="${top5MostStockedProducts}">
            top5MostStockedProductsLabels.push("${item.productName}");
            top5MostStockedProductsData.push(${item.totalQuantity});
            </c:forEach>

            if (top5MostStockedProductsData.length > 0) {
                const ctx1 = document.getElementById('top5MostStockedProductsChart').getContext('2d');
                new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: top5MostStockedProductsLabels,
                        datasets: [{
                                label: 'Số lượng tồn kho',
                                data: top5MostStockedProductsData,
                                backgroundColor: 'rgba(54, 162, 235, 0.6)', // Blue
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false, // Quan trọng: Tắt tỷ lệ khung hình tự động
                        scales: {
                            y: {beginAtZero: true, title: {display: true, text: 'Số lượng'}},
                            x: {title: {display: true, text: 'Sản phẩm'}}
                        },
                        plugins: {legend: {display: false}, tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return context.raw + ' sản phẩm';
                                    }
                                }
                            }}
                    }
                });
            } else {
                document.getElementById('top5MostStockedProductsChart').parentElement.innerHTML = "<p style='text-align: center; color: #888; padding: 20px;'>Không có dữ liệu tồn kho nhiều nhất để hiển thị.</p>";
            }

            // --- Biểu đồ Top 5 Sản phẩm Tồn kho ít nhất (Bar Chart) ---
            const top5LeastStockedProductsLabels = [];
            const top5LeastStockedProductsData = [];
            <c:forEach var="item" items="${top5LeastStockedProducts}">
            top5LeastStockedProductsLabels.push("${item.productName}");
            top5LeastStockedProductsData.push(${item.totalQuantity});
            </c:forEach>

            if (top5LeastStockedProductsData.length > 0) {
                const ctx2 = document.getElementById('top5LeastStockedProductsChart').getContext('2d');
                new Chart(ctx2, {
                    type: 'bar',
                    data: {
                        labels: top5LeastStockedProductsLabels,
                        datasets: [{
                                label: 'Số lượng tồn kho',
                                data: top5LeastStockedProductsData,
                                backgroundColor: 'rgba(255, 99, 132, 0.6)', // Red
                                borderColor: 'rgba(255, 99, 132, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false, // Quan trọng: Tắt tỷ lệ khung hình tự động
                        scales: {
                            y: {beginAtZero: true, title: {display: true, text: 'Số lượng'}},
                            x: {title: {display: true, text: 'Sản phẩm'}}
                        },
                        plugins: {legend: {display: false}, tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return context.raw + ' sản phẩm';
                                    }
                                }
                            }}
                    }
                });
            } else {
                document.getElementById('top5LeastStockedProductsChart').parentElement.innerHTML = "<p style='text-align: center; color: #888; padding: 20px;'>Không có dữ liệu tồn kho ít nhất để hiển thị.</p>";
            }

            // --- Biểu đồ Tỷ lệ Tồn kho theo Danh mục (Pie Chart) ---
            const categoryStockLabels = [];
            const categoryStockData = [];
            <c:forEach var="item" items="${categoryStockDistribution}">
            categoryStockLabels.push("${item.categoryName}");
            categoryStockData.push(${item.totalQuantity});
            </c:forEach>

            if (categoryStockData.length > 0) {
                const ctx3 = document.getElementById('categoryStockChart').getContext('2d');
                new Chart(ctx3, {
                    type: 'pie',
                    data: {
                        labels: categoryStockLabels,
                        datasets: [{
                                label: 'Số lượng tồn kho',
                                data: categoryStockData,
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.8)', 'rgba(54, 162, 235, 0.8)',
                                    'rgba(255, 206, 86, 0.8)', 'rgba(75, 192, 192, 0.8)',
                                    'rgba(153, 102, 255, 0.8)', 'rgba(255, 159, 64, 0.8)',
                                    'rgba(201, 203, 207, 0.8)'
                                ],
                                borderColor: 'white',
                                borderWidth: 2
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false, // Quan trọng: Tắt tỷ lệ khung hình tự động
                        plugins: {
                            legend: {position: 'right'},
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        let label = context.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        const value = context.raw;
                                        const total = context.dataset.data.reduce((acc, current) => acc + current, 0);
                                        const percentage = ((value / total) * 100).toFixed(2);
                                        return label + value + ' (' + percentage + '%)';
                                    }
                                }
                            }
                        }
                    }
                });
            } else {
                document.getElementById('categoryStockChart').parentElement.innerHTML = "<p style='text-align: center; color: #888; padding: 20px;'>Không có dữ liệu danh mục để hiển thị biểu đồ tỷ lệ.</p>";
            }

        </script>

        <!-- Phần Script load thông báo -->
        <script>
            function loadNotifications() {
                fetch('<%= request.getContextPath() %>/load-notifications')
                        .then(response => response.json())
                        .then(data => {
                            const dropdown = document.querySelector('.notification-dropdown');
                            const badge = document.querySelector('.notification-badge');

                            dropdown.innerHTML = '';
                            let unreadCount = 0;

                            if (data.length > 0) {
                                data.forEach(item => {
                                    const div = document.createElement('div');
                                    div.textContent = item.message;
                                    if (!item.isRead) {
                                        div.style.fontWeight = 'bold';
                                        unreadCount++;
                                    }
                                    dropdown.appendChild(div);
                                });
                            } else {
                                dropdown.innerHTML = '<div>Không có thông báo nào.</div>';
                            }

                            badge.textContent = unreadCount > 0 ? unreadCount : '';
                        })
                        .catch(error => {
                            console.error('Lỗi khi tải thông báo:', error);
                        });
            }

            //  sự kiện khi hover chuông (hoặc click):
            document.querySelector('.notification-wrapper').addEventListener('mouseenter', () => {
                fetch('<%= request.getContextPath() %>/mark-notifications-read', {
                    method: 'POST'
                }).then(() => {
                    // Sau khi đánh dấu đã đọc → load lại thông báo để cập nhật badge
                    loadNotifications();
                });
            });

            window.addEventListener('load', loadNotifications);
        </script>
    </body>
</html>