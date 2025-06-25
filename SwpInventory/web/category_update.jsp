<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Category</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            .header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background-color: #82CAFA;
                color: white;
                padding: 12px 24px;
                position: relative;
                height: 44px;
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .header-left h1 {
                margin: 0;
                font-size: 1.8rem;
                font-weight: 700;
            }

            .nav {
                display: flex;
                gap: 12px;
                margin-left: 40px;
                position: relative;
            }

            .nav a {
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: 600;
                transition: background-color 0.3s ease;
                white-space: nowrap;
                display: flex;
                align-items: center;
            }

            .nav a i {
                margin-right: 8px;
                min-width: 16px;
                text-align: center;
            }

            .nav a:hover,
            .nav a.active {
                background-color: #787ff6;
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .notification-wrapper {
                position: relative;
                cursor: pointer;
                color: white;
            }

            .notification-icon {
                width: 24px;
                height: 24px;
                fill: currentColor;
                transition: color 0.3s ease;
            }

            .notification-wrapper:hover,
            .notification-wrapper:focus-within {
                color: #FDF9DA;
            }

            .notification-badge {
                position: absolute;
                top: -4px;
                right: -4px;
                background-color: #e53935;
                color: white;
                font-size: 0.7rem;
                font-weight: 700;
                border-radius: 50%;
                padding: 2px 6px;
                user-select: none;
                line-height: 1;
            }

            .user-menu {
                position: relative;
                user-select: none;
            }

            .user-menu input[type="checkbox"] {
                display: none;
            }

            .user-menu label {
                cursor: pointer;
                display: flex;
                align-items: center;
                border: 2px solid white;
                border-radius: 50%;
                overflow: hidden;
                width: 40px;
                height: 40px;
                transition: border-color 0.3s ease;
            }

            .user-menu label img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .user-menu nav.dropdown-menu {
                position: absolute;
                top: 50px;
                left: -50%;
                transform: translateX(-50%);
                background: white;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                min-width: 180px;
                flex-direction: column;
                overflow: hidden;
                display: none;
                z-index: 1000;
            }
            form {
                margin-top: 70px;
            }

            .user-menu input[type="checkbox"]:checked + label + nav.dropdown-menu {
                display: flex;
            }

            .user-menu nav.dropdown-menu a {
                padding: 12px 16px;
                border-bottom: 1px solid #eee;
                font-weight: 600;
                white-space: nowrap;
            }

            .user-menu nav.dropdown-menu a:last-child {
                border-bottom: none;
                color: #e53935;
            }

            .user-menu nav.dropdown-menu a:hover {
                background-color: #FDF9DA;
            }

            @media (max-width: 600px) {
                .header {
                    flex-wrap: wrap;
                    gap: 10px;
                    padding: 12px 12px;
                }
                .nav {
                    margin-left: 0;
                    flex-wrap: wrap;
                    justify-content: center;
                    gap: 6px;
                }
                .header-right {
                    flex-basis: 100%;
                    justify-content: center;
                    gap: 12px;
                }
            }

            .form-container {
                background-color: white;
                border: 1px solid #ddd;
                padding: 20px;
                border-radius: 8px;
                width: 100%;
                max-width: 400px;
                margin: 50px auto;
                height: 300px;
            }

            h2 {
                margin-top: 0;
                color: #82CAFA;
                text-align: center;
                font-size: 28px;
                margin-bottom: 24px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #555;
            }

            input[type="text"] {
                width: 95%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-shadow: none;
                outline: none;
            }

            input[type="submit"] {
                background-color: #82CAFA;
                color: white;
                padding: 12px 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
            }

            input[type="submit"]:hover {
                background-color: #787FF6;
            }

            .form-value {
                padding: 10px;
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 6px;
                margin-bottom: 15px;
                color: #333;
                width: 95%;
            }

        </style>
    </head>
    <body>

        <div class="header">
            <div class="header-left">
                <h1>Tên kho</h1>
                <div class="nav">
                    <a href="dashboard.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    <a href="product_list"><i class="fas fa-box"></i> Sản phẩm</a>
                    <a href="import_goods.html"><i class="fas fa-truck-loading"></i> Nhập kho</a>
                    <a href="export_goods.html"><i class="fas fa-truck"></i> Xuất kho</a>
                    <a href="stats.html"><i class="fas fa-chart-bar"></i> Thống kê</a>
                </div>
            </div>
            <div class="header-right">
                <div class="notification-wrapper" tabindex="0">
                    <svg class="notification-icon" viewBox="0 0 24 24">
                    <path d="M12 22c1.1 0 1.99-.9 1.99-2H10c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 00-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1.99 2H20l-2-2z"/>
                    </svg>
                    <span class="notification-badge">3</span>
                </div>
                <div class="user-menu">
                    <input type="checkbox" id="user-menu-toggle" />
                    <label for="user-menu-toggle">
                        <img src="https://i.pravatar.cc/40" alt="User" />
                    </label>
                    <nav class="dropdown-menu">
                        <a href="myprofile.html">My Profile</a>
                        <a href="change_password.html">Change Password</a>
                        <a href="login.html">Log Out</a>
                    </nav>
                </div>
            </div>
        </div>

        <div class="form-container">
            <h2>Update Category</h2>
            <form action="updatecategory" >

                <div class="form-group">
                    <label for="name">ID:</label>
                    <input type="text" id="id" name="id"value="${detail.id}" required>
                </div>
                <div class="form-group">
                    <label for="name">Category Name:</label>
                    <input type="text" id="name" name="name" value="${detail.name}"required>
                </div>

                <input type="submit" value="Cập nhật"/>
            </form>
        </div>



    </body>
</html>
