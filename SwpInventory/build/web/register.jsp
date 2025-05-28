<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>User Registration - Store Management</title>
    <style>
        /* Reset some default styles */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #fff6e5, #ffcc66);
        }
        .container {
            background: #fff9eb;
            max-width: 480px;
            width: 90%;
            padding: 40px 50px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(255, 204, 102, 0.5);
            color: #5a3e00;
            border: 3px solid #ffcc66;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            color: #a16a00;
            text-shadow: 1px 1px 3px #dba81b;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
            color: #7f5e00;
            cursor: pointer;
            text-shadow: 0 1px 0 #fff2cc;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 12px 16px;
            margin-bottom: 20px;
            border: 2px solid #ffcc66;
            border-radius: 10px;
            font-size: 16px;
            color: #6a4a00;
            background: #fffde7;
            box-shadow: inset 2px 2px 6px #f9deb3;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        select:focus {
            border-color: #e6b800;
            outline: none;
            box-shadow: 0 0 8px rgba(255, 204, 102, 0.8);
            background: #fff8cc;
        }
        .btn-primary {
            width: 100%;
            padding: 16px;
            background-color: #ffb400;
            border: none;
            border-radius: 12px;
            color: #512b00;
            font-weight: 800;
            font-size: 20px;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(255, 180, 0, 0.6);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            text-shadow: 1px 1px 3px #f9d769;
        }
        .btn-primary:hover {
            background-color: #e6a300;
            box-shadow: 0 6px 20px rgba(230, 163, 0, 0.8);
        }
        @media (max-width: 520px) {
            .container {
                padding: 30px 25px;
            }
            h2 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
    <div class="container" role="main">
        <h2>User Registration</h2>
        <% String err = (String) request.getAttribute("error");
           if (err != null) { %>
            <div style="color: red; margin-bottom:16px;"><%= err %></div>
        <% } %>
        <form id="registrationForm" action="register" method="POST" novalidate>
            <label for="username">Username *</label>
            <input type="text" id="username" name="username" required maxlength="50" placeholder="Enter username" value="<%= request.getParameter("username")!=null?request.getParameter("username"):"" %>"/>

            <label for="password">Password *</label>
            <input type="password" id="password" name="password" required maxlength="255" placeholder="Enter password" />

            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" maxlength="100" placeholder="Enter full name" value="<%= request.getParameter("name")!=null?request.getParameter("name"):"" %>"/>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" maxlength="100" placeholder="Enter email" value="<%= request.getParameter("email")!=null?request.getParameter("email"):"" %>"/>

            <label for="phone">Phone</label>
            <input type="tel" id="phone" name="phone" maxlength="20" placeholder="Enter phone number" value="<%= request.getParameter("phone")!=null?request.getParameter("phone"):"" %>"/>

            <label for="address">Address</label>
            <input type="text" id="address" name="address" maxlength="255" placeholder="Enter address" value="<%= request.getParameter("address")!=null?request.getParameter("address"):"" %>"/>

            <label for="role">Role *</label>
            <select id="role" name="role" required>
                <option value="">-- Select role --</option>
                <option value="Inventory Management" <%= "Inventory Management".equals(request.getParameter("role"))?"selected":"" %>>Inventory Management</option>
                <option value="Store Management" <%= "Store Management".equals(request.getParameter("role"))?"selected":"" %>>Store Management</option>
                <option value="Supplier Management" <%= "Supplier Management".equals(request.getParameter("role"))?"selected":"" %>>Supplier Management</option>
            </select>

            <label for="image">Image URL / Path</label>
            <input type="text" id="image" name="image" maxlength="255" placeholder="Enter image URL or path" value="<%= request.getParameter("image")!=null?request.getParameter("image"):"" %>"/>

            <button type="submit" class="btn-primary">Register</button>
        </form>
    </div>
</body>
</html>