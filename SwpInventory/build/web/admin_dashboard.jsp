<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Integer userRole = (Integer) session.getAttribute("userRole");
    if (session.getAttribute("userName") == null || userRole == null || userRole != 4) {
        response.sendRedirect("no_permission.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family:Arial; background:#f4f4f4; }
        .center { margin: 60px auto; max-width: 600px; background:white; padding: 36px 32px; border-radius:8px;}
        .menu { margin:12px 0;}
        .menu a { display:inline-block; margin:0 18px; color:#1e293b; font-weight:bold; text-decoration:none;}
    </style>
</head>
<body>
    <div class="center">
        <h2>Admin Dashboard</h2>
        <div class="menu">
            <a href="admin-approve">Duyệt tài khoản người dùng</a>
            <a href="logout">Đăng xuất</a>
        </div>
        <p>Chào mừng Admin <b><%= session.getAttribute("userName") %></b>!</p>
    </div>
</body>
</html>