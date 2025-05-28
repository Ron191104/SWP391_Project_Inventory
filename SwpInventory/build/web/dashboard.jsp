<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1" name="viewport"/>
        <title>
            Dashboard
        </title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&amp;display=swap" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <style>
            /* Import Montserrat font */
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap');

            /* Reset and base styles */
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                font-family: 'Montserrat', sans-serif;
                background-color: #f9fafb;
                color: #4a5568;
            }
            a {
                text-decoration: none;
                color: inherit;
                display: flex;
                align-items: center;
            }
            ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            button {
                background: none;
                border: none;
                cursor: pointer;
            }

            /* Container flex */
            .container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                width: 16rem;
                background: white;
                border-right: 1px solid #e2e8f0;
                display: flex;
                flex-direction: column;
            }
            .sidebar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 1.5rem;
                border-bottom: 1px solid #e2e8f0;
            }
            .logo-text {
                display: flex;
                align-items: center;
                gap: 0.25rem;
                user-select: none;
            }
            .logo-text .dreams {
                font-weight: 800;
                font-size: 1.5rem;
                color: #1e293b;
                font-family: 'Montserrat', sans-serif;
            }
            .logo-text .pos {
                font-weight: 700;
                font-size: 0.75rem;
                color: #f59e0b;
                padding-top: 0.3rem;
                font-family: 'Montserrat', sans-serif;
            }
            .sidebar-nav {
                flex-grow: 1;
                overflow-y: auto;
                padding: 1.5rem 1rem;
            }
            .sidebar-nav li + li {
                margin-top: 0.5rem;
            }
            .sidebar-nav a {
                padding: 0.75rem 1rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                color: #475569;
                transition: background-color 0.2s, color 0.2s;
            }
            .sidebar-nav a:hover {
                background-color: #f1f5f9;
                color: #4f46e5;
            }
            .sidebar-nav a.active {
                background-color: #1e293b;
                color: white;
                font-weight: 600;
            }
            .sidebar-nav a .icon {
                margin-right: 0.75rem;
                font-size: 0.875rem;
                width: 1rem;
                text-align: center;
                color: inherit;
            }
            .sidebar-nav a .chevron {
                margin-left: auto;
                font-size: 0.75rem;
                color: #94a3b8;
            }

            /* Topbar */
            .topbar {
                background: white;
                border-bottom: 1px solid #e2e8f0;
                padding: 1rem 1.5rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .topbar-left {
                display: flex;
                align-items: center;
                gap: 1.5rem;
            }
            .topbar-left button,
            .topbar-right button {
                color: #475569;
                font-size: 1.125rem;
                position: relative;
            }
            .topbar-left img.flag {
                width: 2rem;
                height: 1.25rem;
                object-fit: cover;
                border-radius: 0.125rem;
            }
            .notification-badge {
                position: absolute;
                top: -0.25rem;
                right: -0.25rem;
                background-color: #f97316;
                color: white;
                font-size: 0.75rem;
                font-weight: 600;
                width: 1.25rem;
                height: 1.25rem;
                border-radius: 9999px;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Profile dropdown container */
            .profile-container {
                position: relative;
                display: inline-block;
            }
            .profile-button {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                cursor: pointer;
                color: #475569;
                font-size: 1rem;
                border: none;
                background: none;
            }
            .profile-button img {
                width: 2rem;
                height: 2rem;
                border-radius: 9999px;
                object-fit: cover;
            }
            .profile-button i {
                font-size: 0.875rem;
                color: #475569;
            }

            /* Profile dropdown menu - hidden by default */
            .profile-dropdown {
                position: absolute;
                right: 0;
                margin-top: 0.5rem;
                width: 12rem;
                background: white;
                border: 1px solid #e2e8f0;
                border-radius: 0.375rem;
                box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1),
                    0 4px 6px -4px rgb(0 0 0 / 0.1);
                z-index: 10;
                display: none;
            }
            .profile-dropdown.show {
                display: block;
            }
            .profile-dropdown-header {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                padding: 0.75rem 1rem;
                border-bottom: 1px solid #e2e8f0;
            }
            .profile-dropdown-header img {
                width: 2.5rem;
                height: 2.5rem;
                border-radius: 9999px;
                object-fit: cover;
            }
            .profile-dropdown-header div p:first-child {
                font-weight: 600;
                color: #1e293b;
                margin: 0;
                font-size: 0.875rem;
            }
            .profile-dropdown-header div p:last-child {
                font-size: 0.75rem;
                color: #94a3b8;
                margin: 0;
            }
            .profile-dropdown ul {
                padding: 0.5rem 0;
                margin: 0;
            }
            .profile-dropdown ul li a {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
                color: #475569;
                transition: background-color 0.2s, color 0.2s;
            }
            .profile-dropdown ul li a:hover {
                background-color: #f1f5f9;
                color: #4f46e5;
            }
            .profile-dropdown ul li.logout a {
                color: #ef4444;
            }
            .profile-dropdown ul li.logout a:hover {
                background-color: #fee2e2;
            }

            /* Main content */
            .main-content {
                flex-grow: 1;
                background-color: #f1f5f9;
                padding: 1.5rem;
                overflow-y: auto;
            }

            /* Cards container */
            .cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(14rem, 1fr));
                gap: 1rem;
                margin-bottom: 1.5rem;
            }
            .card {
                border-radius: 0.375rem;
                padding: 1rem 1.25rem;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-weight: 600;
            }
            .card p:first-child {
                font-size: 1.25rem;
                margin: 0;
            }
            .card p:last-child {
                font-weight: 400;
                font-size: 0.875rem;
                margin: 0;
            }
            .card i {
                font-size: 2.5rem;
            }
            .card.orange {
                background-color: #f59e0b;
            }
            .card.cyan {
                background-color: #06b6d4;
            }
            .card.indigo {
                background-color: #1e293b;
            }
            .card.green {
                background-color: #16a34a;
            }

            /* Dashboard grid */
            .dashboard-grid {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            @media (min-width: 1024px) {
                .dashboard-grid {
                    grid-template-columns: 2fr 1fr;
                }
            }

            /* Section cards */
            .section-card {
                background: white;
                border-radius: 0.375rem;
                padding: 1.5rem;
                box-shadow: 0 1px 2px rgb(0 0 0 / 0.05);
                display: flex;
                flex-direction: column;
            }

            /* Section header */
            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }
            .section-header h2 {
                font-weight: 600;
                font-size: 1.125rem;
                color: #1e293b;
                margin: 0;
            }
            .section-header button {
                color: #94a3b8;
                font-size: 1rem;
            }
            .section-header button:hover {
                color: #475569;
            }

            /* Table styles */
            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.875rem;
                color: #475569;
            }
            thead {
                border-bottom: 1px solid #e2e8f0;
                font-weight: 600;
                color: #1e293b;
            }
            th, td {
                padding: 0.5rem 0.75rem;
                text-align: left;
                vertical-align: middle;
            }
            th.sno, td.sno {
                width: 3rem;
            }
            th.price, td.price {
                width: 6rem;
            }
            tbody tr {
                border-bottom: 1px solid #f1f5f9;
                transition: background-color 0.2s;
            }
            tbody tr:hover {
                background-color: #f9fafb;
            }
            tbody td.product {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }
            tbody td.product img {
                width: 2rem;
                height: 2rem;
                object-fit: contain;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-header">
                    <div class="logo-text">
                        <img alt="Orange bag icon representing Dreams POS logo" height="40" src="https://storage.googleapis.com/a1aa/image/df62b900-f8f4-4151-8cf4-b101e4e65255.jpg" width="40"/>
                        <span class="dreams">
                            Dreams
                        </span>
                        <span class="pos">
                            POS
                        </span>
                    </div>
                    <button aria-label="Location">
                        <i class="fas fa-map-marker-alt">
                        </i>
                    </button>
                </div>
                <nav aria-label="Main navigation" class="sidebar-nav">
                    <ul>
                        <li>
                            <a class="active" href="#">
                                <i class="fas fa-tachometer-alt icon">
                                </i>
                                Dashboard
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-cube icon">
                                </i>
                                Product
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-shopping-cart icon">
                                </i>
                                Sales
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-file-invoice icon">
                                </i>
                                Purchase
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-file-alt icon">
                                </i>
                                Expense
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-tags icon">
                                </i>
                                Quotation
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-user icon">
                                </i>
                                People
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-file icon">
                                </i>
                                Blank Page
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-chart-bar icon">
                                </i>
                                Charts
                                <i class="fas fa-chevron-right chevron">
                                </i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </aside>
            <!-- Main content -->
            <div style="flex-grow:1; display:flex; flex-direction:column;">
                <!-- Topbar -->
                <header class="topbar">
                    <div class="topbar-left">
                        <button aria-label="Search">
                            <i class="fas fa-search">
                            </i>
                        </button>
                        <img alt="Flag of United States" class="flag" height="20" src="https://storage.googleapis.com/a1aa/image/9f6a1408-3ebc-408d-863a-086da52c6a90.jpg" width="32"/>
                    </div>
                    <div class="topbar-right" style="display:flex; align-items:center; gap:1.5rem;">
                        <button aria-label="Notifications" style="position:relative;">
                            <i class="fas fa-bell">
                            </i>
                            <span class="notification-badge">
                                4
                            </span>
                        </button>
                        <div class="profile-container">
                            <!-- Profile button toggles dropdown -->
                            <button aria-expanded="false" aria-haspopup="true" aria-label="User profile menu" class="profile-button" onclick="toggleDropdown(event)">
                                <img alt="User profile picture, a person in camouflage uniform" height="32" src="https://storage.googleapis.com/a1aa/image/9e35c7b0-8309-4262-2cc6-a7c46277409e.jpg" width="32"/>
                                <i class="fas fa-caret-down">
                                </i>
                            </button>
                            <!-- Profile dropdown hidden by default -->
                            <div aria-label="User profile options" class="profile-dropdown" id="profileDropdown" role="menu">
                                <div class="profile-dropdown-header">
                                    <img alt="User profile picture, a person in camouflage uniform" height="40" src="https://storage.googleapis.com/a1aa/image/9e35c7b0-8309-4262-2cc6-a7c46277409e.jpg" width="40"/>
                                    <div>
                                        <p>
                                            John Doe
                                        </p>
                                        <p>
                                            Admin
                                        </p>
                                    </div>
                                </div>
                                <ul>
                                    <li>
                                        <a href="#">
                                            <i class="fas fa-user">
                                            </i>
                                            My Profile
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fas fa-cog">
                                            </i>
                                            Settings
                                        </a>
                                    </li>
                                    <li class="logout">
                                        <a href="#">
                                            <i class="fas fa-sign-out-alt">
                                            </i>
                                            Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </header>
                <!-- Content -->
                <main class="main-content">
                    <!-- Cards -->
                    <section aria-label="Summary cards" class="cards">
                        <article aria-label="100 Customers" class="card orange">
                            <div>
                                <p>
                                    100
                                </p>
                                <p>
                                    Customers
                                </p>
                            </div>
                            <i class="fas fa-user">
                            </i>
                        </article>
                        <article aria-label="100 Suppliers" class="card cyan">
                            <div>
                                <p>
                                    100
                                </p>
                                <p>
                                    Suppliers
                                </p>
                            </div>
                            <i class="fas fa-user-check">
                            </i>
                        </article>
                        <article aria-label="100 Purchase Invoice" class="card indigo">
                            <div>
                                <p>
                                    100
                                </p>
                                <p>
                                    Purchase Invoice
                                </p>
                            </div>
                            <i class="fas fa-file-alt">
                            </i>
                        </article>
                        <article aria-label="105 Sales Invoice" class="card green">
                            <div>
                                <p>
                                    105
                                </p>
                                <p>
                                    Sales Invoice
                                </p>
                            </div>
                            <i class="fas fa-file-invoice">
                            </i>
                        </article>
                    </section>
                    <!-- Dashboard grid -->
                    <section class="dashboard-grid">
                        <!-- Left: Purchase & Sales chart -->
                        <section aria-labelledby="purchase-sales-title" class="section-card">
                            <div class="section-header">
                                <h2 id="purchase-sales-title">
                                    Purchase &amp; Sales
                                </h2>
                                <div style="display:flex; align-items:center; gap:1rem; font-size:0.875rem; color:#475569;">
                                    <div style="display:flex; align-items:center; gap:0.25rem;">
                                        <span style="width:0.75rem; height:0.75rem; background:#22c55e; border-radius:9999px; display:inline-block;">
                                        </span>
                                        <span>
                                            Sales
                                        </span>
                                    </div>
                                    <div style="display:flex; align-items:center; gap:0.25rem;">
                                        <span style="width:0.75rem; height:0.75rem; background:#ef4444; border-radius:9999px; display:inline-block;">
                                        </span>
                                        <span>
                                            Purchase
                                        </span>
                                    </div>
                                    <select aria-label="Select year" style="border:1px solid #cbd5e1; border-radius:0.375rem; padding:0.25rem 0.5rem; font-size:0.875rem; color:#475569;">
                                        <option>
                                            2022
                                        </option>
                                        <option>
                                            2023
                                        </option>
                                        <option>
                                            2024
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <img alt="Bar chart showing purchase and sales data for 2022 with green bars above zero and red bars below zero" height="300" src="https://storage.googleapis.com/a1aa/image/c868b569-edcd-49f6-34db-68201db812a0.jpg" style="width:100%; height:auto;" width="600"/>
                        </section>
                        <!-- Right: Recently Added Products -->
                        <section aria-labelledby="recent-products-title" class="section-card">
                            <div class="section-header">
                                <h2 id="recent-products-title">
                                    Recently Added Products
                                </h2>
                                <button aria-label="More options">
                                    <i class="fas fa-ellipsis-v">
                                    </i>
                                </button>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th class="sno" scope="col">
                                            Sno
                                        </th>
                                        <th scope="col">
                                            Products
                                        </th>
                                        <th class="price" scope="col">
                                            Price
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="sno" scope="row">
                                            1
                                        </td>
                                        <td class="product">
                                            <img alt="Apple Earpods product image, white wireless earbuds with charging case" height="32" src="https://storage.googleapis.com/a1aa/image/d89970b7-10b9-42d3-9bfb-112bbb41696d.jpg" width="32"/>
                                            Apple Earpods
                                        </td>
                                        <td class="price">
                                            $891.2
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            2
                                        </td>
                                        <td class="product">
                                            <img alt="iPhone 11 product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/51afd909-b603-4c36-8c52-b04ccc1a2f01.jpg" width="32"/>
                                            iPhone 11
                                        </td>
                                        <td class="price">
                                            $668.51
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            3
                                        </td>
                                        <td class="product">
                                            <img alt="Samsung product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/5fec6a85-5dab-4942-c504-2388d0ae8592.jpg" width="32"/>
                                            samsung
                                        </td>
                                        <td class="price">
                                            $522.29
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            4
                                        </td>
                                        <td class="product">
                                            <img alt="Motorola Razr product image, foldable smartphone" height="32" src="https://storage.googleapis.com/a1aa/image/e4f3a196-123d-4b64-749a-6fa0cba4ac8c.jpg" width="32"/>
                                            Motorola Razr
                                        </td>
                                        <td class="price">
                                            $891.91
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            5
                                        </td>
                                        <td class="product">
                                            <img alt="OnePlus 8T product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/80065068-99af-4d2a-1b56-0a17c0e0fbe1.jpg" width="32"/>
                                            OnePlus 8T
                                        </td>
                                        <td class="price">
                                            $799.99
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            6
                                        </td>
                                        <td class="product">
                                            <img alt="Google Pixel 5 product image, smartphone with colorful screen" height="32" src="https://storage.googleapis.com/a1aa/image/56201929-41c5-4189-fc13-a577967675a5.jpg" width="32"/>
                                            Google Pixel 5
                                        </td>
                                        <td class="price">
                                            $699.00
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            7
                                        </td>
                                        <td class="product">
                                            <img alt="Sony WH-1000XM4 product image, wireless noise-cancelling headphones" height="32" src="https://storage.googleapis.com/a1aa/image/b66bb397-abb4-4108-21d6-ed55eee10439.jpg" width="32"/>
                                            Sony WH-1000XM4
                                        </td>
                                        <td class="price">
                                            $348.00
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            8
                                        </td>
                                        <td class="product">
                                            <img alt="Apple Watch Series 6 product image, smartwatch with red band" height="32" src="https://storage.googleapis.com/a1aa/image/6ff7c86a-a2d6-42bb-e447-f5dc39bf7162.jpg" width="32"/>
                                            Apple Watch Series 6
                                        </td>
                                        <td class="price">
                                            $399.99
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            9
                                        </td>
                                        <td class="product">
                                            <img alt="Amazon Echo Dot product image, smart speaker with fabric cover" height="32" src="https://storage.googleapis.com/a1aa/image/1e1bb74f-c69c-48d4-e593-db46062b2ce4.jpg" width="32"/>
                                            Amazon Echo Dot
                                        </td>
                                        <td class="price">
                                            $49.99
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            10
                                        </td>
                                        <td class="product">
                                            <img alt="Fitbit Charge 4 product image, fitness tracker with black band" height="32" src="https://storage.googleapis.com/a1aa/image/fe209010-4a01-4072-49a6-a8feaf2d7eb1.jpg" width="32"/>
                                            Fitbit Charge 4
                                        </td>
                                        <td class="price">
                                            $129.95
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            11
                                        </td>
                                        <td class="product">
                                            <img alt="DJI Mavic Air 2 product image, compact drone with camera" height="32" src="https://storage.googleapis.com/a1aa/image/00ad230c-89ca-49d4-699f-48c6cfa35d29.jpg" width="32"/>
                                            DJI Mavic Air 2
                                        </td>
                                        <td class="price">
                                            $799.00
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            12
                                        </td>
                                        <td class="product">
                                            <img alt="GoPro Hero 9 product image, action camera with waterproof housing" height="32" src="https://storage.googleapis.com/a1aa/image/cb1192d5-8b29-4ed2-979b-de3ebfe8142f.jpg" width="32"/>
                                            GoPro Hero 9
                                        </td>
                                        <td class="price">
                                            $399.99
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            13
                                        </td>
                                        <td class="product">
                                            <img alt="Kindle Paperwhite product image, e-reader with black bezel" height="32" src="https://storage.googleapis.com/a1aa/image/f0bdbded-0faa-41d7-9ed0-d0972e6b217c.jpg" width="32"/>
                                            Kindle Paperwhite
                                        </td>
                                        <td class="price">
                                            $129.99
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            14
                                        </td>
                                        <td class="product">
                                            <img alt="Nintendo Switch product image, gaming console with red and blue controllers" height="32" src="https://storage.googleapis.com/a1aa/image/89873458-d51d-4dea-ffda-2609a678b7cb.jpg" width="32"/>
                                            Nintendo Switch
                                        </td>
                                        <td class="price">
                                            $299.99
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="sno" scope="row">
                                            15
                                        </td>
                                        <td class="product">
                                            <img alt="MacBook Pro product image, laptop with silver body" height="32" src="https://storage.googleapis.com/a1aa/image/ed48439b-b586-4f09-a60d-9b8c172107f7.jpg" width="32"/>
                                            MacBook Pro
                                        </td>
                                        <td class="price">
                                            $2399.00
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </section>
                    </section>
                </main>
            </div>
        </div>
        <script>
            // Toggle profile dropdown visibility on avatar click
            function toggleDropdown(event) {
                event.stopPropagation();
                const dropdown = document.getElementById('profileDropdown');
                const btn = event.currentTarget;
                const isShown = dropdown.classList.contains('show');
                if (isShown) {
                    dropdown.classList.remove('show');
                    btn.setAttribute('aria-expanded', 'false');
                } else {
                    dropdown.classList.add('show');
                    btn.setAttribute('aria-expanded', 'true');
                }
            }

            // Close dropdown if clicking outside
            window.addEventListener('click', () => {
                const dropdown = document.getElementById('profileDropdown');
                const btn = document.querySelector('.profile-button');
                if (dropdown.classList.contains('show')) {
                    dropdown.classList.remove('show');
                    btn.setAttribute('aria-expanded', 'false');
                }
            });
        </script>
    </body>
</html>
