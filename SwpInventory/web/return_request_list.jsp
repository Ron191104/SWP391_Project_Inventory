<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách yêu cầu trả hàng</title>
        <link rel="stylesheet" href="assets/css/filter-icon.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 800px;
                margin: 32px auto;
                padding: 24px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 16px rgba(0,0,0,0.1);
                text-align: center;
            }
            .return-card {
                border: 2px solid #82CAFA;
                border-radius: 12px;
                margin: 20px auto;
                max-width: 600px;
                background-color: #f9fcff;
                padding: 20px;
                position: relative;
                transition: transform 0.2s ease;
            }
            .return-card h3 {
                color: #0b5ed7;
            }
            .return-card p {
                margin: 4px 0;
            }
            .status {
                font-weight: bold;
            }
            .status-0 {
                color: gray;
            }
            .status-1 {
                color: green;
            }
            .status-2 {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Danh sách đơn hoàn trả đã gửi đi</h2>

            <c:if test="${empty returnList}">
                <p>Chưa có yêu cầu trả hàng nào.</p>
            </c:if>

            <c:forEach var="rr" items="${returnList}">
                <div class="return-card">
                    <h3>Yêu cầu hoàn #${rr.id}</h3>
                    <p><strong>Nhà cung cấp:</strong> ${rr.supplierName}</p>
                    <p><strong>Ngày tạo:</strong> ${rr.createdDate}</p>
                    <p><strong>Nhân viên gửi:</strong> ${rr.employeeName}</p>
                    <p><strong>Lý do:</strong> ${rr.reason}</p>
                    <c:if test="${not empty rr.note}">
                        <p><strong>Ghi chú:</strong> ${rr.note}</p>
                    </c:if>
                    <p><strong>Trạng thái:</strong>
                        <span class="status status-${rr.status}">
                            <c:choose>
                                <c:when test="${rr.status == 0}">Chờ duyệt</c:when>
                                <c:when test="${rr.status == 1}">Đã duyệt</c:when>
                                <c:when test="${rr.status == 2}">Từ chối</c:when>
                                <c:otherwise>Không rõ</c:otherwise>
                            </c:choose>
                        </span>
                    </p>
                    <a href="return_details?returnId=${rr.id}">Xem chi tiết</a>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
