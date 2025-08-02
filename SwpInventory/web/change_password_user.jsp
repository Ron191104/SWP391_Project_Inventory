<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f4f4;
        }

        .topbar {
            background-color: #0080C0;
            color: white;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topbar .role {
            font-weight: bold;
        }

        .topbar .links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 600;
        }

        .form-container {
            width: 350px;
            margin: 50px auto;
            border: 1px solid #ccc;
            padding: 30px;
            border-radius: 10px;
            background: #fff;
        }

        input[type=password], input[type=submit] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #999;
            border-radius: 5px;
        }

        input[type=submit] {
            background-color: #0080C0;
            color: white;
            cursor: pointer;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .success {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <%-- Sidebar --%>
    <jsp:include page="admin_sidebar.jsp" />

    <div class="form-container">
        <h2>Đổi mật khẩu</h2>
        <form method="post" action="changepassworduser">
            <input type="hidden" name="username" value="${sessionScope.username}" />

            <label>Mật khẩu cũ:</label>
            <input type="password" name="oldPassword" required />

            <label>Mật khẩu mới:</label>
            <input type="password" name="newPassword" required />

            <label>Nhập lại mật khẩu mới:</label>
            <input type="password" name="confirmPassword" required />

            <input type="submit" value="Đổi mật khẩu" />
        </form>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>
    </div>
</body>
</html>
