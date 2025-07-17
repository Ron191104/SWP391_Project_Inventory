<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.StoreInventory" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê tồn kho từng chi nhánh</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .branch-header {
            background: #007BFF;
            color: white;
            font-weight: bold;
            font-size: 18px;
            padding: 10px;
            margin-top: 40px;
            border-radius: 5px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 30px;
            margin-top: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            border-radius: 6px;
            overflow: hidden;
            background-color: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <h2>Thống kê tồn kho từng chi nhánh</h2>
    <%
        List<StoreInventory> inventoryList = (List<StoreInventory>) request.getAttribute("inventoryList");
        String currentStore = "";
        if (inventoryList != null && !inventoryList.isEmpty()) {
            for (StoreInventory item : inventoryList) {
                if (!item.getStoreName().equals(currentStore)) {
                    if (!currentStore.equals("")) {
    %>
                        </table>
    <%
                    }
                    currentStore = item.getStoreName();
    %>
                    <div class="branch-header">Chi nhánh: <%= currentStore %></div>
                    <table>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Nhà cung cấp</th>
                            <th>Số lượng tồn</th>
                            <th>Đơn vị</th>
                            <th>Giá nhập</th>
                            <th>Giá bán</th>
                        </tr>
    <%
                }
    %>
                <tr>
                    <td><%= item.getProductName() %></td>
                    <td><%= item.getCategoryName() %></td>
                    <td><%= item.getSupplierName() %></td>
                    <td><%= item.getStockQuantity() %></td>
                    <td><%= item.getUnit() %></td>
                    <td><%= item.getPrice() %></td>
                    <td><%= item.getPriceOut() %></td>
                </tr>
    <%
            }
        }
    %>
    </table>
</body>
</html>