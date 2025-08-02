<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Thống kê tồn kho</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #333; text-align: center; margin-bottom: 30px;}
        .controls {
            display: flex;
            flex-wrap: wrap; /* Cho phép các mục xuống dòng trên màn hình nhỏ */
            gap: 15px; /* Khoảng cách giữa các mục */
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            align-items: center; /* Căn giữa theo chiều dọc */
        }
        .controls input[type="text"], .controls select {
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 1rem;
            flex: 1; /* Cho phép các input/select co giãn */
            min-width: 150px; /* Đảm bảo kích thước tối thiểu */
        }
        .controls button {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.2s ease-in-out;
        }
        .controls button:hover {
            background-color: #0056b3;
        }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #007bff; color: white; cursor: pointer; position: relative; } /* Thêm cursor và position cho sắp xếp */
        th:hover { background-color: #0056b3; } /* Hiệu ứng hover cho header */
        th .sort-icon {
            margin-left: 5px;
            font-size: 0.8em;
        }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #ddd; }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #007bff;
            border-radius: 4px;
            text-decoration: none;
            color: #007bff;
            transition: background-color 0.2s, color 0.2s;
        }
        .pagination a:hover:not(.active) {
            background-color: #e9f5ff;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        .current-page-info {
            margin-top: 10px;
            text-align: center;
            font-style: italic;
            color: #555;
        }
        label {
            font-weight: bold;
            color: #333;
        }
    </style>
    <script>
        // Hàm gửi form khi sắp xếp
        function sortTable(sortBy) {
            let form = document.getElementById('filterForm');
            let currentSortBy = form.elements['sortBy'].value;
            let currentSortOrder = form.elements['sortOrder'].value;

            // Nếu nhấp vào cùng một cột, đảo ngược thứ tự
            if (sortBy === currentSortBy) {
                form.elements['sortOrder'].value = (currentSortOrder === 'asc' ? 'desc' : 'asc');
            } else {
                // Nếu nhấp vào cột khác, mặc định sắp xếp tăng dần
                form.elements['sortBy'].value = sortBy;
                form.elements['sortOrder'].value = 'asc';
            }
            form.elements['pageIndex'].value = 1; // Reset về trang 1 khi sắp xếp mới
            form.submit();
        }

        // Cập nhật biểu tượng sắp xếp
        document.addEventListener('DOMContentLoaded', function() {
            let sortBy = "${sortBy}";
            let sortOrder = "${sortOrder}";
            if (sortBy) {
                let header = document.getElementById('header-' + sortBy);
                if (header) {
                    let icon = document.createElement('span');
                    icon.classList.add('sort-icon');
                    icon.innerHTML = (sortOrder === 'asc' ? '&#9650;' : '&#9660;'); // Mũi tên lên/xuống
                    header.appendChild(icon);
                }
            }
        });

        // Hàm thay đổi page size (tùy chọn)
        function changePageSize() {
            let form = document.getElementById('filterForm');
            // Cập nhật giá trị page size nếu có input cho nó
            // form.elements['pageSize'].value = document.getElementById('pageSizeSelect').value;
            form.elements['pageIndex'].value = 1; // Reset về trang 1
            form.submit();
        }
    </script>
