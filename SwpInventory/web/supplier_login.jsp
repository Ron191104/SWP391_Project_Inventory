<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập Nhà Cung Cấp</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-box {
            background: white;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.2);
        }
        h2 {
            margin-bottom: 20px;
            color: #007bff;
        }
        select, button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Đăng nhập Nhà Cung Cấp</h2>
    <form method="post" action="supplier-login">
        <label for="supplierId">Chọn nhà cung cấp:</label>
        <select name="supplierId" required>
            <c:forEach var="s" items="${supplierList}">
                <option value="${s.supplier_id}">${s.supplier_name}</option>
            </c:forEach>
        </select>
        <button type="submit">Đăng nhập</button>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
    </form>
</div>
</body>
</html>
