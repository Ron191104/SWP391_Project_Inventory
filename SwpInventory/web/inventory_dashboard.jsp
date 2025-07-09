<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Quản lý kho</title>
    <link rel="stylesheet" href="[https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css](https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css)">
    <style>
        body { font-family: "Segoe UI", sans-serif; margin: 0; background-color: #f4f4f4; color: #333; }
        .header { display: flex; align-items: center; justify-content: space-between; background-color: #82CAFA; color: white; padding: 12px 24px; }
        .header-left h1 { margin: 0; font-size: 1.8rem; }
        .nav { display: flex; gap: 12px; margin-left: 40px; }
        .nav a { color: white; padding: 8px 16px; border-radius: 4px; font-weight: 600; text-decoration: none; display:flex; align-items:center; }
        .nav a i { margin-right: 8px; }
        .nav a:hover, .nav a.active { background-color: #787ff6; }
        .dropdown { position: relative; }
        .dropdown input[type="checkbox"] { display: none; }
        .dropdown-label { cursor: pointer; padding: 8px 16px; border-radius: 4px; color: white; display: flex; align-items: center; }
        .dropdown-label:hover { background-color: #787ff6; }
        .dropdown-menu { position: absolute; top: 100%; left: 0; background: white; color: #333; border-radius: 8px; box-shadow: 0 8px 20px rgba(0,0,0,0.15); min-width: 200px; display: none; flex-direction: column; z-index: 1000; }
        .dropdown input[type="checkbox"]:checked + .dropdown-label + .dropdown-menu { display: flex; }
        .dropdown-menu a { padding: 12px 16px; border-bottom: 1px solid #eee; font-weight: 600; color: #333; display: block; }
        .dropdown-menu a:hover { background-color: #FDF9DA; }
        .container { max-width: 1200px; margin: 20px auto; padding: 24px; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }
        .dashboard-card { background: white; border-radius: 8px; padding: 25px; text-align: center; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.2s, box-shadow 0.2s; }
        .dashboard-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.15); }
        .dashboard-card .card-icon { font-size: 3rem; color: #007bff; margin-bottom: 15px; }
        .dashboard-card h3 { margin-top: 0; color: #333; }
        .dashboard-card p { color: #555; font-size: 0.95rem; line-height: 1.5; }
        .dashboard-card a { display: inline-block; margin-top: 15px; padding: 10px 25px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .dashboard-card a:hover { background-color: #0056b3; }
        .message { padding: 15px; margin-bottom: 20px; border-radius: 4px; text-align: center; font-size: 1.1rem; }
        .success-message { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb;}
        .error-message { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;}
        .inventory-section { margin-top: 40px; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .inventory-section h2 { border-bottom: 2px solid #82CAFA; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #e9ecef; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left"><h1>Tên kho</h1></div>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <div class="dropdown">
                <input type="checkbox" id="product-dropdown-inv" />
                <label for="product-dropdown-inv" class="dropdown-label"><i class="fas fa-box"></i> Sản phẩm</label>
                <div class="dropdown-menu">
                    <a href="${pageContext.request.contextPath}/product_list"><i class="fas fa-list"></i> Danh sách sản phẩm</a>
                    <a href="#"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/inventory_dashboard" class="active"><i class="fas fa-warehouse"></i> Kho Hàng</a>
            <a href="#"><i class="fas fa-chart-bar"></i> Thống kê</a>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty sessionScope.successMessage}"><p class="message success-message"><c:out value="${sessionScope.successMessage}"/></p><c:remove var="successMessage" scope="session"/></c:if>
        <c:if test="${not empty sessionScope.errorMessage}"><p class="message error-message"><c:out value="${sessionScope.errorMessage}"/></p><c:remove var="errorMessage" scope="session"/></c:if>
        <c:if test="${not empty errorMessage}"><p class="message error-message"><c:out value="${errorMessage}"/></p></c:if>

        <div class="dashboard-grid">
             <div class="dashboard-card">
                <i class="fas fa-truck-loading card-icon"></i>
                <h3>Nhập hàng vào kho</h3>
                <p>Tạo phiếu nhập kho và cập nhật số lượng hàng hóa khi nhận hàng từ nhà cung cấp.</p>
                <a href="${pageContext.request.contextPath}/stock_in">Tạo phiếu nhập</a>
            </div>
            <div class="dashboard-card">
                <i class="fas fa-plus-circle card-icon"></i>
                <h3>Tạo đơn đặt hàng</h3>
                <p>Tạo một đơn đặt hàng mới để gửi đến nhà cung cấp.</p>
                <a href="#">Tạo đơn hàng</a>
            </div>
            <div class="dashboard-card">
                 <i class="fas fa-list-alt card-icon"></i>
                <h3>Danh sách đơn đặt hàng</h3>
                <p>Xem và quản lý tất cả các đơn đặt hàng đã tạo.</p>
                <a href="#">Xem danh sách</a>
            </div>
        </div>

        <div class="inventory-section">
            <h2>Danh sách sản phẩm trong kho</h2>
            <c:choose>
                <c:when test="${not empty inventoryList}">
                    <table>
                        <thead><tr><th>ID Sản phẩm</th><th>Tên sản phẩm</th><th>Danh mục</th><th>Số lượng trong kho</th><th>Ngày cập nhật</th></tr></thead>
                        <tbody>
                            <c:forEach var="item" items="${inventoryList}">
                                <tr>
                                    <td>${item.productId}</td>
                                    <td>${item.productName}</td>
                                    <td>${item.categoryName}</td>
                                    <td>${item.inventoryQuantity}</td>
                                    <td>
                                        <fmt:formatDate value="${item.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise><p>Chưa có sản phẩm nào trong kho.</p></c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>