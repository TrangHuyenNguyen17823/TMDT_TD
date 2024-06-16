<%@ Page Title="" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="DienThoai.aspx.cs" Inherits="Ecommerce_Client.DienThoai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }
        /* Other styles remain unchanged */
        .search-container {
            display: flex;
            justify-content: center;
            padding: 20px;
            background-color: #333;
            width: 100%;
            margin-top: 10px;
        }
        .search-box {
            position: relative;
            width: 40%;
            max-width: 600px;
            justify-content: center;
            margin-top: 15px;
            margin-left: auto;
            margin-right: auto;
        }
        .search-input {
            width: 100%;
            padding: 10px 15px;
            border: none;
            border-radius: 20px;
            outline: none;
            font-size: 16px;
        }
        .search-button {
            position: absolute;
            right: 0;
            top: 0;
            bottom: 0;
            background: none;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            outline: none;
        }
        .search-button i {
            font-size: 20px;
            color: #666;
        }
        .search-button:hover {
            background-color: #ffd700;
        }
        .search-button:active {
            background-color: #ffc107;
        }
        .category-container {
            display: flex;
            overflow-x: auto;
            padding: 10px;
            margin-top: 20px;
            justify-content: center;
            white-space: nowrap;
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
        .category-button:active {
            transform: translateY(0);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .card-img-top {
            transition: transform 0.3s;
        }
        .card:hover .card-img-top {
            transform: scale(1.1);
        }
        .card-body {
            padding: 1.25rem;
        }
        .product-name {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 0.75rem;
            line-height: 1.2;
            max-height: 2.4em;
            overflow: hidden;
        }
        .product-name a {
            color: inherit;
            text-decoration: none;
        }
        .product-name a:hover {
            text-decoration: underline;
        }
        .product-price {
            color: #ffc107;
            font-weight: bold;
        }
        .stock-info {
            font-size: 0.875rem;
            text-align: right;
        }
        .add-to-cart {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            text-align: center;
            padding: 0.75rem 0;
            transform: translateY(100%);
            transition: transform 0.3s;
        }
        .card:hover .add-to-cart {
            transform: translateY(0);
        }
    </style>

    <!-- Header-->
    <header class="bg-dark py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">Welcome to Website Ecommerce</h1>
                <p class="lead fw-normal text-white-50 mb-0">Điện thoại mới - giá rẻ - uy tín - chất lượng</p>
                <div class="search-box">
                    <input type="text" class="search-input" placeholder="Tìm kiếm sản phẩm...">
                    <button class="search-button">Tìm kiếm</button>
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

    <!-- Section-->
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center products-container">
                <% 
                    Ecommerce_Client.DienThoaiDataUtils dataUtilsProduct = new Ecommerce_Client.DienThoaiDataUtils();
                    List<Ecommerce_Client.Models.Product> products = dataUtilsProduct.GetProducts();
                    foreach (Ecommerce_Client.Models.Product product in products)
                    {
                %>
                <div class="col mb-5 product-card">
                    <div class="card h-100">
                        <div class="position-relative">
                            <img class="card-img-top" src="<%= product.image %>" alt="Product Image" />
                            <div class="card-body">
                                <div class="text-center">
                                    <h5 class="product-name">
                                        <a href='ChiTietSanPham.aspx?productId=<%= product.product_id %>'>
                                            <%= product.name %>
                                        </a>
                                    </h5>
                                    <span class="product-price">$<%= product.price %></span>
                                    <p class="stock-info" style="color:darkgray"><%= product.stock %></p>
                                </div>
                            </div>
                            <div class="add-to-cart">
                                <a class="btn btn-outline-light" href="#">Add to cart</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="~/homepageassets/js/scripts.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS for handling category selection -->
    <script>
        $(document).ready(function () {
            $('.category-button').on('click', function (event) {
                event.preventDefault();
                var category = $(this).data('category');
                loadProducts(category);
            });

            function loadProducts(category) {
                $.ajax({
                    type: 'POST',
                    url: 'TrangChu.aspx/GetProductsByCategory',
                    data: JSON.stringify({ category: category }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        var productsHtml = '';
                        $.each(response.d, function (index, product) {
                            productsHtml += `
                                <div class="col mb-5 product-card">
                                    <div class="card h-100">
                                        <div class="position-relative">
                                            <img class="card-img-top" src="${product.image}" alt="Product Image" />
                                            <div class="card-body">
                                                <div class="text-center">
                                                    <h5 class="product-name">
                                                        <a href='ChiTietSanPham.aspx?productId=${product.product_id}'>
                                                            ${product.name}
                                                        </a>
                                                    </h5>
                                                    <span class="product-price">$${product.price}</span>
                                                    <p class="stock-info" style="color:darkgray">${product.stock}</p>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <a class="btn btn-outline-light" href="#">Add to cart</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            `;
                        });
                        $('.products-container').html(productsHtml);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error loading products:', error);
                    }
                });
            }
        });
    </script>
</asp:Content>
