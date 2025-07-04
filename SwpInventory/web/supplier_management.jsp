<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý nhà cung cấp</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background: linear-gradient(120deg, #fff6f6 0%, #ffe5e5 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .container {
            max-width: 850px;
            margin: 40px auto 0 auto;
            padding: 32px 24px 24px 24px;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(229,57,53,0.10), 0 1.5px 6px rgba(229,57,53,0.05);
        }

        h2 {
            text-align: center;
            color: #e53935;
            margin-bottom: 32px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .form-title {
            font-size: 20px;
            color: #c62828;
            margin-bottom: 12px;
            font-weight: 600;
        }

        form.main-form {
            background: linear-gradient(90deg, #fff9f9 70%, #ffeaea 100%);
            padding: 20px 28px 16px 28px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(229,57,53,0.09);
            max-width: 600px;
            margin: 0 auto 30px auto;
            display: flex;
            flex-wrap: wrap;
            gap: 12px 2%;
            justify-content: space-between;
        }

        .main-form input[type="text"],
        .main-form input[type="email"] {
            flex: 1 1 48%;
            min-width: 120px;
            padding: 10px 12px;
            margin-bottom: 0;
            border: 1.5px solid #ffcdd2;
            border-radius: 5px;
            background: #fff;
            font-size: 15px;
            transition: border 0.2s;
        }

        .main-form input:focus {
            border: 1.5px solid #e57373;
            outline: none;
        }

        .main-form button {
            flex: 1 1 100%;
            padding: 10px 0;
            background: linear-gradient(90deg, #e53935 60%, #ff7043 100%);
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            box-shadow: 0 1px 5px rgba(229,57,53,0.08);
            cursor: pointer;
            transition: background 0.27s;
        }

        .main-form button:hover {
            background: linear-gradient(90deg, #c62828 70%, #ffa726 100%);
        }

        table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            margin-top: 12px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 3px 20px rgba(229,57,53,0.10);
            overflow: hidden;
        }

        th, td {
            padding: 13px 10px;
            text-align: center;
        }

        th {
            background: linear-gradient(90deg, #e53935 70%, #ff7043 100%);
            color: #fff;
            font-weight: 600;
            font-size: 15.5px;
            border: none;
        }

        tr {
            transition: background 0.25s;
        }
        tr:nth-child(even) td {
            background: #fff5f5;
        }
        tr:hover td {
            background: #ffebee;
        }

        td {
            font-size: 15px;
            border-bottom: 1px solid #f6bdbd;
        }

        td form.inline input[type="text"], 
        td form.inline input[type="email"] {
            width: 90px;
            font-size: 14px;
            padding: 6px 8px;
            border: 1.2px solid #e0e0e0;
            border-radius: 4px;
            margin: 0 2px 0 0;
        }

        td form.inline button {
            padding: 5px 14px;
            background: #ff7043;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.22s;
            margin-top: 2px;
        }

        td form.inline button:hover {
            background: #e53935;
        }

        .action-cell form.inline button {
            padding: 5px 13px;
            background: #e57373;
        }
        .action-cell form.inline button:hover {
            background: #c62828;
        }

        a.back-link {
            display: inline-block;
            margin-top: 28px;
            margin-left: 8px;
            color: #e53935;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            border-bottom: 2px solid #ffe5e5;
            border-radius: 3px;
            transition: color 0.2s, border 0.2s;
        }
        a.back-link:hover {
            color: #b71c1c;
            border-bottom: 2px solid #e57373;
            text-decoration: none;
        }

        @media (max-width: 900px) {
            .container {
                max-width: 99vw;
                padding: 16px 3vw;
            }
            .main-form {
                flex-direction: column;
                gap: 10px 0;
                padding: 18px 8px;
            }
            .main-form input, .main-form button {
                flex: 1 1 100%;
                width: 100%;
            }
            th, td {
                font-size: 14px;
                padding: 10px 4px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quản lý nhà cung cấp</h2>
        <div class="form-title">Thêm nhà cung cấp mới</div>
        <form class="main-form" method="post" action="suppliers">
            <input type="hidden" name="action" value="add"/>
            <input type="text" name="supplier_name" placeholder="Tên nhà cung cấp" required autocomplete="off" />
            <input type="text" name="phone" placeholder="Số điện thoại" autocomplete="off" />
            <input type="text" name="email" placeholder="Email" autocomplete="off" />
            <input type="text" name="address" placeholder="Địa chỉ" autocomplete="off" />
            <button type="submit">Thêm</button>
        </form>
        <table>
            <tr>
                <th>ID</th>
                <th>Tên & Sửa</th>
                <th>Điện thoại</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="s" items="${suppliers}">
                <tr>
                    <td>${s.supplierId}</td>
                    <td>
                        <form class="inline" method="post" action="suppliers">
                            <input type="hidden" name="action" value="update"/>
                            <input type="hidden" name="supplier_id" value="${s.supplierId}"/>
                            <input type="text" name="supplier_name" value="${s.supplierName}" required autocomplete="off"/>
                            <input type="text" name="phone" value="${s.phone}" autocomplete="off"/>
                            <input type="text" name="email" value="${s.email}" autocomplete="off"/>
                            <input type="text" name="address" value="${s.address}" autocomplete="off"/>
                            <button type="submit">Sửa</button>
                        </form>
                    </td>
                    <td>${s.phone}</td>
                    <td>${s.email}</td>
                    <td>${s.address}</td>
                    <td class="action-cell">
                        <form class="inline" method="post" action="suppliers" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="supplier_id" value="${s.supplierId}"/>
                            <button type="submit">Xóa</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <a class="back-link" href="user-management">&larr; Quay lại danh sách</a>
    </div>
</body>
</html>