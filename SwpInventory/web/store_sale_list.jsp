<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách hóa đơn</title>
    </head>
    <body>

        <h1>Danh sách hóa đơn bán hàng</h1>


        <c:if test="${empty salesList}">
            <p style="color:red;">Chưa có hóa đơn nào.</p>
        </c:if>

        <table border="1">
            <thead>
                <tr>
                    <th>Mã hóa đơn</th>
                    <th>Khách hàng</th>
                    <th>Ngày bán</th>
                    <th>Tổng tiền</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="sale" items="${salesList}">
                    <tr>
                        <td>${sale.saleId}</td>
                        <td>${sale.customerName}</td>
                        <td>${sale.saleDate}</td>
                        <td><fmt:formatNumber value="${sale.totalAmount}" type="currency" currencySymbol="₫"/></td>
                        <td><a class="detail-link" href="sale_detail?saleId=${sale.saleId}">Xem</a></td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
