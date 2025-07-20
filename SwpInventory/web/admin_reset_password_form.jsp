<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu người dùng</title>
    <style>
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 0;
        }

        .form-container {
            width: 90%;
            max-width: 400px;
            margin: 60px auto;
            padding: 24px;
            border: 1px solid #cceeff;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            color: #0288d1;
            font-weight: 700;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin: 12px 0 5px;
            color: #333;
            font-weight: 600;
        }

        input[type=password] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
            box-sizing: border-box;
        }

        input[type=submit] {
            width: 100%;
            padding: 12px;
            background-color: #4fc3f7;
            color: white;
            font-weight: 600;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type=submit]:hover {
            background-color: #29b6f6;
        }

        .message {
            color: green;
            text-align: center;
            margin-top: 15px;
            font-weight: 600;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 16px;
            color: #0288d1;
            font-weight: 600;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đổi mật khẩu cho: <br><b>${username}</b></h2>

        <form action="admin-reset-password" method="post">
            <input type="hidden" name="username" value="${username}" />

            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" required />

            <input type="submit" value="Xác nhận đổi mật khẩu" />
            <a href="login.jsp" class="back-link">← Quay lại đăng nhập</a>
        </form>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
    </div>
</body>
</html>
