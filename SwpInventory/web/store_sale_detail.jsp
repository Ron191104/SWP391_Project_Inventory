<%-- 
    Document   : store_sale_detail
    Created on : Jul 19, 2025, 11:04:20 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta charset="UTF-8">
        <title>Chi tiết hóa đơn</title>
        <link rel="stylesheet" href="assets/css/menu.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            .invoice-box {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px #ddd;
                max-width: 800px;
                margin: auto;
            }
            h1 {
                text-align: center;
            }
            table {
                width: 100%;
                margin-top: 20px;
                border-collapse: collapse;
            }
            table th, table td {
                border: 1px solid #eee;
                padding: 10px;
                text-align: center;
            }
            .summary {
                margin-top: 20px;
                font-weight: bold;
                text-align: right;
            }
        </style>
    </head>
    <body>
        <div class="invoice-box">
            <h1>Chi tiết hóa đơn #${sale.id}</h1>

            <p><strong>Ngày bán:</strong> ${sale.saleDate}</p>
            <p><strong>Khách hàng:</strong> ${customer.name} (${customer.phone})</p>

            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${saleDetails}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${item.productName}</td>
                            <td><fmt:formatNumber value="${item.priceOut}" type="currency" currencySymbol="₫"/></td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.priceOut * item.quantity}" type="currency" currencySymbol="₫"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="summary">
                <p>Tổng tiền: <fmt:formatNumber value="${sale.totalAmount}" type="currency" currencySymbol="₫"/></p>
            </div>

            <div style="text-align:center; margin-top:30px;">
                <a href="sale_list">Quay lại danh sách hóa đơn</a>
            </div>
        </div>
    </body>
</html>
