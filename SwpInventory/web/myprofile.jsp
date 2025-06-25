<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thông tin cá nhân</title>
    <style>
    /* ... giữ nguyên CSS như bạn ... */
    </style>
</head>
<body>
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

            <label>Password:</label>
            <input type="password" name="password" value="${user.password}" required />

            <label>Họ tên:</label>
            <input type="text" name="name" value="${user.name}" required />

            <label>Email:</label>
            <input type="email" name="email" value="${user.email}" required />

            <label>Số điện thoại:</label>
            <input type="text" name="phone" value="${user.phone}" />

            <label>Địa chỉ:</label>
            <input type="text" name="address" value="${user.address}" />

            <label>Role:</label>
            <input type="number" name="role" value="${user.role}" required />

            <label>Avatar (Chọn ảnh mới):</label>
            <input type="file" name="imageFile" accept="image/*" />

            <c:if test="${not empty user.image}">
                <img src="${pageContext.request.contextPath}/${user.image}" alt="Avatar" />
            </c:if>

            <label>Trạng thái duyệt:</label>
            <input type="text" name="isApproved" value="${user.isApproved == 1 ? 'Đã duyệt' : 'Chưa duyệt'}" readonly />

            <button type="submit">Cập nhật</button>
        </form>
    </div>
</body>
</html>