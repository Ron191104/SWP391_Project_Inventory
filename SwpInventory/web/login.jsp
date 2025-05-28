<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>??ng nh?p qu?n lý kho</title>
    <style>
        /* Reset and base */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        /* Container */
        .container {
            max-width: 400px;
            margin: 100px auto;
            padding: 24px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 16px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        /* Form styles */
        form label {
            display: block;
            margin: 12px 0 6px;
            font-weight: 600;
            color: #333;
        }
        form input[type="text"],
        form input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 1rem;
            border-radius: 6px;
            border: 1.8px solid #ccc;
            transition: border-color 0.3s ease;
        }
        form input[type="text"]:focus,
        form input[type="password"]:focus {
            outline: none;
            border-color: #4caf50;
            box-shadow: 0 0 5px #4caf50aa;
        }
        form input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            border: none;
            color: white;
            background-color: #4caf50;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        form input[type="submit"]:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>??ng nh?p h? th?ng</h2>
        <form action="/login" method="post">
            <label for="username">Tài kho?n</label>
            <input type="text" id="username" name="username" required>
            <label for="password">M?t kh?u</label>
            <input type="password" id="password" name="password" required>
            <input type="submit" value="??ng nh?p">
        </form>
    </div>
</body>
</html>
