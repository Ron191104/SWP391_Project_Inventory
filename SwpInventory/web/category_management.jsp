<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý danh mục sản phẩm</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Montserrat', Arial, sans-serif; background: #ffffff; margin: 0; padding: 0; }
        .container { max-width: 800px; margin: 40px auto; padding: 24px; background: #fff; border: 1px solid #f2f2f2; border-radius: 10px; }
        h2 { text-align: center; color: #0288d1; margin-bottom: 24px; font-weight: 700; }
        .form-title { font-size: 18px; color: #039be5; font-weight: 600; margin-bottom: 10px; }
        form.main-form { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px; }
        .main-form input[type="text"] { flex: 1 1 70%; padding: 8px 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        .main-form button { flex: 1 1 28%; padding: 10px; background: #4fc3f7; color: #fff; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; }
        .main-form button:hover { background: #29b6f6; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 10px 6px; border: 1px solid #f0f0f0; font-size: 14px; text-align: center; }
        th { background: #81d4fa; color: #fff; }
        tr:nth-child(even) td { background: #f9f9f9; }
        .edit-dropdown { position: relative; display: inline-block; }
        .edit-form-content {
            display: none;
            position: absolute;
            z-index: 999;
            background: white;
            border: 1px solid #ccc;
            padding: 12px;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            min-width: 260px;
            top: 30px;
            right: 0;
        }
        .edit-dropdown.active .edit-form-content { display: block; }
        .edit-form-content input[type="text"] {
            width: 100%;
            padding: 6px;
            margin-bottom: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .edit-form-content button {
            width: 100%;
            margin-top: 5px;
            padding: 6px;
        }
        .edit-dropdown button {
            background-color: #81D4FA;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 6px 10px;
            font-weight: bold;
            cursor: pointer;
        }
        .edit-dropdown button:hover {
            background-color: #0080C0;
        }
        form[method="post"] button[type="submit"] {
            background-color: #81D4FA;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 6px 10px;
            font-weight: bold;
            cursor: pointer;
        }
        form[method="post"] button[type="submit"]:hover {
            background-color: #0080C0;
        }
        @media (max-width: 768px) {
            .main-form { flex-direction: column; }
            .main-form input,
            .main-form button { flex: 1 1 100%; }
        }
    </style>
</head>
<body>
    <jsp:include page="admin_sidebar.jsp" />
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
            <th>Hành động</th>
        </tr>
        <c:forEach var="cat" items="${categories}">
            <tr>
                <td>${cat.categoryId}</td>
                <td>${cat.categoryName}</td>
                <td>
                    <div class="edit-dropdown" id="dropdown-${cat.categoryId}">
                        <button type="button" onclick="toggleDropdown('${cat.categoryId}')">Sửa</button>
                        <div class="edit-form-content">
                            <form method="post" action="categories">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="category_id" value="${cat.categoryId}" />
                                <input type="text" name="category_name" value="${cat.categoryName}" required />
                                <button type="submit">Lưu</button>
                                <button type="button" onclick="toggleDropdown('${cat.categoryId}')">Đóng</button>
                            </form>
                        </div>
                    </div>
                    <form method="post" action="categories" style="display:inline-block; margin-left:5px;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="category_id" value="${cat.categoryId}"/>
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<script>
    function toggleDropdown(id) {
        const dropdown = document.getElementById('dropdown-' + id);
        dropdown.classList.toggle('active');
    }
    document.addEventListener('click', function (e) {
        document.querySelectorAll('.edit-dropdown').forEach(el => {
            if (!el.contains(e.target)) {
                el.classList.remove('active');
            }
        });
    });
</script>
</body>
</html>