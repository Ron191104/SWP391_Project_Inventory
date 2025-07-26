<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Chi tiết sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f8ff; /* Nền xanh nhạt */
                margin: 0;
                padding: 0;
            }

            .container[role="main"] {
                max-width: 800px;
                margin: 40px auto;
                background: #ffffff;
                padding: 20px 30px;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }

            .back-button {
                background-color: #82CAFA;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                font-size: 14px;
                padding: 8px 14px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 10px;
                width: fit-content;
            }
            .back-button:hover {
                background-color: #787FF6;
                text-decoration: none;
                color: white;
            }

            .back-button i {
                margin-right: 6px;
            }


            h3 {
                font-size: 1.5rem;
                color: #82CAFA;
                text-align: center;
                margin-bottom: 20px;
            }

            form label {
                display: block;
                font-weight: bold;
                margin-bottom: 8px;
                color: #555;
            }

            form input,
            form select {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #82CAFA;
                border-radius: 8px;
                font-size: 1rem;
                box-sizing: border-box;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            form input:focus,
            form select:focus {
                border-color: #5bb5e6;
                box-shadow: 0 0 8px rgba(130, 202, 250, 0.8);
                outline: none;
            }

            .product-select {
                font-size: 1rem;
                padding: 12px;
            }

            .form-actions {
                display: flex;
                justify-content: flex-start;
                gap: 10px;
            }

            .form-actions input[type="submit"],
            .form-actions button {
                padding: 10px 20px;
                font-size: 1rem;
                border: none;
                border-radius: 8px;
                color: #ffffff;
                background-color: #82CAFA;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .form-actions input[type="submit"]:hover,
            .form-actions button:hover {
                background-color: #5bb5e6;
            }

            .form-actions button {
                background-color: #adb5bd;
            }

            .form-actions button:hover {
                background-color: #868e96;
            }

        </style>
    </head>
    <body>
        <div class="container" role="main" aria-label="Thông tin chi tiết sản phẩm">
            <a href="store_product_list" class="back-button">            
                <i class="fas fa-arrow-left "></i>
                Quay lại
            </a>

            <h3>Sửa sản phẩm:</h3>

            <div class="container">
                <form action="edit_product" method="post" enctype="multipart/form-data">
                    <label>ID</label>
                    <input type="text" name="productId" value="${detail.product.id}" readonly>

                    <label>Barcode</label>
                    <input type="text" name="barcode" value="${detail.product.barcode}" readonly>

                    <label>Product Name</label>
                    <input type="text" name="name" value="${detail.product.name}" required>

                    <label>Category</label>
                    <select name="storeCategoryId" required>
                        <c:forEach var="c" items="${listStoreCategory}">
                            <option value="${c.id}" <c:if test="${c.id == detail.storeCategoryId}">selected</c:if>>${c.name}</option>
                        </c:forEach>
                    </select>

                    <label>Price In</label>
                    <input type="number" name="priceIn" value="${detail.product.price}" readonly>

                    <label>Price Out</label>
                    <input type="number" name="priceOut" value="${detail.priceOut}" readonly>

                    <label>Quantity</label>
                    <input type="number" name="quantity" value="${detail.quantity}" readonly>

                    <label>Unit</label>
                    <input type="text" name="unit" value="${detail.product.unit}" readonly>

                    <label>Manufactured Date</label>
                    <input type="text" name="manufacture_date" value="${detail.product.manufacture_date}" readonly>

                    <label>Expired Date</label>
                    <input type="text" name="expired_date" value="${detail.product.expired_date}" readonly>

                    <label>Description</label>
                    <input type="text" name="description" value="${detail.product.description}" required>

                    <label>Upload New Image</label>
                    <input type="file" name="image" accept="image/*">

                    <input type="hidden" name="oldImage" value="${detail.product.image}">
                    <input type="hidden" name="storeProductId" value="${detail.storeProductId}">

                    <input type="submit" value="Save">
                    <a href="store_product_list"><button type="button">Cancel</button></a>
                </form>

            </div>

        </div>
    </body>
</html>
