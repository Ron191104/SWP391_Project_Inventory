<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>User Registration</title>
    <style>
        /* Toàn bộ body: căn giữa, nền sáng */
        body {
            font-family: Arial, sans-serif;
            background: #eaf6ff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Container form: khung chính */
        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
            width: 350px;
        }

        /* Tiêu đề form */
        h2 {
            text-align: center;
            color: #0066cc;
            margin-bottom: 20px;
        }

        /* Nhãn */
        label {
            font-weight: bold;
            font-size: 14px;
        }

        /* Các ô input & select */
        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border: 1px solid #bbb;
            border-radius: 6px;
            font-size: 14px;
        }

        /* Nút submit */
        .btn-primary {
            width: 100%;
            padding: 12px;
            background: #0066cc;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        /* Hiệu ứng hover cho nút */
        .btn-primary:hover {
            background: #339cff;
        }

        /* Thông báo lỗi */
        .error-message {
            color: red;
            margin-bottom: 12px;
            text-align: center;
            font-size: 14px;
        }

        /* Hướng dẫn nhập mật khẩu */
        .password-guide {
            font-size: 12px;
            color: gray;
            margin: -8px 0 10px;
        }

        /* Input bị sai theo pattern (HTML5 validation) */
        input:invalid {
            border: 2px solid red;
        }

        /* Input hợp lệ */
        input:valid {
            border: 2px solid #bbb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="error-message"><%= error %></div>
        <% } %>

        <form id="registrationForm" action="register" method="POST" enctype="multipart/form-data" autocomplete="off">
            <label for="username">Username *</label>
            <input type="text" id="username" name="username" maxlength="50" required />

            <label for="password">Password *</label>
            <input
                type="password"
                id="password"
                name="password"
                maxlength="255"
                required
                pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*()\\-+=<>?]).{8,}$"
                title="Password must be at least 8 characters, include uppercase, lowercase, number and special character."
            />

            <!-- Hướng dẫn nhập mật khẩu -->
            <p class="password-guide">
                Must be at least 8 characters, including:
                1 uppercase, 1 lowercase, 1 number, and 1 special character.
            </p>

            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" maxlength="100" />

            <label for="email">Email</label>
            <input type="email" id="email" name="email" maxlength="100" />

            <label for="phone">Phone</label>
            <input type="tel" id="phone" name="phone" maxlength="20" />

            <label for="address">Address</label>
            <input type="text" id="address" name="address" maxlength="255" />

            <label for="role">Role *</label>
            <select id="role" name="role" required>
                <option value="">-- Select role --</option>
                <option value="Inventory Management">Inventory Management</option>
                <option value="Store Management">Store Management</option>
                <option value="Supplier Management">Supplier Management</option>
            </select>

            <label for="imageFile">Avatar (Upload image)</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/*" />

            <button type="submit" class="btn-primary">Register</button>
        </form>
    </div>
</body>
</html>
