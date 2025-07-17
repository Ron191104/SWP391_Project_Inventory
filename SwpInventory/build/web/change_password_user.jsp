<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đổi mật khẩu</title>
        <style>
            .form-container {
                width: 350px;
                margin: 50px auto;
                border: 1px solid #ccc;
                padding: 30px;
                border-radius: 10px;
                background: #f9f9f9;
                font-family: Arial, sans-serif;
            }
            input[type=password], input[type=submit] {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                border: 1px solid #999;
                border-radius: 5px;
            }
            input[type=submit] {
                background-color: #4CAF50;
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
        <div class="form-container">
            <h2>Đổi mật khẩu</h2>
            <form method="post" action="changepassworduser">
                <%-- Nếu dùng session để lấy username thì dùng input hidden như sau --%>
                <input type="hidden" name="username" value="${sessionScope.username}" />

                <label>Mật khẩu cũ:</label>
                <input type="password" name="oldPassword" required />

                <label>Mật khẩu mới:</label>
                <input type="password" name="newPassword" required />

                <label>Nhập lại mật khẩu mới:</label>
                <input type="password" name="confirmPassword" required />

                <input type="submit" value="Đổi mật khẩu" />
                <!-- Nút quay lại -->
                <a href="login.jsp" style="display: inline-block; margin-top: 10px; color: #555; text-decoration: none;">
                    ← Đăng nhập lại
                </a>
            </form>

            <%-- Hiển thị thông báo nếu có --%>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="success">${message}</div>
            </c:if>
        </div>
    </body>
</html>
