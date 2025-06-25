<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý nhà cung cấp</title>
    <style>
        table { border-collapse: collapse; margin-top: 20px;}
        th, td { border: 1px solid #ccc; padding: 6px 10px; }
        form.inline { display: inline; }
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
        <tr><th>ID</th><th>Tên</th><th>Điện thoại</th><th>Email</th><th>Địa chỉ</th><th>Hành động</th></tr>
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
</body>
</html>