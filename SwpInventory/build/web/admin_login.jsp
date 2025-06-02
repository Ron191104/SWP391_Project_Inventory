<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <style>
        body { background:#f4f4f4; font-family:Arial; }
        .center { margin:100px auto; max-width:400px; background:white; padding:32px; border-radius:8px; box-shadow:0 0 10px #bbb; }
        .form-row { margin:12px 0; }
        label { display:block; margin-bottom:4px; }
        input { width:100%; padding:8px; }
        button { background:#1e293b; color:white; border:none; padding:10px 24px; border-radius:4px; font-weight:bold; }
        .error { color:red; margin-bottom:10px;}
    </style>
</head>
<body>
    <div class="center">
        <h2>Admin Login</h2>
        <form method="post" action="admin-login">
            <div class="form-row">
                <label>Username</label>
                <input name="username" required/>
            </div>
            <div class="form-row">
                <label>Password</label>
                <input type="password" name="password" required/>
            </div>
            <div class="form-row">
                <button type="submit">Login</button>
            </div>
            <div class="error">
                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
            </div>
        </form>
    </div>
</body>
</html>