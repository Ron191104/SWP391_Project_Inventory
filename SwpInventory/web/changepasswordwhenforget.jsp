<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forget Password</title>
        <style>
            /* Reset and base */
            * {
                box-sizing: border-box;
            }
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #eaf6ff;
                color: #333;
            }
            /* Container */
            .container {
                max-width: 400px;
                margin: 100px auto;
                padding: 24px;
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
                border-color: #4caf50;
                box-shadow: 0 0 5px #4caf50aa;
            }
            form input[type="submit"] {
                margin-top: 20px;
                width: 100%;
                padding: 12px;
                font-size: 1.1rem;
                font-weight: 700;
                border: none;
                color: white;
                background-color: #4caf50;
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
            <h2 class="breadcrumb-title">Quên mật khẩu</h2>
            <p>Vui lòng nhập mật khẩu mới!</p>
            <form action="changepasswordwhenforget" method="post">
                <label>Mật khẩu:</label>
                <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới" maxlength="100" required />
                <label>Xác nhận mật khẩu:</label>
                <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" maxlength="100" required />
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div style="color: red"><%=error%></div>
                <%}
                %>


                <div>
                    <input type="submit" value="Đổi mật khẩu">
                </div>
            </form>
        </div>
    </body>
</html>
