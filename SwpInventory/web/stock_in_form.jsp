<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập hàng vào kho</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: "Segoe UI", sans-serif; margin: 0; background-color: #f4f4f4; color: #333; }
        .header { display: flex; align-items: center; justify-content: space-between; background-color: #82CAFA; color: white; padding: 12px 24px; }
        .header-left h1 { margin: 0; font-size: 1.8rem; }
        .nav a { color: white; padding: 8px 16px; border-radius: 4px; font-weight: 600; text-decoration: none; margin-left: 10px; display:flex; align-items:center;}
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
        .container { max-width: 1200px; margin: 20px auto; padding: 24px; background: white; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .page-title { color: #333; border-bottom: 2px solid #82CAFA; padding-bottom: 10px; margin-bottom: 20px; font-size: 1.5rem; }
        .form-section { margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .form-group select, .form-group input[type="text"], .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 1rem; }
        .form-group textarea { resize: vertical; min-height: 80px; }
        #product-lines-table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        #product-lines-table th, #product-lines-table td { border: 1px solid #ddd; padding: 10px; text-align: left; vertical-align: middle; }
        #product-lines-table th { background-color: #e9ecef; }
        #product-lines-table td input, #product-lines-table td select { width: 98%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .remove-row-btn { background-color: #dc3545; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; }
        .remove-row-btn:hover { background-color: #c82333; }
        .add-product-btn { background-color: #007bff; color: white; border: none; padding: 10px 15px; border-radius: 4px; cursor: pointer; font-size: 1rem; margin-top: 10px; }
        .add-product-btn:hover { background-color: #0056b3; }
        .submit-btn { display: block; width: 100%; padding: 12px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 1.2rem; font-weight: bold; margin-top: 20px; }
        .submit-btn:hover { background-color: #218838; }
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
                        <c:forEach var="supplier" items="${supplierList}"><option value="${supplier.supplier_id}">${supplier.supplier_name}</option></c:forEach>
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
                    <thead><tr><th style="width: 60%;">Sản phẩm</th><th style="width: 25%;">Số lượng nhập</th><th style="width: 15%;">Thao tác</th></tr></thead>
                    <tbody id="product-lines-body"></tbody>
                </table>
                <button type="button" class="add-product-btn" onclick="addProductLine()">+ Thêm sản phẩm</button>
            </div>
            <input type="submit" class="submit-btn" value="Xác nhận Nhập kho">
        </form>
    </div>
                    c
    <table style="display:none;"><tr id="product-row-template">
        <td><select name="productId" class="product-select" required><option value="">-- Chọn sản phẩm --</option><c:forEach var="product" items="${productList}"><option value="${product.id}">${product.name}</option></c:forEach></select></td>
        <td><input type="number" name="quantity" min="1" value="1" class="quantity-input" required></td>
        <td><button type="button" class="remove-row-btn" onclick="removeProductLine(this)">Xóa</button></td>
    </tr></table>

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
        document.addEventListener('DOMContentLoaded', function() { addProductLine(); });
    </script>
</body>
</html>