<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .form-container {
            width: 90%;
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
        }

        input[type=password], input[type=submit] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type=submit] {
            background-color: #4CAF50; /* Green */
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type=submit]:hover {
            background-color: #45a049; /* Darker green */
        }

        .message {
            color: green;
            text-align: center;
            margin-top: 10px;
        }

        .back-link {
            display: inline-block;
            margin-top: 10px;
            color: #555;
            text-decoration: none;
            text-align: center;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đổi mật khẩu cho tài khoản: <b>${username}</b></h2>
        <form action="admin-reset-password" method="post">
            <input type="hidden" name="username" value="${username}" />
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" required />

            <input type="submit" value="Xác nhận đổi mật khẩu" />
            <a href="login.jsp" class="back-link">← Đăng nhập lại</a>
        </form>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
    </div>
</body>
</html>