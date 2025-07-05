<%-- 
    Document   : store_stock_in_confirm
    Created on : Jul 5, 2025, 4:52:43 PM
    Author     : ADMIN
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<h2>Kết quả nhập hàng</h2>

    <c:if test="${not empty successMessage}">
        <p style="color: green">${successMessage}</p>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <p style="color: red">${errorMessage}</p>
    </c:if>

    <a href="store_stock_in">Quay lại trang nhập hàng</a>    </body>
</html>
