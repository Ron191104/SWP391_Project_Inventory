<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%
    Integer userRole = (Integer) session.getAttribute("userRole");
    if (session.getAttribute("userName") == null || userRole == null || userRole != 4) {
        response.sendRedirect("no_permission.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Duyệt tài khoản người dùng</title>
   <style>
    table {
        width: 90%;
        margin: 30px auto;
        border-collapse: collapse;
        background-color: #eaf4fc; /* xanh nhạt */
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 100, 200, 0.1);
    }

    th, td {
        padding: 12px 16px;
        text-align: center;
        border-bottom: 1px solid #d2e3f3;
    }

    th {
        background-color: #81D4FA;
        color: #003f7f;
        font-weight: bold;
    }

    tr:hover {
        background-color: #f2faff;
    }

    button {
        padding: 6px 14px;
        border: none;
        border-radius: 6px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    /* Nút duyệt */
    .btn-approve {
        background-color: #1e88e5;
        color: white;
    }

    .btn-approve:hover {
        background-color: #1565c0;
    }

    /* Nút xóa */
    .btn-delete {
        background-color: #e53935;
        color: white;
    }

    .btn-delete:hover {
        background-color: #c62828;
    }
</style>

</head>
<body>
        <%-- Sidebar --%>
    <jsp:include page="admin_sidebar.jsp" />
    <h2 style="text-align:center;">Danh sách tài khoản chờ duyệt</h2>

    <%-- Form sửa user nếu có --%>
    <%
      User editUser = (User) request.getAttribute("editUser");
      if (editUser != null) {
    %>
    <div style="width:60%;margin:auto;padding:15px;border:2px solid #339cff;border-radius:8px;margin-bottom:20px;">
        <h3>Sửa thông tin người dùng: <%=editUser.getUsername()%></h3>
        <form method="post" action="admin-approve">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="username" value="<%=editUser.getUsername()%>"/>
            <div>
                <label>Họ tên:</label>
                <input type="text" name="name" value="<%=editUser.getName()%>" required/>
            </div>
            <div>
                <label>Email:</label>
                <input type="email" name="email" value="<%=editUser.getEmail()%>" required/>
            </div>
            <div>
                <label>Số điện thoại:</label>
                <input type="text" name="phone" value="<%=editUser.getPhone()%>"/>
            </div>
            <div>
                <label>Địa chỉ:</label>
                <input type="text" name="address" value="<%=editUser.getAddress()%>"/>
            </div>
            <div>
                <label>Role:</label>
                <select name="role" required>
                    <option value="1" <%=editUser.getRole()==1?"selected":""%>>Inventory Management</option>
                    <option value="2" <%=editUser.getRole()==2?"selected":""%>>Store Management</option>
                    <option value="3" <%=editUser.getRole()==3?"selected":""%>>Supplier Management</option>
                    <option value="4" <%=editUser.getRole()==4?"selected":""%>>Admin</option>
                </select>
            </div>
            <button type="submit">Lưu thay đổi</button>
            <a href="admin-approve" style="margin-left:10px;">Hủy</a>
        </form>
    </div>
    <% } %>

    <table>
        <tr>
            <th>Username</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Duyệt</th>
            <th>Xóa</th>
        </tr>
        <%
            List<User> users = (List<User>)request.getAttribute("users");
            if(users == null || users.isEmpty()) {
        %>
        <tr><td colspan="7">Không có tài khoản nào cần duyệt.</td></tr>
        <%
            } else {
                for(User u : users) {
        %>
        <tr>
            <td><%=u.getUsername()%></td>
            <td><%=u.getName()%></td>
            <td><%=u.getEmail()%></td>
            <td>
                <%
                    String role = "Khác";
                    if(u.getRole()==1) role="Inventory Management";
                    else if(u.getRole()==2) role="Store Management";
                    else if(u.getRole()==3) role="Supplier Management";
                    else if(u.getRole()==4) role="Admin";
                    out.print(role);
                %>
            </td>
            <td>
                <form method="post" action="admin-approve">
                    <input type="hidden" name="action" value="approve"/>
                    <input type="hidden" name="username" value="<%=u.getUsername()%>"/>
                    <button type="submit">Duyệt</button>
                </form>
            </td>
         
            <td>
                <form method="get" action="admin-approve" onsubmit="return confirm('Bạn có chắc chắn muốn xóa người dùng này?');">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="username" value="<%=u.getUsername()%>"/>
                    <button type="submit" style="color:red;">Xóa</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>