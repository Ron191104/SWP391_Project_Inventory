<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    model.User user = (model.User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa thông tin người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background: #e53935;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 10px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
            font-size: 16px;
        }

        button:hover {
            background: #c62828;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #e53935;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Sửa thông tin người dùng</h2>
    <form action="edit-user" method="post">
        <input type="hidden" name="username" value="${user.username}" />
        <label>Họ tên: <input type="text" name="name" value="${user.name}" required /></label>
        <label>Email: <input type="email" name="email" value="${user.email}" required /></label>
        <label>Phone: <input type="text" name="phone" value="${user.phone}" /></label>
        <label>Địa chỉ: <input type="text" name="address" value="${user.address}" /></label>
        <label>Quyền:
            <select name="role">
                <option value="1" ${user.role == 1 ? 'selected' : ''}>Quản Lý Kho</option>
                <option value="2" ${user.role == 2 ? 'selected' : ''}>Quản Lý Cửa Hàng</option>
                <option value="3" ${user.role == 3 ? 'selected' : ''}>Nhà Cung Cấp</option>
                <option value="4" ${user.role == 4 ? 'selected' : ''}>Admin</option>
            </select>
        </label>
        <button type="submit">Cập nhật</button>
    </form>
    <a href="user-management">Quay lại danh sách</a>
</body>
</html>
