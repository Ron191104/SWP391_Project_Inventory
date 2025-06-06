<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
          <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Thêm Sản Phẩm</title>
  <style>
      
    body {
      background-color: #82CAFA;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
      margin: 0;
      padding: 20px;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    h1 {
      color:  #82CAFA;
      text-align: center;
      margin-bottom: 20px;
    }
    form {
      background: #fff;
      padding: 20px 25px;
      border-radius: 8px;
      max-width: 480px;
      width: 100%;
      box-sizing: border-box;
    }
    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 600;
      color: #82CAFA;
      font-size: 0.9rem;
    }
    input[type="text"],
    input[type="number"],
    input[type="date"],
    textarea,
    select {
      width: 100%;
      padding: 8px 10px;
      margin-bottom: 16px;
      border:  1.5px solid #ccc;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s ease;
      box-sizing: border-box;
    }
    input[type="text"]:focus,
    input[type="number"]:focus,
    input[type="date"]:focus,
    textarea:focus,
    select:focus {
      border-color: #82CAFA;
      outline: none;
      box-shadow: 0 0 5px #82CAFA;
    }
    textarea {
      resize: vertical;
      min-height: 70px;
    }
    button {
      background-color: #82CAFA;
      border: none;
      padding: 12px 16px;
      color: white;
      font-size: 1rem;
      font-weight: 600;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      letter-spacing: 0.05em;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #787FF6;
    }
  </style>
</head>
<body>
  <form action="#" method="post" novalidate>
    <h1>Thêm Sản Phẩm</h1>

    <label for="name">Tên sản phẩm</label>
    <input type="text" id="name" name="name" required />

    <label for="barcode">Barcode</label>
    <input type="text" id="barcode" name="barcode" required />

    <label for="category_id">Mã danh mục</label>
    <input type="text" id="category_id" name="category_id" required />

    <label for="supplier_id">Mã nhà cung cấp</label>
    <input type="text" id="supplier_id" name="supplier_id" required />

    <label for="price_in">Giá nhập</label>
    <input type="number" id="price_in" name="price_in" step="0.01" min="0" required />

    <label for="price_out">Giá bán</label>
    <input type="number" id="price_out" name="price_out" step="0.01" min="0" required />

    <label for="quantity">Số lượng</label>
    <input type="number" id="quantity" name="quantity" min="0" required />

    <label for="unit">Đơn vị tính</label>
    <input type="text" id="unit" name="unit" required />

    <label for="mfd">Ngày sản xuất</label>
    <input type="date" id="mfd" name="mfd" required />

    <label for="exp">Ngày hết hạn</label>
    <input type="date" id="exp" name="exp" required />

    <label for="image">Ảnh (URL hoặc tên file)</label>
    <input type="text" id="image" name="image" />

    <label for="description">Mô tả</label>
    <textarea id="description" name="description" rows="4"></textarea>

    <button type="submit">Thêm sản phẩm</button>
  </form>
</body>
</html>

