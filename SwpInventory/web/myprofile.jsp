<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
    <title>Thông tin cá nhân</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }

        .topbar {
            background-color: #0080C0;
            color: white;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topbar .role {
            font-weight: bold;
        }

        .topbar .links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 600;
        }

        .profile-box {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 600px;
            margin: 30px auto;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .success {
            color: green;
            margin-bottom: 15px;
        }

        .error {
            color: red;
            margin-bottom: 15px;
        }

        button {
            background-color: #81D4FA;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #0080C0;
        }

        img {
            max-width: 100%;
            height: auto;
            border-radius: 50%;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<!-- Thanh menu -->
<div class="topbar">
    <div class="role">
        Vai trò:
        <c:choose>
            <c:when test="${sessionScope.userRole == '1'}">Quản lý kho</c:when>
            <c:when test="${sessionScope.userRole == '2'}">Quản lý cửa hàng</c:when>
            <c:when test="${sessionScope.userRole == '3'}">Nhà cung cấp</c:when>
            <c:when test="${sessionScope.userRole == '4'}">Admin</c:when>
            <c:otherwise>Không xác định</c:otherwise>
        </c:choose>
    </div>
    <div class="links">
        <a href="javascript:history.back()">← Quay lại</a>
    </div>
</div>

<!-- Hộp thông tin -->
<div class="profile-box">
    <h2>Thông tin cá nhân</h2>

    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form method="post" action="myprofile" enctype="multipart/form-data">
        <label>Username:</label>
        <input type="text" name="username" value="${user.username}" readonly />

        <label>Họ tên:</label>
        <input type="text" name="name" value="${user.name}" required />

        <label>Email:</label>
        <input type="email" name="email" value="${user.email}" required />

        <label>Số điện thoại:</label>
        <input type="text" name="phone" value="${user.phone}" required />

        <label>Địa chỉ:</label>
        <input type="text" name="address" value="${user.address}" required />

        <label>Role:</label>
        <input type="number" name="role" value="${user.role}" readonly />

        <label>Avatar (Chọn ảnh mới):</label>
        <input type="file" name="imageFile" accept="image/*" />

        <c:if test="${not empty user.image}">
            <img src="${pageContext.request.contextPath}/${user.image}" alt="Avatar" />
        </c:if>

        <label>Trạng thái duyệt:</label>
        <input type="text" name="isApproved"
               value="${user.isApproved == 1 ? 'Đã duyệt' : 'Chưa duyệt'}" readonly />

        <button type="submit">Cập nhật</button>
    </form>
</div>

</body>
</html>
