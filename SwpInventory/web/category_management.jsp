<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý danh mục sản phẩm</title>
    <style>
        table { border-collapse: collapse; margin-top: 20px;}
        th, td { border: 1px solid #ccc; padding: 6px 10px; }
        form.inline { display: inline; }
    </style>
</head>
<body>
    <h2>Quản lý danh mục sản phẩm</h2>
    <form method="post" action="categories">
        <input type="hidden" name="action" value="add"/>
        <input type="text" name="category_name" placeholder="Tên danh mục mới" required />
        <button type="submit">Thêm</button>
    </form>
    <table>
        <tr><th>ID</th><th>Tên danh mục</th><th>Hành động</th></tr>
        <c:forEach var="cat" items="${categories}">
            <tr>
                <td>${cat.categoryId}</td>
                <td>
                    <form class="inline" method="post" action="categories">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="category_id" value="${cat.categoryId}"/>
                        <input type="text" name="category_name" value="${cat.categoryName}" required />
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
</body>
</html>