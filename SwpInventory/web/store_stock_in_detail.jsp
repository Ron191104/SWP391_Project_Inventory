<%-- 
    Document   : store_stock_in_detail
    Created on : Jul 6, 2025, 4:15:23 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #444;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        h2 {
            margin-bottom: 10px;
        }

        p {
            font-size: 16px;
        }
    </style>
    </head>
    <body>

        <h2>Chi tiết đơn nhập #${stockIn.id}</h2>

        <p><b>Ngày tạo:</b> <fmt:formatDate value="${stockIn.importDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
        <p><b>Ghi chú:</b> ${stockIn.note}</p>
        <p><b>Trạng thái:</b>
            <c:choose>
                <c:when test="${stockIn.status == 0}">Đang xử lý</c:when>
                <c:when test="${stockIn.status == 1}">Đã duyệt</c:when>
                <c:when test="${stockIn.status == 2}">Từ chối</c:when>
                <c:otherwise>Không rõ</c:otherwise>
            </c:choose>
        </p>

        <table>
            <tr>
                <th>ID</th>
                <th>Product ID</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá nhập</th>
                <th>Thành tiền</th>
            </tr>

            <c:set var="totalAmount" value="0" />
            <c:forEach items="${details}" var="d">
                <tr>
                    <td>${d.id}</td>
                    <td>${d.productId}</td>
                    <td>${d.productName}</td>
                    <td>${d.quantity}</td>
                    <td><fmt:formatNumber value="${d.priceIn}" type="currency"/></td>
                    <td>
                        <fmt:formatNumber value="${d.quantity * d.priceIn}" type="currency"/>
                    </td>
                </tr>
                <c:set var="totalAmount" value="${totalAmount + (d.quantity * d.priceIn)}"/>
            </c:forEach>

            <tr>
                <td colspan="5" style="text-align:right; font-weight:bold">Tổng cộng:</td>
                <td><fmt:formatNumber value="${totalAmount}" type="currency"/></td>
            </tr>
        </table>

    </body>
</html>
