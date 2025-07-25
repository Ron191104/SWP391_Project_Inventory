<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý danh mục sản phẩm</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background: #ffffff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 24px;
            background: #fff;
            border: 1px solid #f2f2f2;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            color: #0288d1;
            margin-bottom: 24px;
            font-weight: 700;
        }

        .form-title {
            font-size: 18px;
            color: #039be5;
            font-weight: 600;
            margin-bottom: 10px;
        }

        form.main-form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .main-form input[type="text"] {
            flex: 1 1 70%;
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .main-form button {
            flex: 1 1 28%;
            padding: 10px;
            background: #4fc3f7;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
        }

        .main-form button:hover {
            background: #29b6f6;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 10px 6px;
            border: 1px solid #f0f0f0;
            font-size: 14px;
            text-align: center;
        }

        th {
            background: #81d4fa;
            color: #fff;
        }

        tr:nth-child(even) td {
            background: #f9f9f9;
        }

        td form.inline input[type="text"] {
            width: 100px;
            font-size: 13px;
            padding: 4px 5px;
            border: none;
            border-bottom: 1px solid #ccc;
            background: transparent;
            outline: none;
            text-align: center;
        }

        td form.inline input:focus {
            border-bottom: 1px solid #29b6f6;
        }

        td form.inline button {
            padding: 4px 8px;
            font-size: 12px;
            font-weight: 600;
            background: #4fc3f7;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        td form.inline button:hover {
            background: #29b6f6;
        }

        @media (max-width: 768px) {
            .main-form {
                flex-direction: column;
            }

            .main-form input,
            .main-form button {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Quản lý danh mục sản phẩm</h2>

    <div class="form-title">Thêm danh mục mới</div>
    <form class="main-form" method="post" action="categories">
        <input type="hidden" name="action" value="add"/>
        <input type="text" name="category_name" placeholder="Tên danh mục mới" required />
        <button type="submit">Thêm</button>
    </form>

    <table>
        <tr>
            <th>ID</th>
            <th>Tên danh mục</th>
            <th>Sửa</th>
            <th>Hành động</th>
        </tr>
        <c:forEach var="cat" items="${categories}">
            <tr>
                <td>${cat.categoryId}</td>
                <td>${cat.categoryName}</td>
                <td>
                    <form class="inline" method="post" action="categories">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="category_id" value="${cat.categoryId}"/>
                        <input type="text" name="category_name" value="${cat.categoryName}" required/>
                        <button type="submit">Sửa</button>
                    </form>
                </td>
                <td>
                    <form class="inline" method="post" action="categories" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="category_id" value="${cat.categoryId}"/>
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>
