<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý người dùng</title>
    <style>
        table { border-collapse:collapse; width:90%; margin:30px auto; }
        th,td { border:1px solid #ccc; padding:8px 12px; text-align:center;}
        th { background:#e53935; color:white; }
        a.action { color: #e53935; text-decoration: underline; }
        .btn { padding: 4px 12px; background: #e53935; color: white; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Quản lý người dùng</h2>
    
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Tài khoản</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Quyền</th>
                <th>Duyệt</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="u" items="${userList}" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td>${u.username}</td>
                <td>${u.name}</td>
                <td>${u.email}</td>
                <td>${u.phone}</td>
                <td>
                    <c:choose>
                        <c:when test="${u.role == 4}">Admin</c:when>
                        <c:when test="${u.role == 1}">Nhân viên</c:when>
                        <c:when test="${u.role == 2}">Quản lý</c:when>
                        <c:when test="${u.role == 3}">Khách hàng</c:when>
                        <c:otherwise>Khác</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${u.isApproved == 1}">Đã duyệt</c:when>
                        <c:otherwise>Chờ duyệt</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="edit-user?username=${u.username}" class="action">Sửa</a> |
                    <a href="delete-user?username=${u.username}" class="action" onclick="return confirm('Xóa người dùng này?');">Xóa</a>|
                     <a href="change-password-admin?username=${user.username}">Đổi mật khẩu</a> 
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>