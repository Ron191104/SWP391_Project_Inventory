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
            font-family: 'Montserrat', Arial, sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #0288d1;
            margin-bottom: 20px;
            font-weight: 700;
        }

        form {
            background: white;
            padding: 24px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            max-width: 500px;
            margin: 0 auto;
        }

        label {
            display: block;
            margin-bottom: 12px;
            font-weight: 600;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }

        button {
            background: #4fc3f7;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 12px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
            font-size: 16px;
            font-weight: 600;
            margin-top: 15px;
        }

        button:hover {
            background: #29b6f6;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #0288d1;
            text-decoration: none;
            font-weight: 600;
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

        <label>Họ tên:
            <input type="text" name="name" value="${user.name}" required />
        </label>

        <label>Email:
            <input type="email" name="email" value="${user.email}" required />
        </label>

        <label>Điện thoại:
            <input type="text" name="phone" value="${user.phone}" />
        </label>

        <label>Địa chỉ:
            <input type="text" name="address" value="${user.address}" />
        </label>

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

    <a href="user-management">← Quay lại danh sách</a>
</body>
</html>
