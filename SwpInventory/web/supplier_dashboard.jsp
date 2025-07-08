<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <title>Nhà Cung Cấp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #82CAFA;
            padding: 16px 32px;
            color: white;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .nav a {
            color: white;
            margin-left: 16px;
            font-weight: bold;
            text-decoration: none;
        }
        .nav a:hover {
            text-decoration: underline;
        }

        .main-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .card {
            flex: 1;
            min-width: 200px;
            padding: 20px;
            color: white;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .card.orange { background-color: #FFA500; }
        .card.cyan { background-color: #00CED1; }
        .card.indigo { background-color: #4B0082; }
        .card.green { background-color: #28a745; }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .section-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .section-header h2 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #82CAFA;
            color: white;
            text-align: left;
        }

        .product {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .product img {
            width: 32px;
            height: 32px;
            border-radius: 4px;
        }

        .price {
            font-weight: bold;
            color: #333;
        }

        .sno {
            width: 40px;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Nhà Cung Cấp</h1>
    <div class="nav">
        <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
        <a href="supplier-dashboard?view=approved"><i class="fas fa-check"></i> Đã cung cấp</a>
        <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
    </div>
</div>

<main class="main-content">

    <!-- Summary Cards -->
    <section class="cards">
        <div class="card orange">
            <div>
                <p>100</p>
                <p>Customers</p>
            </div>
            <i class="fas fa-user"></i>
        </div>
        <div class="card cyan">
            <div>
                <p>100</p>
                <p>Suppliers</p>
            </div>
            <i class="fas fa-user-check"></i>
        </div>
        <div class="card indigo">
            <div>
                <p>100</p>
                <p>Purchase Invoice</p>
            </div>
            <i class="fas fa-file-alt"></i>
        </div>
        <div class="card green">
            <div>
                <p>105</p>
                <p>Sales Invoice</p>
            </div>
            <i class="fas fa-file-invoice"></i>
        </div>
    </section>

    <!-- Dashboard Content Grid -->
    <section class="dashboard-grid">

        <!-- Purchase & Sales Chart -->
        <div class="section-card">
            <div class="section-header">
                <h2>Purchase & Sales</h2>
                <select>
                    <option>2022</option>
                    <option>2023</option>
                    <option selected>2024</option>
                </select>
            </div>
            <img src="https://storage.googleapis.com/a1aa/image/c868b569-edcd-49f6-34db-68201db812a0.jpg" alt="Chart" style="width: 100%; border-radius: 6px;">
        </div>

        <!-- Recently Added Products -->
        <div class="section-card">
            <div class="section-header">
                <h2>Recently Added Products</h2>
            </div>
            <table>
                <thead>
                    <tr>
                        <th class="sno">Sno</th>
                        <th>Products</th>
                        <th class="price">Price</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Ví dụ động -->
                    <c:forEach var="product" items="${recentProducts}">
                        <tr>
                            <td class="sno">${product.id}</td>
                            <td class="product">
                                <img src="${product.image}" alt="${product.name}">
                                ${product.name}
                            </td>
                            <td class="price">$${product.price}</td>
                        </tr>
                    </c:forEach>
                    <!-- Nếu bạn chưa có dữ liệu thật, bạn có thể thay bằng dữ liệu tĩnh như trong bản gốc -->
                </tbody>
            </table>
        </div>

    </section>
</main>
</body>
</html>
