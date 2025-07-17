<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Chọn chi nhánh</title>
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background-color: #FDF9DA;
                text-align: center;
                padding: 120px;
            }

            h2 {
                color: #333;
                margin-bottom: 30px;
            }

            form {
                display: inline-block;
            }

            button {
                background-color: #82CAFA;
                color: white;
                padding: 15px 30px;
                margin: 10px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
            }

            button:hover {
                background-color: #787FF6;
            }


        </style>
    </head>
    <body>
        <h2>Chọn chi nhánh cửa hàng</h2>

        <c:forEach var="store" items="${listStore}">
            <form action="set_store" method="get" style="margin-bottom:10px">
                <button type="submit" name="storeId" value="${store.storeId}">
                    Chi nhánh ${store.storeId} - ${store.storeName}
                </button>
            </form>
        </c:forEach>

    </body>
</html>
