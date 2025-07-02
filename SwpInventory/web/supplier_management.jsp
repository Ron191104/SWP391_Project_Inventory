<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý nhà cung cấp</title>
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
            max-width: 600px;
            margin: 0 auto;
        }

        input[type="text"],
        input[type="email"],
        button {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background: #e53935;
            color: white;
            border: none;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background: #c62828;
        }

        table {
            border-collapse: collapse;
            margin-top: 20px;
            width: 100%;
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #e53935;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        form.inline {
            display: inline;
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
    <h2>Quản lý nhà cung cấp</h2>
    <form method="post" action="suppliers">
        <input type="hidden" name="action" value="add"/>
        <input type="text" name="supplier_name" placeholder="Tên nhà cung cấp" required />
        <input type="text" name="phone" placeholder="Số điện thoại" />
        <input type="text" name="email" placeholder="Email" />
        <input type="text" name="address" placeholder="Địa chỉ" />
        <button type="submit">Thêm</button>
    </form>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Điện thoại</th>
            <th>Email</th>
            <th>Địa chỉ</th>
            <th>Hành động</th>
        </tr>
        <c:forEach var="s" items="${suppliers}">
            <tr>
                <td>${s.supplierId}</td>
                <td>
                    <form class="inline" method="post" action="suppliers">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="supplier_id" value="${s.supplierId}"/>
                        <input type="text" name="supplier_name" value="${s.supplierName}" required />
                        <input type="text" name="phone" value="${s.phone}" />
                        <input type="text" name="email" value="${s.email}" />
                        <input type="text" name="address" value="${s.address}" />
                        <button type="submit">Sửa</button>
                    </form>
                </td>
                <td>${s.phone}</td>
                <td>${s.email}</td>
                <td>${s.address}</td>
                <td>
                    <form class="inline" method="post" action="suppliers" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="supplier_id" value="${s.supplierId}"/>
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <a href="user-management">Quay lại danh sách</a>
</body>
</html>
