<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    model.User user = (model.User) request.getAttribute("user");
%>
<h2>Sửa thông tin người dùng</h2>
<form action="edit-user" method="post">
    <input type="hidden" name="username" value="${user.username}" />
    <label>Họ tên: <input type="text" name="name" value="${user.name}" required /></label><br>
    <label>Email: <input type="email" name="email" value="${user.email}" required /></label><br>
    <label>Phone: <input type="text" name="phone" value="${user.phone}" /></label><br>
    <label>Địa chỉ: <input type="text" name="address" value="${user.address}" /></label><br>
    <label>Quyền:
        <select name="role">
            <option value="1" ${user.role == 1 ? 'selected' : ''}>Nhân viên</option>
            <option value="2" ${user.role == 2 ? 'selected' : ''}>Quản lý</option>
            <option value="3" ${user.role == 3 ? 'selected' : ''}>Khách hàng</option>
            <option value="4" ${user.role == 4 ? 'selected' : ''}>Admin</option>
        </select>
    </label><br>
    <button type="submit">Cập nhật</button>
</form>
<a href="user-management">Quay lại danh sách</a>