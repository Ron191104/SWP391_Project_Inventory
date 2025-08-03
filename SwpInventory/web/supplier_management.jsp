<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý nhà cung cấp</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Montserrat', Arial, sans-serif; background: #fff; margin: 0; padding: 0; }
        .container { max-width: 1000px; margin: 40px auto; padding: 24px; background: #fff; border: 1px solid #f2f2f2; border-radius: 10px; }
        h2 { text-align: center; color: #0288d1; margin-bottom: 24px; font-weight: 700; }
        .form-title { font-size: 18px; color: #039be5; font-weight: 600; margin-bottom: 10px; }
        form.main-form { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px; }
        .main-form input[type="text"], .main-form input[type="email"] { flex: 1 1 48%; padding: 8px 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        .main-form button { flex: 1 1 100%; padding: 10px; background: #4fc3f7; color: #fff; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; }
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
            min-width: 280px;
            top: 30px;
            right: 0;
        }
        .edit-dropdown.active .edit-form-content {
            display: block;
        }
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
        }
        .status-active { color: green; font-weight: bold; }
        .status-deleted { color: red; font-weight: bold; }
        .action-btn { margin: 2px; }
    </style>
</head>
<body>

<jsp:include page="admin_sidebar.jsp" />

<div class="container">
    <h2>Quản lý nhà cung cấp</h2>

    <div class="form-title">Thêm nhà cung cấp mới</div>
    <form class="main-form" method="post" action="suppliers">
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
            <th>Tên nhà cung cấp</th>
            <th>Điện thoại</th>
            <th>Email</th>
            <th>Địa chỉ</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>

        <c:forEach var="s" items="${suppliers}">
            <tr>
                <td>${s.supplierId}</td>
                <td>${s.supplierName}</td>
                <td>${s.phone}</td>
                <td>${s.email}</td>
                <td>${s.address}</td>
                <td>
                    <c:choose>
                        <c:when test="${s.status == 1}">
                            <span class="status-active">Đang hoạt động</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-deleted">Đã xóa</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${s.status == 1}">
                            <div class="edit-dropdown" id="dropdown-${s.supplierId}">
                                <button type="button" onclick="toggleDropdown('${s.supplierId}')" class="action-btn">Sửa</button>
                                <div class="edit-form-content">
                                    <form method="post" action="suppliers">
                                        <input type="hidden" name="action" value="update" />
                                        <input type="hidden" name="supplier_id" value="${s.supplierId}" />
                                        <input type="text" name="supplier_name" value="${s.supplierName}" required />
                                        <input type="text" name="phone" value="${s.phone}" />
                                        <input type="text" name="email" value="${s.email}" />
                                        <input type="text" name="address" value="${s.address}" />
                                        <button type="submit">Lưu</button>
                                        <button type="button" onclick="toggleDropdown('${s.supplierId}')">Đóng</button>
                                    </form>
                                </div>
                            </div>
                            <form method="post" action="suppliers" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');" style="display:inline;">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="supplier_id" value="${s.supplierId}"/>
                                <button type="submit" class="action-btn">Xóa</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form method="post" action="suppliers" style="display:inline;">
                                <input type="hidden" name="action" value="restore"/>
                                <input type="hidden" name="supplier_id" value="${s.supplierId}"/>
                                <button type="submit" class="action-btn" style="background: green;">Khôi phục</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>

    <a class="back-link" href="user-management">&larr; Quay lại danh sách</a>
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
