<%@ Page Title="" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="Ecommerce_Client.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        .search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #333;
            padding: 20px 0;
            margin-top: 20px;
        }
        .search-box {
            width: 100%;
            max-width: 600px;
            display: flex;
        }
        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #ccc;
            border-radius: 25px 0 0 25px;
            outline: none;
            font-size: 16px;
        }
        .search-button {
            padding: 12px 20px;
            background-color: #ffc107;
            border: none;
            border-radius: 0 25px 25px 0;
            cursor: pointer;
            color: #333;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .search-button:hover {
            background-color: #ffca28;
        }
        .category-container {
            display: flex;
            overflow-x: auto;
            padding: 10px 0;
            justify-content: center;
            white-space: nowrap;
            background-color: #f8f9fa;
        }
        .category-button {
            background: linear-gradient(145deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            padding: 12px 30px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 6px 4px;
            cursor: pointer;
            border-radius: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .category-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }
        .products-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            width: 250px;
            background: #fff;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .card:hover .card-img-top {
            transform: scale(1.1);
        }
        .card-body {
            padding: 20px;
        }
        .card-body a {
            color: #333;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .card-body a:hover {
            color: #ffca28;
        }
        .product-name {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 10px;
            max-height: 3em;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .product-price {
            color: #ffc107;
            font-weight: bold;
            font-size: 1.2rem;
        }
        .stock-info {
            font-size: 0.875rem;
            text-align: right;
            color: #666;
        }
        .add-to-cart {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            text-align: center;
            padding: 10px 0;
            transform: translateY(100%);
            transition: transform 0.3s, opacity 0.3s;
            opacity: 0;
            border-radius: 0 0 15px 15px;
        }
        .card:hover .add-to-cart {
            transform: translateY(0);
            opacity: 1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header -->
    <header class="bg-dark py-5">
        <div class="container">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">Welcome to Website Ecommerce</h1>
                <p class="lead fw-normal text-white-50 mb-0">Điện thoại mới - giá rẻ - uy tín - chất lượng</p>
                <div class="search-container">
                    <div class="search-box">
                        <input type="text" class="search-input" id="inputSearch" placeholder="Tìm kiếm sản phẩm...">
                        <button id="btnTimKiem" class="search-button" type="button">Tìm kiếm</button>
                    </div>


                </div>
                <!-- Phần danh mục -->
                <div class="category-container">
                    <% 
                        Ecommerce_Client.TrangChuDataUtils dataUtils = new Ecommerce_Client.TrangChuDataUtils();
                        List<Ecommerce_Client.Models.Category> categories = dataUtils.GetCategories();
                    %>
                    <a href="DienThoai.aspx" class="category-button" data-category="dienthoai"><%=categories[0].category_name %></a>
                    <a href="LapTop.aspx" class="category-button" data-category="laptop"><%=categories[1].category_name %></a>
                    <a href="PhuKien.aspx" class="category-button" data-category="phukien"><%=categories[2].category_name %></a>
                </div>
            </div>
        </div>
    </header>

    <!-- Section -->
    <section class="py-5">
        <div class="container">
            <div class="products-container">
                <% 
                    Ecommerce_Client.TrangChuDataUtils dataUtilsProduct = new Ecommerce_Client.TrangChuDataUtils();
                    List<Ecommerce_Client.Models.Product> products = dataUtilsProduct.GetProducts();
                    foreach (Ecommerce_Client.Models.Product product in products)
                    {
                %>
                <div class="card">
                    <a href='ChiTietSanPham.aspx?productId=<%= product.product_id %>'>
                        <img class="card-img-top" src="<%= product.image %>" alt="Product Image" />
                        <div class="card-body">
                            <h5 class="product-name"><%= product.name %></h5>
                            <p class="product-price">$<%= product.price %></p>
                            <p class="stock-info">Còn lại: <%= product.stock %> sản phẩm</p>
                        </div>
                    </a>
                    <div class="add-to-cart">
                        <a class="btn btn-outline-light" href="#">Thêm vào giỏ hàng</a>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Search results container -->
            <div class="search-results-container">
                <div id="search-results" class="products-container"></div>
            </div>
        </div>
    </section>

    <!-- Bootstrap core JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <!-- jQuery -->
<!-- jQuery CDN (ensure this script is included) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
        $(document).ready(function () {
            $('#btnTimKiem').click(function (event) {
                event.preventDefault();
                var searchTerm = $('#inputSearch').val().trim();
                if (searchTerm !== '') {
                    window.location.href = 'TimKiem.aspx?searchTerm=' + encodeURIComponent(searchTerm);
                } else {
                    $('#search-results').html('<p class="text-center">Vui lòng nhập từ khóa để tìm kiếm.</p>');
                }
            });
    });

        // Function to display search results dynamically
    //    function displaySearchResults(products) {
    //        var productsHtml = '';
    //        if (products.length > 0) {
    //            $.each(products, function (index, product) {
    //                productsHtml += `
    //                <div class="card">
    //                    <a href='ChiTietSanPham.aspx?productId=${product.product_id}'>
    //                        <img class="card-img-top" src="${product.image}" alt="Product Image" />
    //                        <div class="card-body">
    //                            <h5 class="product-name">${product.name}</h5>
    //                            <p class="product-price">$${product.price}</p>
    //                            <p class="stock-info">Còn lại: ${product.stock} sản phẩm</p>
    //                        </div>
    //                    </a>
    //                    <div class="add-to-cart">
    //                        <a class="btn btn-outline-light" href="#">Thêm vào giỏ hàng</a>
    //                    </div>
    //                </div>
    //                `;
    //            });
    //        } else {
    //            productsHtml = '<p class="text-center">Không tìm thấy sản phẩm nào.</p>';
    //        }
    //        $('#search-results').html(productsHtml); // Update HTML with search results
    //    }
    //});
</script>
</asp:Content>
