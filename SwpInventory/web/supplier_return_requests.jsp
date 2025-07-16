<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Yêu cầu trả hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #82CAFA;
            padding: 12px 24px;
            color: white;
        }
        .header h1 {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            padding: 24px;
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            color: #82CAFA;
            margin-bottom: 24px;
            font-size: 28px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #82CAFA;
            color: white;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-approve:hover {
            background-color: #218838;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-reject:hover {
            background-color: #c82333;
        }
        .status-label {
            font-weight: 600;
        }
        .no-data {
            text-align: center;
            font-style: italic;
            color: #888;
            background: #fefefe;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Nhà Cung Cấp</h1>
        <div class="nav">
            <a href="supplier_order"><i class="fas fa-box"></i> Đơn hàng</a>
            <a href="supplier_return_requests"><i class="fas fa-undo"></i> Trả hàng</a>
            <a href="supplier_logout.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        <h2>Danh sách yêu cầu trả hàng từ kho</h2>
<p>Supplier đang đăng nhập: ${sessionScope.supplier.supplierId}</p>

        <c:if test="${not empty returnRequests}">
            <table>
                <thead>
                    <tr>
                        <th>Mã yêu cầu</th>
                        <th>Ngày tạo</th>
                        <th>Lý do</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${returnRequests}">
                        <tr>
                            <td>${r.id}</td>
                            <td>${r.createdDate}</td>
                            <td>${r.reason}</td>
                            <td>
                                <span class="status-label">
                                    <c:choose>
                                        <c:when test="${r.status == 0}">Chờ duyệt</c:when>
                                        <c:when test="${r.status == 1}">Đã duyệt</c:when>
                                        <c:when test="${r.status == 2}">Từ chối</c:when>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <c:if test="${r.status == 0}">
                                    <form method="post" action="approve_return_request">
                                        <input type="hidden" name="requestId" value="${r.id}" />
                                        <button type="submit" name="action" value="approve" class="btn-approve">Duyệt</button>
                                        <button type="submit" name="action" value="reject" class="btn-reject">Từ chối</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty returnRequests}">
            <div class="no-data">Không có yêu cầu trả hàng nào.</div>
        </c:if>
    </div>
</body>
</html>
