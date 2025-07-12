<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập Nhà Cung Cấp</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #eef2f3; /* Màu nền nhẹ để làm nổi bật hộp đăng nhập */
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background: white;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            width: 300px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
        }
        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }
        select, button {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            transition: border-color 0.3s;
        }
        select:focus, button:focus {
            border-color: #82CAFA; /* Màu chủ đạo khi focus */
            outline: none;
        }
        button {
            background-color: #82CAFA; /* Màu chủ đạo cho nút bấm */
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #66B2D8; /* Màu tối hơn khi hover */
        }
        .error {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Đăng nhập Nhà Cung Cấp</h2>
    <form method="post" action="${pageContext.request.contextPath}/supplier_login">
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