</head>
<body>
<%-- Sidebar --%>
    <jsp:include page="admin_sidebar.jsp" />
    <h1>Thống kê tồn kho toàn hệ thống</h1>

    <div class="controls">
        <form id="filterForm" action="store-inventory-statistics" method="get" style="display:contents;">
            <label for="searchKeyword">Tìm kiếm:</label>
            <input type="text" id="searchKeyword" name="searchKeyword" placeholder="Tên SP, Mã vạch..." value="${searchKeyword}">

            <label for="categoryId">Danh mục:</label>
            <select id="categoryId" name="categoryId" onchange="document.getElementById('filterForm').submit()">
                <option value="">Tất cả</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.categoryId}" ${cat.categoryId == selectedCategoryId ? 'selected' : ''}>
                        ${cat.categoryName}
                    </option>
                </c:forEach>
            </select>

            <label for="supplierId">Nhà cung cấp:</label>
            <select id="supplierId" name="supplierId" onchange="document.getElementById('filterForm').submit()">
                <option value="">Tất cả</option>
                <c:forEach var="sup" items="${suppliers}">
                    <option value="${sup.supplierId}" ${sup.supplierId == selectedSupplierId ? 'selected' : ''}>
                        ${sup.supplierName}
                    </option>
                </c:forEach>
            </select>

            <input type="hidden" name="sortBy" value="${sortBy}">
            <input type="hidden" name="sortOrder" value="${sortOrder}">
            <input type="hidden" name="pageIndex" value="${pageIndex}">
            <%-- <input type="hidden" name="pageSize" value="${pageSize}"> --%>

            <button type="submit">Lọc/Tìm kiếm</button>
            <button type="button" onclick="window.location.href='store-inventory-statistics'">Xóa bộ lọc</button>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th id="header-productName" onclick="sortTable('productName')">Tên sản phẩm</th>
                <th id="header-categoryName" onclick="sortTable('categoryName')">Danh mục</th>
                <th id="header-supplierName" onclick="sortTable('supplierName')">Nhà cung cấp</th>
                <th id="header-quantityMain" onclick="sortTable('quantityMain')">SL Kho Tổng</th>
                <th id="header-quantityCauGiay" onclick="sortTable('quantityCauGiay')">SL CN Cầu Giấy</th>
                <th id="header-quantityQuocOai" onclick="sortTable('quantityQuocOai')">SL CN Quốc Oai</th>
                <th id="header-totalQuantity" onclick="sortTable('totalQuantity')">Tổng Cộng</th>
                <th>Đơn vị</th>
                <th id="header-priceIn" onclick="sortTable('priceIn')">Giá nhập</th>
                <th id="header-priceOut" onclick="sortTable('priceOut')">Giá bán</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty inventoryList}">
                    <c:forEach var="item" items="${inventoryList}">
                        <tr>
                            <td>${item.productName}</td>
                            <td>${item.categoryName}</td>
                            <td>${item.supplierName}</td>
                            <td>${item.quantityMain}</td>
                            <td>${item.quantityCauGiay}</td>
                            <td>${item.quantityQuocOai}</td>
                            <td><b>${item.totalQuantity}</b></td>
                            <td>${item.unit}</td>
                            <td>
                                <fmt:setLocale value = "vi_VN"/>
                                <fmt:formatNumber value = "${item.priceIn}" type = "currency"/>
                            </td>
                            <td>
                                <fmt:setLocale value = "vi_VN"/>
                                <fmt:formatNumber value = "${item.priceOut}" type = "currency"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="10" style="text-align: center;">Không tìm thấy sản phẩm nào.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="current-page-info">
        Hiển thị ${(pageIndex - 1) * pageSize + 1} đến ${((pageIndex * pageSize) > totalRecords) ? totalRecords : (pageIndex * pageSize)} trong tổng số ${totalRecords} sản phẩm.
    </div>

    <div class="pagination">
        <c:if test="${pageIndex > 1}">
            <a href="store-inventory-statistics?searchKeyword=${searchKeyword}&categoryId=${selectedCategoryId}&supplierId=${selectedSupplierId}&sortBy=${sortBy}&sortOrder=${sortOrder}&pageIndex=1">Trang đầu</a>
            <a href="store-inventory-statistics?searchKeyword=${searchKeyword}&categoryId=${selectedCategoryId}&supplierId=${selectedSupplierId}&sortBy=${sortBy}&sortOrder=${sortOrder}&pageIndex=${pageIndex - 1}">Trang trước</a>
        </c:if>

        <c:forEach begin="${(pageIndex - 2 > 1) ? pageIndex - 2 : 1}"
                   end="${(pageIndex + 2 < totalPages) ? pageIndex + 2 : totalPages}" var="i">
            <c:url var="pageUrl" value="store-inventory-statistics">
                <c:param name="searchKeyword" value="${searchKeyword}"/>
                <c:param name="categoryId" value="${selectedCategoryId}"/>
                <c:param name="supplierId" value="${selectedSupplierId}"/>
                <c:param name="sortBy" value="${sortBy}"/>
                <c:param name="sortOrder" value="${sortOrder}"/>
                <c:param name="pageIndex" value="${i}"/>
            </c:url>
            <a href="${pageUrl}" class="${i == pageIndex ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${pageIndex < totalPages}">
            <a href="store-inventory-statistics?searchKeyword=${searchKeyword}&categoryId=${selectedCategoryId}&supplierId=${selectedSupplierId}&sortBy=${sortBy}&sortOrder=${sortOrder}&pageIndex=${pageIndex + 1}">Trang sau</a>
            <a href="store-inventory-statistics?searchKeyword=${searchKeyword}&categoryId=${selectedCategoryId}&supplierId=${selectedSupplierId}&sortBy=${sortBy}&sortOrder=${sortOrder}&pageIndex=${totalPages}">Trang cuối</a>
        </c:if>
    </div>
    <a href="AdminDashboardServlet" style="
    display: inline-block;
    margin-bottom: 20px;
    padding: 8px 16px;
    background-color: #007bff;
    color: white;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s;">
    ← Quay về trang chính
</a>

</body>
</html>