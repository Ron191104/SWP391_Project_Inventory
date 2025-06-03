<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập quản lý kho</title>
    <style>
         /* Reset and base */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #CBF2F2;
            color: #333;
        }
        /* Container */
        .container {
            max-width: 500px;
            margin: 200px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 16px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        /* Form styles */
        form label {
            display: block;
            margin: 12px 0 6px;
            font-weight: 600;
            color: #333;
        }
        form input[type="text"],
        form input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 1rem;
            border-radius: 6px;
            border: 1.8px solid #ccc;
            transition: border-color 0.3s ease;
        }
        form input[type="text"]:focus,
        form input[type="password"]:focus {
            outline: none;
            border-color: #82CAFA;
            box-shadow: 0 0 5px #82CAFAaa;
        }
        form input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            border: none;
            color: white;
            background-color: #82CAFA;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        form input[type="submit"]:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng nhập</h2>
        <form action="login" method="post">
            <label for="login">Email hoặc Tên đăng nhập:</label>
            <input type="text" id="login" name="login" placeholder="Nhập email hoặc tên đăng nhập" required>
            
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
            
            <input type="submit" value="Đăng nhập">
            <div style="color:red; text-align:center; margin-top:10px;">
                ${requestScope.errorMessage}
            </div>
        </form>
    </div>
</body>
</html>


