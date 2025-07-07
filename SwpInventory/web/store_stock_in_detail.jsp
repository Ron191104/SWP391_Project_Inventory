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
            body{
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;

            }
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
            h3{
                padding-left: 26px;

            }
            .info{
                font-size: 12px;
                padding-left: 30px;
                padding-top:   0px;
            }


            .container {
                padding: 24px;
                background: white;
                margin-top: -45px;
            }

            .status-processing {
                font-weight: bold;
            }

            .status-approved {
                font-weight: bold;
                color: green;
            }

            .status-rejected {
                font-weight: bold;
                color: red;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 7px;
                text-align: left;
                width: 20px;
                font-size: 0.85rem;
                text-align: center;

            }
            th {
                background-color: #82CAFA;
                color: white;
                font-weight: 700;
            }
        </style>
    </head>
    <body>
            <c:forEach var="store" items="${listStore}">
                <c:if test="${store.storeId == stockIn.storeId}">
                    <h3>Chi nhánh ${store.storeName}</h3>
                            <div class="info">

                    <div>Địa chỉ: ${store.address}</div>
                    <div>Số điện thoại: ${store.phone}</div>
                    <div>Email: ${store.email}</div>
        </div>

                </c:if>
            </c:forEach>

        <div class="container">
            <h2 style="text-align: center;">Đơn nhập hàng</h2>


            <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                <div>
                    <p><b>Ngày tạo:</b> <fmt:formatDate value="${stockIn.importDate}" pattern="dd-MM-yyyy"/></p>
                    <p><b>Thời gian:</b> <fmt:formatDate value="${stockIn.importDate}" pattern="HH:mm:ss"/></p>

                </div>

                <div>
                    <p><b>Mã đơn: </b> ${stockIn.id}</p>
                    <p><b>Trạng thái:</b>
                        <c:choose>
                            <c:when test="${stockIn.status == 0}">
                                <span class="status-processing">Đang xử lý</span>
                            </c:when>
                            <c:when test="${stockIn.status == 1}">
                                <span class="status-approved">Đã duyệt</span>
                            </c:when>
                            <c:when test="${stockIn.status == 2}">
                                <span class="status-rejected">Từ chối</span>
                            </c:when>
                        </c:choose>
                    </p>
                </div>
            </div>


            <table>
                <tr>
                    <th>Product ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá nhập</th>
                    <th>Thành tiền</th>
                </tr>

                <c:set var="totalAmount" value="0" />
                <c:forEach items="${details}" var="d">
                    <tr>
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
                    <td colspan="4" style=" font-weight:bold">Tổng cộng:</td>
                    <td style=" font-weight:bold"><fmt:formatNumber value="${totalAmount}" type="currency"/></td>
                </tr>
                <tr>
                    <td colspan="5" style="text-align: left; font-style: italic; font-weight: 650">
                        Số tiền bằng chữ: ${amountInWords} đồng
                    </td>
                </tr>

            </table>
                    <p><b>Ghi chú:</b> ${stockIn.note}</p>

            <div style="text-align: right; padding-right: 60px; padding-top: 35px">
                Người lập phiếu:<br>
                <span style="padding-right: 10px">
                    (Ký rõ họ tên)
                </span>
            </div>

        </div>
    </body>
</html>
