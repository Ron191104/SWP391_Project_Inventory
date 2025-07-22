<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.InventorySummary" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Không cần scriptlet nếu đã dùng JSTL
%>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê tổng quan tồn kho</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background: #f4f4f4; }
    </style>
</head>
<body>
    <h2>Thống kê tổng quan tồn kho</h2>
    <table>
        <tr>
            <th>Mã SP</th>
            <th>Tên sản phẩm</th>
            <th>Danh mục</th>
            <th>Nhà cung cấp</th>
            <th>Số lượng tồn</th>
            <th>Đơn vị</th>
            <th>Giá</th>
            <th>Ngày cập nhật</th>
        </tr>
        <c:forEach var="item" items="${inventoryList}">
            <tr>
                <td>${item.productId}</td>
                <td>${item.productName}</td>
                <td>${item.categoryName}</td>
                <td>${item.supplierName}</td>
                <td>${item.stockQuantity}</td>
                <td>${item.unit}</td>
                <td>${item.price}</td>
                <td>${item.updatedAt}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>