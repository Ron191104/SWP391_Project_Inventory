<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nhật ký hệ thống</title>
    <style>
        table { border-collapse:collapse; width:90%; margin:30px auto;}
        th,td { border:1px solid #ccc; padding:8px 12px; text-align:center;}
        th { background:#e53935; color:white; }
        td { background:#fff; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Nhật ký hệ thống</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Người thao tác</th>
                <th>Hành động</th>
                <th>Chi tiết</th>
                <th>Thời gian</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="log" items="${logList}">
            <tr>
                <td>${log.id}</td>
                <td>${log.username}</td>
                <td>${log.action}</td>
                <td>${log.details}</td>
                <td>${log.logTime}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>