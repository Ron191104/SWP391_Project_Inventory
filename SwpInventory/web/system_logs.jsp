<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nhật ký hệ thống</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background: #ffffff;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            color: #0288d1;
            margin: 30px 0 20px;
            font-weight: 700;
        }
        .filter-form {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        .filter-form input, .filter-form select, .filter-form button {
            padding: 6px 8px;
            font-size: 14px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .filter-form button {
            background: #0288d1;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }
        .filter-form .reset-btn {
            background: #f44336;
        }
        table {
            border-collapse: collapse;
            width: 90%;
            margin: 20px auto;
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        th {
            background: #81d4fa;
            color: white;
            font-weight: bold;
            padding: 12px;
            font-size: 14px;
        }
        td {
            border: 1px solid #eee;
            padding: 10px 8px;
            font-size: 14px;
            text-align: center;
        }
        tr:nth-child(even) td {
            background: #f9f9f9;
        }
    </style>
</head>
<body>
    <%-- Sidebar --%>
    <jsp:include page="admin_sidebar.jsp" />
    <h2>Nhật ký hệ thống</h2>

    <form class="filter-form" method="get" action="system-logs">
        <input type="text" name="username" placeholder="Người thao tác" value="${param.username}" />
        <input type="text" name="action" placeholder="Hành động" value="${param.action}" />
        <input type="datetime-local" name="timestamp" value="${param.timestamp}" />
        <button type="submit">Lọc</button>
        <a href="system-logs" class="reset-btn" style="padding: 6px 10px; text-decoration: none; color: white; display: inline-block;">Reset</a>
    </form>

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
