<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ReturnRequest" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="assets/css/filter-icon.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách yêu cầu hoàn hàng</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .container {
                max-width: 850px;
                margin: 40px auto;
                background: white;
                padding: 32px;
                border-radius: 10px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
                width: 100%;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            .request-card {
                border: 2px solid #82CAFA;
                border-radius: 12px;
                margin: 20px auto;
                max-width: 600px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                background-color: #f9fcff;
                font-family: 'Segoe UI', sans-serif;
                padding: 20px;
                transition: transform 0.2s ease;
            }

            .request-card:hover {
                transform: scale(1.02);
            }

            .request-card h3 {
                color: #0b5ed7;
            }

            .request-card p {
                margin: 8px 0;
            }

            .request-card .status {
                font-weight: 600;
            }

            .btn-action {
                background-color: #82CAFA;
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 1rem;
                cursor: pointer;
                display: inline-block;
                margin-right: 10px;
            }

            .btn-action:hover {
                background-color: #21a5fc;
            }

            .btn-cancel {
                background-color: #ff4d4d;
                color: white;
            }

            .btn-cancel:hover {
                background-color: #c82333;
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
        <div class="container">
            <h2>Danh sách yêu cầu trả hàng</h2>

            <c:if test="${empty returnList}">
                <div class="no-data">Chưa có yêu cầu trả hàng nào.</div>
            </c:if>

            <c:forEach var="r" items="${returnList}">
                <a href="return_request_details?returnId=${r.id}" style="text-decoration: none; color: inherit;">
                    <div class="request-card">
                        <h3>Yêu cầu trả hàng #${r.id}</h3>
                        <p><strong>Nhà cung cấp:</strong> ${r.supplierName}</p>
                        <p><strong>Ngày tạo:</strong> ${r.createdDate}</p>
                        <p><strong>Lý do:</strong> ${r.reason}</p>
                        <p><b>Trạng thái:</b>
                            <c:choose>
                                <c:when test="${r.status == 0}">⏳ Chờ duyệt</c:when>
                                <c:when test="${r.status == 1}">✔ Đã duyệt</c:when>
                                <c:when test="${r.status == 2}">✖ Từ chối</c:when>
                                <c:when test="${r.status == 3}">🗑 Đã hủy</c:when>
                            </c:choose>
                        </p>

                        <div class="btn-action-container">
                            <a href="return_request_details?returnId=${r.id}" class="btn-action">Xem chi tiết</a>

                            <c:if test="${r.status == 0}">
                                <form method="post" action="cancel_return_request" style="display:inline;">
                                    <input type="hidden" name="returnId" value="${r.id}" />
                                    <button type="submit" onclick="return confirm('Bạn có chắc muốn hủy đơn này không?');"
                                            style="background:#dc3545;color:white;border:none;padding:6px 12px;border-radius:4px;cursor:pointer;">
                                        <i class="fas fa-times"></i> Hủy đơn
                                    </button>
                                </form>
                            </c:if>

                        </div>
                    </div>
                </a>
            </c:forEach>

        </div>
    </body>
</html>
