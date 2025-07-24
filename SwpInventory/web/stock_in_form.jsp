<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập hàng vào kho</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            margin: 0;
            background: linear-gradient(120deg, #e0eafc 0%, #cfdef3 100%);
            color: #222;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(90deg, #6dd5ed 0%, #2193b0 100%);
            color: white;
            padding: 16px 32px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.07);
        }
        .header-left h1 {
            margin: 0;
            font-size: 2.1rem;
            letter-spacing: 1px;
            font-weight: 600;
        }
        .nav {
            display: flex;
            align-items: center;
        }
        .nav a, .dropdown-label {
            color: white;
            padding: 10px 18px;
            border-radius: 5px;
            font-weight: 600;
            text-decoration: none;
            margin-left: 14px;
            transition: background 0.2s;
            display: flex;
            align-items: center;
        }
        .nav a i, .dropdown-label i {
            margin-right: 8px;
        }
        .nav a:hover, .nav a.active, .dropdown-label:hover {
            background-color: #1976d2;
        }
        .dropdown {
            position: relative;
            margin-left: 14px;
        }
        .dropdown input[type="checkbox"] { display: none; }
        .dropdown-label {
            cursor: pointer;
            background: transparent;
        }
        .dropdown-menu {
            position: absolute;
            top: 110%;
            left: 0;
            background: white;
            color: #333;
            border-radius: 8px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.12);
            min-width: 210px;
            display: none;
            flex-direction: column;
            z-index: 1000;
            overflow: hidden;
        }
        .dropdown input[type="checkbox"]:checked + .dropdown-label + .dropdown-menu {
            display: flex;
        }
        .dropdown-menu a {
            padding: 13px 18px;
            border-bottom: 1px solid #f4f4f4;
            font-weight: 500;
            color: #1976d2;
            text-decoration: none;
            transition: background 0.18s;
        }
        .dropdown-menu a:last-child { border-bottom: none; }
        .dropdown-menu a:hover {
            background-color: #f0f7ff;
        }
        .container {
            max-width: 900px;
            margin: 34px auto 0 auto;
            padding: 32px 36px 28px 36px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 10px 32px rgba(37,78,140,0.11);
        }
        .page-title {
            color: #1976d2;
            border-bottom: 2.5px solid #6dd5ed;
            padding-bottom: 10px;
            margin-bottom: 26px;
            font-size: 1.8rem;
            font-weight: 600;
        }
        .form-section {
            margin-bottom: 32px;
        }
        .form-section h4 {
            margin-bottom: 12px;
            color: #2193b0;
            font-size: 1.15rem;
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #374151;
        }
        .form-group select, .form-group input[type="text"], .form-group textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1.5px solid #b3c2db;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.2s;
            background: #f8fbff;
        }
        .form-group select:focus, .form-group input:focus, .form-group textarea:focus {
            border-color: #2193b0;
            outline: none;
            background: #e8f6fd;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }
        #product-lines-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: #f6fafd;
            border-radius: 7px;
            overflow: hidden;
        }
        #product-lines-table th, #product-lines-table td {
            border: none;
            padding: 14px 10px;
            text-align: left;
            vertical-align: middle;
        }
        #product-lines-table th {
            background-color: #e9f3fa;
            font-weight: 600;
            color: #1976d2;
        }
        #product-lines-table td input, #product-lines-table td select {
            width: 98%;
            padding: 8px 9px;
            border: 1px solid #b3c2db;
            border-radius: 4px;
            background: #f8fbff;
            font-size: 1rem;
            transition: border-color 0.2s;
        }
        #product-lines-table td input:focus, #product-lines-table td select:focus {
            border-color: #2193b0;
            background: #e8f6fd;
        }
        .remove-row-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 7px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.97rem;
            transition: background 0.18s;
        }
        .remove-row-btn:hover {
            background-color: #c82333;
        }
        .add-product-btn {
            background-color: #1976d2;
            color: white;
            border: none;
            padding: 11px 18px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.05rem;
            font-weight: 600;
            margin-top: 12px;
            box-shadow: 0 2px 6px rgba(33,147,176,0.08);
            transition: background 0.18s;
        }
        .add-product-btn:hover {
            background-color: #2193b0;
        }
        .submit-btn {
            display: block;
            width: 100%;
            padding: 16px 0;
            background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            color: white;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-size: 1.18rem;
            font-weight: bold;
            margin-top: 28px;
            box-shadow: 0 3px 12px rgba(33,147,176,0.10);
            transition: background 0.18s;
        }
        .submit-btn:hover {
            background: linear-gradient(90deg, #1976d2 0%, #2193b0 100%);
        }
        @media (max-width: 700px) {
            .container { padding: 16px 6px; }
            .header { flex-direction: column; padding: 10px 6px; }
            .page-title { font-size: 1.1rem; }
            #product-lines-table th, #product-lines-table td { padding: 9px 6px; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left"><h1>Tên kho</h1></div>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <div class="dropdown">
                <input type="checkbox" id="product-dropdown-stockin" />
                <label for="product-dropdown-stockin" class="dropdown-label"><i class="fas fa-box"></i> Sản phẩm</label>
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
        <h2 class="page-title">Tạo Phiếu Nhập Kho</h2>
        <form action="${pageContext.request.contextPath}/stock_in" method="POST" id="stock-in-form">
            <div class="form-section">
                <h4>Thông tin chung</h4>
                <div class="form-group">
                    <label for="supplierId">Nhà cung cấp</label>
                    <select id="supplierId" name="supplierId" required>
                        <option value="">-- Chọn nhà cung cấp --</option>
                        <c:forEach var="supplier" items="${supplierList}">
                            <option value="${supplier.supplierId}">${supplier.supplierName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="note">Ghi chú</label>
                    <textarea id="note" name="note" placeholder="Thêm ghi chú cho phiếu nhập kho..."></textarea>
                </div>
            </div>
            <div class="form-section">
                <h4>Chi tiết sản phẩm</h4>
                <table id="product-lines-table">
                    <thead>
                        <tr>
                            <th style="width: 60%;">Sản phẩm</th>
                            <th style="width: 25%;">Số lượng nhập</th>
                            <th style="width: 15%;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="product-lines-body"></tbody>
                </table>
                <button type="button" class="add-product-btn" onclick="addProductLine()">+ Thêm sản phẩm</button>
            </div>
            <input type="submit" class="submit-btn" value="Xác nhận Nhập kho">
        </form>
    </div>

    <table style="display:none;">
        <tr id="product-row-template">
            <td>
                <select name="productId" class="product-select" required>
                    <option value="">-- Chọn sản phẩm --</option>
                    <c:forEach var="product" items="${productList}">
                        <option value="${product.id}">${product.name}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="number" name="quantity" min="1" value="1" class="quantity-input" required>
            </td>
            <td>
                <button type="button" class="remove-row-btn" onclick="removeProductLine(this)">Xóa</button>
            </td>
        </tr>
    </table>

    <script>
        function addProductLine() {
            const template = document.getElementById('product-row-template');
            const tBody = document.getElementById('product-lines-body');
            const newRow = template.cloneNode(true);
            newRow.removeAttribute('id');
            tBody.appendChild(newRow);
        }
        function removeProductLine(button) {
            const rowToRemove = button.parentNode.parentNode;
            rowToRemove.parentNode.removeChild(rowToRemove);
        }
        document.addEventListener('DOMContentLoaded', function () {
            addProductLine();
        });
    </script>
</body>
</html>