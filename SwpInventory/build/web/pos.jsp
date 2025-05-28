<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Nh?p kho - Qu?n lý kho</title>
    <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1" name="viewport"/>
  <title>
   Product Selection
  </title>
  <script src="https://cdn.tailwindcss.com">
  </script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <style>
        /* Reset and base */
        /* Custom scrollbar for the right product list */
    .scrollbar-thin::-webkit-scrollbar {
      width: 6px;
    }
    .scrollbar-thin::-webkit-scrollbar-thumb {
      background-color: #f97316; /* orange-500 */
      border-radius: 9999px;
    }
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
        a {
            text-decoration: none;
            color: inherit;
        }
        /* Header */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #4caf50;
            color: white;
            padding: 12px 24px;
            position: relative;
        }
        .header-left {
            display: flex;
            align-items: center;
        }
        .header-left h1 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 700;
        }
        /* Navigation */
        .nav {
            display: flex;
            gap: 12px;
            margin-left: 40px;
        }
        .nav a {
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            white-space: nowrap;
        }
        .nav a:hover,
        .nav a.active {
            background-color: #388e3c;
        }

        /* Header right - search, notifications, user */
        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        /* Search */
        .search-box {
            position: relative;
        }
        .search-box input[type="search"] {
            padding: 6px 28px 6px 12px;
            border-radius: 20px;
            border: none;
            outline: none;
            font-size: 0.9rem;
            width: 180px;
            transition: width 0.3s ease;
        }
        .search-box input[type="search"]:focus {
            width: 240px;
        }
        .search-box svg {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            fill: #4caf50;
            pointer-events: none;
            width: 16px;
            height: 16px;
        }
        /* Notification */
        .notification-wrapper {
            position: relative;
            cursor: pointer;
            color: white;
        }
        .notification-icon {
            width: 24px;
            height: 24px;
            fill: currentColor;
            transition: color 0.3s ease;
        }
        .notification-wrapper:hover, .notification-wrapper:focus-within {
            color: #c8e6c9;
        }
        .notification-badge {
            position: absolute;
            top: -4px;
            right: -4px;
            background-color: #e53935;
            color: white;
            font-size: 0.7rem;
            font-weight: 700;
            border-radius: 50%;
            padding: 2px 6px;
            user-select: none;
            line-height: 1;
        }
        /* Notification dropdown */
        .notification-dropdown {
            position: absolute;
            top: 34px;
            right: 0;
            background: white;
            color: #333;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            min-width: 240px;
            max-height: 250px;
            overflow-y: auto;
            display: none;
            flex-direction: column;
            padding: 10px 0;
            z-index: 1000;
        }
        /* Show notification dropdown on focus-within or hover */
        .notification-wrapper:hover .notification-dropdown,
        .notification-wrapper:focus-within .notification-dropdown {
            display: flex;
        }
        .notification-dropdown div {
            padding: 8px 16px;
            border-bottom: 1px solid #eee;
            font-size: 0.9rem;
        }
        .notification-dropdown div:last-child {
            border-bottom: none;
        }
        /* User avatar & dropdown - pure CSS toggle */
        .user-menu {
            position: relative;
            user-select: none;
        }
        /* Hidden checkbox to toggle dropdown */
        .user-menu input[type="checkbox"] {
            display: none;
        }
        /* Avatar style */
        .user-menu label {
            cursor: pointer;
            display: flex;
            align-items: center;
            border: 2px solid white;
            border-radius: 50%;
            overflow: hidden;
            width: 40px;
            height: 40px;
            transition: border-color 0.3s ease;
        }
        .user-menu label img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        /* Change border on hover or focus */
        .user-menu label:hover,
        .user-menu label:focus {
            border-color: #c8e6c9;
            outline: none;
        }
        /* Dropdown menu */
        .user-menu nav.dropdown-menu {
            position: absolute;
            top: 50px;
            right: 0;
            background: white;
            color: #333;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            min-width: 180px;
            flex-direction: column;
            overflow: hidden;
            display: none;
            z-index: 1000;
        }
        /* Show dropdown when checkbox is checked */
        .user-menu input[type="checkbox"]:checked + label + nav.dropdown-menu {
            display: flex;
        }
        .user-menu nav.dropdown-menu a {
            padding: 12px 16px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            white-space: nowrap;
        }
        .user-menu nav.dropdown-menu a:last-child {
            border-bottom: none;
            color: #e53935;
        }
        .user-menu nav.dropdown-menu a:hover {
            background-color: #f0f0f0;
        }
        /* Container */
        .container {
            max-width: 800px;
            margin: 32px auto;
            padding: 24px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 16px rgba(0,0,0,0.1);
        }
        /* Form */
        form label {
            display: block;
            margin: 12px 0 6px;
            font-weight: 600;
            color: #333;
        }
        form input[type="number"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 1rem;
            border-radius: 6px;
            border: 1.8px solid #ccc;
            transition: border-color 0.3s ease;
        }
        form input[type="number"]:focus {
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
        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 28px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px 10px;
            text-align: left;
        }
        th {
            background-color: #4caf50;
            color: white;
            font-weight: 700;
        }
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tbody tr:hover {
            background-color: #e2f0d9;
        }
        /* Responsive */
        @media (max-width: 600px) {
            .header {
                flex-wrap: wrap;
                gap: 10px;
                padding: 12px 12px;
            }
            .header-left {
                flex-basis: 100%;
                justify-content: center;
            }
            .nav {
                margin-left: 0;
                flex-wrap: wrap;
                justify-content: center;
                gap: 6px;
            }
            .header-right {
                flex-basis: 100%;
                justify-content: center;
                gap: 12px;
            }
            .search-box input[type="search"] {
                width: 120px;
            }
            .search-box input[type="search"]:focus {
                width: 180px;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-left">
            <h1>Xu?t kho</h1>
            <nav class="nav" role="navigation" aria-label="?i?u h??ng chính">
                <a href="product_list.html">S?n ph?m</a>
                <a href="import_goods.html">Nh?p kho</a>
                <a href="export_goods.html" class="active" aria-current="page">Xu?t kho</a>
                <a href="stats.html">Th?ng kê</a>
                <a href="login.html">??ng xu?t</a>
            </nav>
        </div>
        <div class="header-right">
            <div class="search-box" role="search">
                <input type="search" placeholder="Tìm ki?m..." aria-label="Tìm ki?m s?n ph?m ho?c xu?t kho..." id="searchInput" />
                <svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M15.5 14h-.79l-.28-.27a6.471 6.471 0 001.48-5.34C14.77 5.4 12.61 3.5 9.99 3.5S5.22 5.4 5.22 8.39c0 3 2.13 5.41 4.77 5.41a4.87 4.87 0 003.22-1.3l.27.28v.79l5 4.99L20.49 19l-4.99-5zM9.99 13.29a4.43 4.43 0 01-4.43-4.42c0-2.44 2-4.42 4.43-4.42s4.42 1.97 4.42 4.41c0 2.48-1.98 4.43-4.42 4.43z"/></svg>
            </div>
            <div class="notification-wrapper" tabindex="0" aria-label="Thông báo" role="button">
                <svg class="notification-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
                    <path d="M12 22c1.1 0 1.99-.9 1.99-2H10c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 00-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1.99 2H20l-2-2z"/>
                </svg>
                <span class="notification-badge" aria-label="S? thông báo">3</span>
                <div class="notification-dropdown" tabindex="-1" aria-hidden="true" aria-label="Danh sách thông báo">
                    <div>B?n có ??n hàng m?i c?n x? lý.</div>
                    <div>S?n ph?m SP002 s?p h?t hàng.</div>
                    <div>Báo cáo tháng 5 ?ã ???c c?p nh?t.</div>
                </div>
            </div>
            <div class="user-menu">
                <input type="checkbox" id="user-menu-toggle" />
                <label for="user-menu-toggle" aria-haspopup="true" aria-expanded="false" aria-controls="user-menu-dropdown" aria-label="Menu ng??i dùng">
                    <img src="https://i.pravatar.cc/40" alt="Avatar ng??i dùng" class="user-avatar" />
                </label>
                <nav class="dropdown-menu" id="user-menu-dropdown" role="menu" aria-hidden="true">
                    <a href="myprofile.html" role="menuitem" tabindex="0">My Profile</a>
                    <a href="change_password.html" role="menuitem" tabindex="0">Change Password</a>
                    <a href="login.html" role="menuitem" tabindex="0">Log Out</a>
                </nav>
            </div>
        </div>
    </header>
    <body class="bg-[#f8f9ff] font-sans text-[10px] sm:text-xs">
  <div class="flex flex-col md:flex-row min-h-screen p-4 gap-4">
   <!-- Left side: Categories and product grid -->
   <div class="flex-1 flex flex-col gap-4">
    <!-- Categories -->
    <div class="flex flex-wrap justify-start gap-2 md:gap-4 bg-white rounded-md p-2 md:p-3 shadow-sm">
     <!-- Fruits active -->
     <button aria-pressed="true" class="flex flex-col items-center justify-center gap-1 bg-[#5c5ce6] text-white rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0">
      <img alt="Fruits icon with cherries and grapes" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/ed85b4ac-5212-4747-80c5-b954e232020c.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Fruits
      </span>
     </button>
     <!-- Headphones -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Headphones icon with headset" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/36f4c93e-c940-4a8d-8b94-ef887b1fb45d.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Headphones
      </span>
     </button>
     <!-- Accessories -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Accessories icon with test tube" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/c12b37de-a7b7-4e36-f765-5410d40bfd2f.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Accessories
      </span>
     </button>
     <!-- Shoes -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Shoes icon with sneaker" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/2e2c00cb-b58f-45ab-71c6-aa05b0bec0cb.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Shoes
      </span>
     </button>
     <!-- Computer -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Computer icon with laptop" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/dbbc812e-0201-411b-5145-ef7510eed8c0.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Computer
      </span>
     </button>
     <!-- Snacks -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Snacks icon with burger" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/698f4b0b-5e38-4ee0-d874-5c8c2a61493e.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Snacks
      </span>
     </button>
     <!-- Watches -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Watches icon with wristwatch" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/ef70d5aa-a861-4fa8-222d-6519c73afe15.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Watches
      </span>
     </button>
     <!-- Cycles -->
     <button aria-pressed="false" class="flex flex-col items-center justify-center gap-1 bg-white text-black rounded-md w-[72px] h-[72px] md:w-[96px] md:h-[96px] shrink-0 border border-transparent hover:border-gray-300">
      <img alt="Cycles icon with bicycle" class="w-6 h-6 md:w-8 md:h-8" draggable="false" height="24" src="https://storage.googleapis.com/a1aa/image/e0af35fa-d9ce-4da6-f99e-317598599d0a.jpg" width="24"/>
      <span class="text-[9px] md:text-xs select-none">
       Cycles
      </span>
     </button>
    </div>
    <!-- Products grid -->
    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 bg-white rounded-md p-4 shadow-sm">
     <!-- Product 1 selected -->
     <div aria-selected="true" class="relative border border-[#3b3b9c] rounded-md p-2 cursor-pointer select-none">
      <div class="absolute top-0 left-0 bg-[#3b3b9c] w-5 h-5 rounded-br-md flex items-center justify-center text-white text-xs font-semibold">
       <i class="fas fa-check">
       </i>
      </div>
      <img alt="Close-up photo of fresh orange fruits with one sliced in half showing inside" class="w-full h-[160px] object-cover rounded-md" draggable="false" height="160" src="https://storage.googleapis.com/a1aa/image/65c79b28-67e1-4e2a-03f8-d50a80fbcfb9.jpg" width="160"/>
      <div class="text-center mt-2">
       <p class="text-[8px] text-gray-600 select-none">
        Fruits
       </p>
       <p class="font-bold text-[10px] select-none">
        Orange
       </p>
       <p class="text-[9px] text-red-500 select-none">
        150.00
       </p>
      </div>
     </div>
     <!-- Product 2 -->
     <div aria-selected="false" class="border border-transparent rounded-md p-2 cursor-pointer select-none hover:border-gray-300">
      <img alt="Close-up photo of fresh red strawberries with green leaves" class="w-full h-[160px] object-cover rounded-md" draggable="false" height="160" src="https://storage.googleapis.com/a1aa/image/960e5edc-f6b1-4d1c-7564-61dc075a08a1.jpg" width="160"/>
      <div class="text-center mt-2">
       <p class="text-[8px] text-gray-600 select-none">
        Fruits
       </p>
       <p class="font-bold text-[10px] select-none">
        Strawberry
       </p>
       <p class="text-[9px] text-red-500 select-none">
        15.00
       </p>
      </div>
     </div>
     <!-- Product 3 -->
     <div aria-selected="false" class="border border-transparent rounded-md p-2 cursor-pointer select-none hover:border-gray-300">
      <img alt="Close-up photo of ripe yellow bananas" class="w-full h-[160px] object-cover rounded-md" draggable="false" height="160" src="https://storage.googleapis.com/a1aa/image/d4643ecd-c1ac-4e09-c46b-300a9718fe00.jpg" width="160"/>
      <div class="text-center mt-2">
       <p class="text-[8px] text-gray-600 select-none">
        Fruits
       </p>
       <p class="font-bold text-[10px] select-none">
        Banana
       </p>
       <p class="text-[9px] text-red-500 select-none">
        150.00
       </p>
      </div>
     </div>
     <!-- Product 4 -->
     <div aria-selected="false" class="border border-transparent rounded-md p-2 cursor-pointer select-none hover:border-gray-300">
      <img alt="Close-up photo of fresh yellow lemons with green leaves and one sliced in half showing inside" class="w-full h-[160px] object-cover rounded-md" draggable="false" height="160" src="https://storage.googleapis.com/a1aa/image/f4a9e14e-c30e-4f0a-4c06-b595ef83699f.jpg" width="160"/>
      <div class="text-center mt-2">
       <p class="text-[8px] text-gray-600 select-none">
        Fruits
       </p>
       <p class="font-bold text-[10px] select-none">
        Limon
       </p>
       <p class="text-[9px] text-red-500 select-none">
        1500.00
       </p>
      </div>
     </div>
     <!-- Product 5 -->
     <div aria-selected="false" class="border border-transparent rounded-md p-2 cursor-pointer select-none hover:border-gray-300">
      <img alt="Photo of red apples on a blue cloth" class="w-full h-[160px] object-cover rounded-md" draggable="false" height="160" src="https://storage.googleapis.com/a1aa/image/5efe9415-24f0-4496-93ee-243bc0e8477d.jpg" width="160"/>
      <div class="text-center mt-2">
       <p class="text-[8px] text-gray-600 select-none">
        Fruits
       </p>
       <p class="font-bold text-[10px] select-none">
        Apple
       </p>
       <p class="text-[9px] text-red-500 select-none">
        1500.00
       </p>
      </div>
     </div>
    </div>
   </div>
   <!-- Right side: Customer and cart -->
   <div class="w-full max-w-[400px] flex flex-col gap-3">
    <!-- Add Customer button -->
    <button class="w-full border border-[#3cb371] text-[#3cb371] rounded-md py-1 text-[11px] font-semibold flex items-center justify-center gap-1 hover:bg-[#3cb371] hover:text-white transition" type="button">
     <i class="fas fa-plus">
     </i>
     Add Customer
    </button>
    <!-- Customer select -->
    <select aria-label="Select customer" class="w-full border border-gray-300 rounded-md p-2 text-[11px] text-gray-600">
     <option>
      Walk-in Customer
     </option>
    </select>
    <!-- Product select -->
    <select aria-label="Select product" class="w-full border border-gray-300 rounded-md p-2 text-[11px] text-gray-600">
     <option>
      Product
     </option>
    </select>
    <!-- Scan barcode button -->
    <button class="bg-[#4f46e5] text-white text-[11px] px-3 py-1 rounded-md flex items-center justify-center gap-2 w-max ml-auto" type="button">
     <i class="fas fa-barcode">
     </i>
     Scan barcode
    </button>
    <!-- Cart items container -->
    <div aria-label="Cart items" class="border border-gray-200 rounded-md p-2 max-h-[280px] overflow-y-auto scrollbar-thin">
     <p class="text-[9px] text-[#3b3b9c] mb-1 select-none">
      Total items : 4
     </p>
     <!-- Cart item 1 -->
     <div class="flex items-center justify-between border-b border-gray-100 py-1" role="listitem">
      <div class="flex items-center gap-2">
       <img alt="Green shoes product image" class="w-10 h-10 object-cover rounded" draggable="false" height="40" src="https://storage.googleapis.com/a1aa/image/0183c86b-e8d8-417a-498a-7abc57fdeb07.jpg" width="40"/>
       <div class="flex flex-col text-[9px]">
        <span class="font-bold select-none">
         ---
        </span>
        <span class="bg-[#f97316] text-white text-[7px] font-semibold px-1 rounded select-none">
         PT001
        </span>
       </div>
      </div>
      <div class="text-[9px] select-none">
       3000.00
      </div>
      <div class="flex items-center gap-1 text-gray-600 text-[10px] select-none">
       <button aria-label="Decrease quantity" class="border border-gray-300 rounded px-1 leading-none" type="button">
        -
       </button>
       <span class="w-4 text-center">
        0
       </span>
       <button aria-label="Increase quantity" class="border border-gray-300 rounded px-1 leading-none" type="button">
        +
       </button>
      </div>
      <button aria-label="Remove item" class="text-red-500 text-[14px] ml-2" type="button">
       <i class="fas fa-trash-alt">
       </i>
      </button>
     </div>
     <!-- Cart item 2 -->
     <div class="flex items-center justify-between border-b border-gray-100 py-1" role="listitem">
      <div class="flex items-center gap-2">
       <img alt="Yellow banana product image" class="w-10 h-10 object-cover rounded" draggable="false" height="40" src="https://storage.googleapis.com/a1aa/image/df00a17f-7e59-4132-7ca9-c669675b61c7.jpg" width="40"/>
       <div class="flex flex-col text-[9px]">
        <span class="font-bold select-none">
         Banana
        </span>
        <span class="bg-[#f97316] text-white text-[7px] font-semibold px-1 rounded select-none">
         PT001
        </span>
       </div>
      </div>
      <div class="text-[9px] select-none">
       3000.00
      </div>
      <div class="flex items-center gap-1 text-gray-600 text-[10px] select-none">
       <button aria-label="Decrease quantity" class="border border-gray-300 rounded px-1 leading-none" type="button">
        -
       </button>
       <span class="w-4 text-center">
        0
       </span>
       <button aria-label="Increase quantity" class="border border-gray-300 rounded px-1 leading-none" type="button">
        +
       </button>
      </div>
      <button aria-label="Remove item" class="text-red-500 text-[14px] ml-2" type="button">
       <i class="fas fa-trash-alt">
       </i>
      </button>
     </div>
     <!-- Cart item 3 -->
     <div class="flex items-center justify-between border-b border-gray-100 py-1" role="listitem">
      <div class="flex items-center gap-2">
       <img alt="Red strawberry product image" class="w-10 h-10 object-cover rounded" draggable="false" height="40" src="https://storage.googleapis.com/a1aa/image/db056bad-5c29-4b5a-3357-d3d91462b113.jpg" width="40"/>
       <div class="flex flex-col text-[9px]">
        <span class="font-bold select-none">
         Strawberry
        </span>
        <span class="bg-[#f97316] text-white text-[7px] font-semibold px-1 rounded select-none">
         PT001
        </span>
       </div>
      </div>
      <div class="text-[9px] select-none">
       3000.00
      </div>
      <div class="flex items-center gap-1 text-gray-600 text-[10px] select-none">
       <button aria-label="Decrease quantity" class="border border-gray-300 rounded px-1 leading-none" type="button">
        -
       </button>
       <span class="w-4 text-center">
        0
       </span>
       <button aria-label="Increase quantity" class="border border-gray-300 rounded px-1 leading-none" type="button">
        +
       </button>
      </div>
      <button aria-label="Remove item" class="text-red-500 text-[14px] ml-2" type="button">
       <i class="fas fa-trash-alt">
       </i>
      </button>
     </div>
    </div>
    <!-- Subtotal, Tax, Total -->
    <div class="text-[9px] text-gray-700 flex flex-col gap-0.5 mt-2">
     <div class="flex justify-between">
      <span>
       Subtotal
      </span>
      <span>
       55.00$
      </span>
     </div>
     <div class="flex justify-between">
      <span>
       Tax
      </span>
      <span>
       5.00$
      </span>
     </div>
     <div class="flex justify-between font-semibold text-[#3b3b9c]">
      <span>
       Total
      </span>
      <span>
       60.00$
      </span>
     </div>
    </div>
    <!-- Payment method buttons -->
    <div class="flex gap-2 mt-2">
     <button class="flex-1 border border-gray-300 rounded-md py-3 text-[10px] font-bold text-gray-700 flex flex-col items-center justify-center gap-1 hover:bg-gray-100" type="button">
      <i class="fas fa-camera-retro text-lg">
      </i>
      Cash
     </button>
     <button class="flex-1 border border-gray-300 rounded-md py-3 text-[10px] font-bold text-gray-700 flex flex-col items-center justify-center gap-1 hover:bg-gray-100" type="button">
      <i class="fas fa-credit-card text-lg">
      </i>
      Debit
     </button>
     <button class="flex-1 border border-gray-300 rounded-md py-3 text-[10px] font-bold text-gray-700 flex flex-col items-center justify-center gap-1 hover:bg-gray-100" type="button">
      <i class="fas fa-th-large text-lg">
      </i>
      Scan
     </button>
    </div>
    <!-- Checkout button -->
    <button class="mt-2 w-full bg-[#6c63ff] text-white text-[11px] font-semibold rounded-md py-2 flex items-center justify-between px-4" type="button">
     <span>
      Checkout
     </span>
     <span>
      60.00$
     </span>
    </button>
   </div>
  </div>
 </body>
</html>
