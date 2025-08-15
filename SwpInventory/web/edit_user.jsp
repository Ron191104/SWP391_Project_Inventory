<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Sửa thông tin người dùng</title>
        <style>
            .edit-user-page {
                font-family: 'Montserrat', Arial, sans-serif;
                background-color: #f0f8ff;
                padding: 40px 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }


            .edit-user-page h2 {
                text-align: center;
                color: #0288d1;
                margin-bottom: 20px;
                font-weight: 700;
            }

            .edit-user-page form {
                background: white;
                padding: 24px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                max-width: 500px;
                margin: 0 auto;
            }

            .edit-user-page label {
                display: block;
                margin-bottom: 12px;
                font-weight: 600;
                color: #333;
            }

            .edit-user-page input[type="text"],
            .edit-user-page input[type="email"],
            .edit-user-page select {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                box-sizing: border-box;
            }

            .edit-user-page button {
                background: #4fc3f7;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px;
                cursor: pointer;
                transition: background 0.3s;
                width: 100%;
                font-size: 16px;
                font-weight: 600;
                margin-top: 15px;
            }

            .edit-user-page button:hover {
                background: #29b6f6;
            }

            .edit-user-page a {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #0288d1;
                text-decoration: none;
                font-weight: 600;
            }

            .edit-user-page a:hover {
                text-decoration: underline;
            }

            .edit-user-page .error {
                color: red;
                background: #ffeaea;
                padding: 10px 15px;
                border-radius: 6px;
                font-weight: 600;
                margin-bottom: 20px;
                text-align: center;
            }
        </style>
    </head>

    <body>
        <%-- Sidebar --%>
        <jsp:include page="admin_sidebar.jsp" />

        <div class="edit-user-page">
            <h2>Sửa thông tin người dùng</h2>

            <c:if test="${not empty errorMsg}">
                <div class="error">${errorMsg}</div>
            </c:if>

            <form action="edit-user" method="post">
                <input type="hidden" name="username" value="${user.username}" />

                <label>Họ tên:
                    <input type="text" name="name" value="${user.name}" required />
                </label>

                <label>Email:
                    <input type="email" name="email" value="${user.email}" required />
                </label>

                <label>Điện thoại:
                    <input type="text" name="phone" value="${user.phone}" required />
                </label>

                <label>Địa chỉ:
                    <input type="text" name="address" value="${user.address}" required />
                </label>

                <label>Quyền:
                    <select name="role" required>
                        <option value="1" <c:if test="${user.role == 1}">selected</c:if>>Quản Lý Kho</option>
                        <option value="2" <c:if test="${user.role == 2}">selected</c:if>>Quản Lý Cửa Hàng</option>
                        <option value="3" <c:if test="${user.role == 3}">selected</c:if>>Nhà Cung Cấp</option>
                    </select>
                </label>

                <button type="submit">Cập nhật</button>
            </form>

            <a href="user-management">← Quay lại danh sách</a>
        </div>
    </body>
</html>
