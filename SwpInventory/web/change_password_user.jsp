<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu</title>
    <style>
        .form-container { width: 350px; margin: 50px auto; border: 1px solid #ccc; padding: 30px; border-radius: 10px; background: #f9f9f9;}
        input[type=password], input[type=submit] { width: 100%; padding: 10px; margin: 8px 0;}
        .error { color: red; }
        .success { color: green; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đổi mật khẩu</h2>
        <form method="post" action="change-password">
            <label>Mật khẩu cũ:</label>
            <input type="password" name="oldPassword" required />
            <label>Mật khẩu mới:</label>
            <input type="password" name="newPassword" required />
            <label>Nhập lại mật khẩu mới:</label>
            <input type="password" name="confirmPassword" required />
            <input type="submit" value="Đổi mật khẩu" />
        </form>
        <div class="error">${error}</div>
        <div class="success">${message}</div>
    </div>
</body>
</html>