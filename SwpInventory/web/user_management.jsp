<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý người dùng</title>
    <style>
        /* Style bảng chính */
        table {
            border-collapse: collapse;
            width: 90%;
            margin: 30px auto;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            font-size: 14px;
        }

        /* Tiêu đề bảng */
        th {
            background: #81d4fa; /* Xanh biển pastel */
            color: white;
            padding: 10px;
        }

        /* Ô dữ liệu */
        td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }

        /* Link thao tác (Sửa, Xóa, Đổi mật khẩu) */
        a.action {
            color: #0288d1;
            text-decoration: underline;
            font-weight: bold;
        }

        /* Nút chính */
        .btn {
            display: inline-block;
            padding: 8px 16px;
            background: #4fc3f7;
            color: white;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        /* Hover nút */
        .btn:hover {
            background: #29b6f6;
        }

        /* Tiêu đề trang */
        h2 {
            text-align: center;
            color: #0288d1;
            font-size: 20px;
            margin-top: 20px;
        }

        /* Container chứa nút quay lại – căn phải */
        .button-container-right {
            width: 90%;
            margin: 20px auto;
            text-align: right; /* Căn nút sang phải */
        }
    </style>
</head>
<body>

    <h2>Danh sách người dùng hệ thống</h2>

    <!-- Bảng quản lý người dùng -->
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Tài khoản</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Điện thoại</th>
                <th>Phân quyền</th>
                <th>Duyệt</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="u" items="${userList}" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td>${u.username}</td>
                <td>${u.name}</td>
                <td>${u.email}</td>
                <td>${u.phone}</td>
                <td>
                    <c:choose>
                        <c:when test="${u.role == 4}">Admin</c:when>
                        <c:when test="${u.role == 1}">Nhân viên kho</c:when>
                        <c:when test="${u.role == 2}">Quản lý cửa hàng</c:when>
                        <c:when test="${u.role == 3}">Quản lý nhà cung cấp</c:when>
                        <c:otherwise>Khác</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${u.isApproved == 1}">Đã duyệt</c:when>
                        <c:otherwise>Chờ duyệt</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="edit-user?username=${u.username}" class="action">Sửa</a> |
                    <a href="delete-user?username=${u.username}" class="action" onclick="return confirm('Xóa người dùng này?');">Xóa</a> |
                    <a href="admin-reset-password?username=${u.username}" class="action">Đổi mật khẩu</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Nút quay lại Dashboard ở dưới bảng, góc phải -->
    <div class="button-container-right">
        <a href="AdminDashboardServlet" class="btn">← Quay lại Dashboard</a>
    </div>

</body>
</html>
