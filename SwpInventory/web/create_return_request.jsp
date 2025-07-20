<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Tạo yêu cầu trả hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 850px;
                margin: 40px auto;
                background: white;
                padding: 32px;
                border-radius: 10px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            label {
                font-weight: bold;
                display: block;
                margin-top: 16px;
            }

            input[type="text"], select, input[type="number"] {
                width: 100%;
                padding: 10px;
                margin-top: 6px;
                border-radius: 6px;
                border: 1.5px solid #ccc;
            }

            input[type="submit"], .view-btn {
                display: inline-block;
                margin-top: 24px;
                background-color: #82CAFA;
                color: white;
                padding: 12px 30px;
                border: none;
                font-size: 1.1rem;
                font-weight: bold;
                border-radius: 6px;
                cursor: pointer;
                text-decoration: none;
                margin-right: 12px;
            }

            input[type="submit"]:hover, .view-btn:hover {
                background-color: #21a5fc;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                text-align: center;
                padding: 10px;
            }

            th {
                background-color: #82CAFA;
                color: white;
            }

            .add-btn {
                background: #21a5fc;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
            }

            .add-btn:hover {
                background: #007bff;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2><i class="fas fa-undo-alt"></i> Tạo yêu cầu trả hàng</h2>

            <c:if test="${not empty sessionScope.successMessage}">
                <p style="color: green">${sessionScope.successMessage}</p>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <p style="color: red">${sessionScope.errorMessage}</p>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <form action="create_return_request" method="post">
                <label for="supplierId">Nhà cung cấp:</label>
                <select name="supplierId" id="supplierId" required onchange="this.form.submit()">
                    <option value="" disabled ${empty selectedSupplierId ? 'selected' : ''}>Chọn nhà cung cấp</option>
                    <c:forEach var="s" items="${listSuppliers}">
                        <option value="${s.supplierId}" ${s.supplierId == selectedSupplierId ? 'selected' : ''}>${s.supplierName}</option>
                    </c:forEach>
                </select>

                <c:if test="${not empty selectedSupplierId}">
                    <label for="reason">Lý do trả hàng:</label>
                    <input type="text" name="reason" placeholder="Nhập lý do trả hàng..." required>

                    <label for="note">Ghi chú:</label>
                    <input type="text" name="note" placeholder="Ghi chú thêm (nếu có)">

                    <table id="productTable">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Số lượng trả</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select name="productId" required>
                                        <option value="" disabled selected>Chọn sản phẩm</option>
                                        <c:forEach var="p" items="${productList}">
                                            <option value="${p.id}">${p.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input type="number" name="quantity" min="1" value="1" required></td>
                                <td><button type="button" class="add-btn" onclick="addRow()">+</button></td>
                            </tr>
                        </tbody>
                    </table>

                    <div style="text-align: center;">
                        <input type="submit" value="Gửi yêu cầu trả hàng">
                        <a href="return_requests" class="view-btn">Xem yêu cầu đã gửi</a>
                    </div>
                </c:if>
            </form>
        </div>

        <script>
            function addRow() {
                const table = document.getElementById("productTable").getElementsByTagName("tbody")[0];
                const newRow = table.rows[0].cloneNode(true);

                newRow.querySelector("select").selectedIndex = 0;
                newRow.querySelector("input[type='number']").value = 1;

                table.appendChild(newRow);
            }
        </script>

    </body>
</html>
