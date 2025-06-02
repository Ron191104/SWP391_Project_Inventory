<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%
    // Đảm bảo chỉ admin (role == 4) mới được vào
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
        table { border-collapse: collapse; width: 80%; margin: auto; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background: #eee; }
        form { display: inline; }
        .menu { margin: 20px auto; text-align: center; }
        .menu a { margin: 0 15px; text-decoration: none; color: #0066cc; font-weight: bold; }
    </style>
</head>
<body>
    <div class="menu">
        <span>Xin chào, Admin!</span>
        <a href="admin-approve">Duyệt tài khoản</a>
        <a href="home.jsp">Trang chủ</a>
        <a href="logout">Đăng xuất</a>
    </div>
    <h2 style="text-align:center;">Danh sách tài khoản chờ duyệt</h2>
    <table>
        <tr>
            <th>Username</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Duyệt</th>
        </tr>
        <%
            List<User> users = (List<User>)request.getAttribute("users");
            if(users == null || users.isEmpty()) {
        %>
        <tr><td colspan="5">Không có tài khoản nào cần duyệt.</td></tr>
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
                    <input type="hidden" name="username" value="<%=u.getUsername()%>"/>
                    <button type="submit">Duyệt</button>
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