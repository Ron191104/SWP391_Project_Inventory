<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    <style>
        * { box-sizing: border-box;}
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #CBF2F2;
            color: #333;
        }
        .container {
            max-width: 430px;
            margin: 120px auto;
            padding: 25px 30px 20px 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 16px rgba(0,0,0,0.12);
        }
        h2 {
            text-align: center;
            margin-bottom: 16px;
        }
        form label {
            display: block;
            margin: 11px 0 5px;
            font-weight: 600;
        }
        form input[type="text"],
        form input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 1rem;
            border-radius: 5px;
            border: 1.8px solid #ccc;
            transition: border-color 0.3s;
        }
        form input[type="text"]:focus,
        form input[type="password"]:focus {
            border-color: #82CAFA;
            box-shadow: 0 0 5px #82CAFAaa;
            outline: none;
        }
        form input[type="submit"] {
            margin-top: 18px;
            width: 100%;
            padding: 11px;
            font-size: 1.05rem;
            font-weight: 700;
            border: none;
            color: white;
            background-color: #82CAFA;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        form input[type="submit"]:hover {
            background-color: #787FF6;
        }
        .error-message {
            color: #d32f2f;
            text-align: center;
            margin-top: 10px;
            min-height: 22px;
            font-size: 1rem;
        }
        .links {
            display: flex;
            justify-content: space-between;
            margin-top: 12px;
        }
        .links a {
            color: #1976D2;
            text-decoration: underline;
            font-size: 0.98rem;
        }
        .register-link {
            display: block;
            text-align: center;
            margin-top: 16px;
            color: #388e3c;
            text-decoration: underline;
            font-size: 1.03rem;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Đăng nhập hệ thống</h2>
    <form action="login" method="post" autocomplete="off">
        <label for="login">Email hoặc Tên đăng nhập:</label>
        <input type="text" id="login" name="login" placeholder="Nhập email hoặc Tên đăng nhập" required>

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>

        <div class="links">
            <a href="forgetpassword.jsp">Quên mật khẩu?</a>
        </div>

        <input type="submit" value="Đăng nhập">

        <div class="error-message">
            ${errorMessage}
        </div>

        <a href="register.jsp" class="register-link">Chưa có tài khoản? Đăng ký</a>
    </form>
</div>
</body>
</html>