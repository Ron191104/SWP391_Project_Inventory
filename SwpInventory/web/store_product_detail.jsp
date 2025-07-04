
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Chi tiết sản phẩm</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap');

            body {
                margin: 0;
                font-family:  "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5fafd;
                color: #222;
            }
            .container {
                max-width: 960px;
                margin: 30px auto;
                background: #fff;
                box-shadow: 0 6px 12px rgb(0 0 0 / 0.1);
                border-radius: 10px;
                padding: 24px 32px;
                position: relative;
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
                margin-bottom: 28px;
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


            h1.product-name {
                font-size: 2rem;
                font-weight: 700;
                color: #1470e2;
                margin-top: 0;
                margin-bottom: 20px;
                margin-top: 20px;


            }

            .product-detail {
                display: flex;
                gap: 32px;
                align-items: flex-start;
            }
            .product-image {
                max-width: 320px;
                padding-left: 30px;
                padding-top: 20px;
            }
            .product-image img {
                width: 100%;
                height: auto;

            }
            .product-info {
                flex: 0.9 0.5 0;
                padding-left: 50px;
                display: flex;
                flex-direction: column;
                gap: 12px;
            }
            .info-row {
                display: flex;
                justify-content: space-between;
                padding-bottom: 6px;
                border-bottom: 1px solid #e1eaea;
            }
            .info-label {
                font-weight: 600;
                color: #89D0F0;
                min-width: 130px;
                user-select: text;
            }
            .info-value {
                font-weight: 400;
                max-width: 400px;
                word-wrap: break-word;
                padding: 6px 10px;
                border: 1px solid #89D0F0;
                border-radius: 6px;
                background-color: white;
                color: #333;
                width: 280px;
                height: 20px;
            }

            .description {
                background-color: #eef9ff;
                border: 1px solid #89D0F0;
                border-radius: 8px;
                padding: 12px;
                font-size: 0.95rem;
                color: #305c7a;
                height: 100px;
                width: 100%;
                line-height: 1.4;
            }

            @media (max-width: 720px) {
                .product-detail {
                    flex-direction: column;
                }
                .product-image {
                    max-width: 100%;
                }
                .product-info {
                    max-width: 100%;
                }
                .info-row {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .info-label {
                    margin-bottom: 4px;
                }
            }
            .title{
                justify-content: center;
                display: flex;
                margin:  -20px;
            }
        </style>
    </head>
    <body>

        <div class="container" role="main" aria-label="Thông tin chi tiết sản phẩm">
            <a href="store_product_list" class="back-button">            
                <i class="fas fa-arrow-left "></i>
                Quay lại
            </a>


            <h1 class="title">Chi tiết sản phẩm</h1>

            <h1 class="product-name" tabindex="0">${detail.product.name}</h1>
            <div class="product-detail">
                <div class="product-image" role="img" aria-label="Ảnh sản phẩm">
                    <img src="assets/image/${detail.product.image}" alt="Ảnh sản phẩm" />
                </div>
                <div class="product-info">
                    <div class="info-row">
                        <div class="info-label">ID:</div>
                        <div class="info-value">${detail.product.id}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Barcode:</div>
                        <div class="info-value">${detail.product.barcode}</div>
                    </div>
                    <c:forEach items="${listStoreCategory}" var="c">
                        <c:if test="${c.id == detail.product.category_id}">
                            <div class="info-row">
                                <div class="info-label">Category :</div> 
                                <div class="info-value">${c.name}</div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <div class="info-row">
                        <div class="info-label">Price In:</div>
                        <div class="info-value">${detail.product.price}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Price Out:</div>
                        <div class="info-value">${detail.priceOut}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Quantity:</div>
                        <div class="info-value">${detail.quantity}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Unit:</div>
                        <div class="info-value">${detail.product.unit}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Manufacture Date:</div>
                        <div class="info-value">${detail.product.manufacture_date}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Expired Date:</div>
                        <div class="info-value">${detail.product.expired_date}</div>
                    </div>
                    <div class="info-row" style="flex-direction: column; border-bottom: none;">
                        <div class="info-label" style="margin-bottom: 6px;">Description:</div>
                        <div class="info-value description">
                            ${detail.product.description}
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </body>
</html>

