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
                background-color: #82CAFA;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            form input[type="submit"]:hover {
                background-color: #787FF6;
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
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="breadcrumb-title">Quên mật khẩu</h2>
            <p>Vui lòng nhập email của bạn</p>
            <form action="forgotpass" method="post">
                <div>
                    <label>Email:</label>
                    <input type="text" id ="email" name="email" placeholder="Nhập email" maxlength="100" required>
                </div>
                <!--error if encountered-->
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div style="color: red"><%=error%></div>
                <%}
                %>


                <div>
                    <input type="submit" value="Gửi OTP">
                </div>
            </form>
            <div class="links">
                <a href="login.jsp">Quay lại </a>
            </div>
        </div>
    </body>
</html>
