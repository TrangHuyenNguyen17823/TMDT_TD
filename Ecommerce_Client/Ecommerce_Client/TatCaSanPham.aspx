<%@ Page Title="Tất cả sản phẩm" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="TatCaSanPham.aspx.cs" Inherits="Ecommerce_Client.TatCaSanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa; /* Màu nền */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1500px;
            margin: 0 auto;
            padding: 20px;
        }

        .search-container {
            display: flex;
            justify-content: flex-end; /* Canh phải */
            padding: 20px;
            background-color: #333;
            margin-bottom: 20px;
        }

        .search-box {
            width: 40%;
            max-width: 600px;
            position: relative;
        }

        .search-input {
            width: calc(100% - 90px);
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
            color: #666;
        }

        .search-button:hover {
            background-color: #ffd700; /* Màu vàng đậm hơn khi di chuột qua */
        }

        .search-button:active {
            background-color: #ffc107; /* Màu vàng nhạt khi nhấn vào */
        }

        .category-container {
            flex: 0 0 25%; /* Chiếm 25% chiều rộng */
            padding-right: 20px;
        }

        .category-list {
            margin-top: 20px;
        }

        .category-button {
            background: linear-gradient(145deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            padding: 12px 30px;
            text-align: center;
            text-decoration: none;
            display: block;
            font-size: 16px;
            margin-bottom: 6px;
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

        .ads-slider {
            width: 100%;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .ads-slider img {
            width: 100%;
            height: auto;
            transition: transform 0.3s;
        }

        .products-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .product-card {
            width: calc(25% - 20px); /* 4 sản phẩm trên mỗi hàng */
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
        }

        .product-card img {
            width: 100%;
            height: auto;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }

        .product-details {
            padding: 15px;
        }

        .product-name {
            font-weight: bold;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-price {
            color: #f39c12; /* Màu nổi bật cho giá */
            font-size: 18px;
            font-weight: bold;
        }

        .product-stock {
            margin-top: 5px;
            color: #6c757d; /* Màu chữ xám */
        }

        .btn-outline-dark {
            background-color: #fff;
            color: #343a40;
            border: 2px solid #343a40;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: block;
            font-size: 14px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-outline-dark:hover {
            background-color: #343a40;
            color: #fff;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        .pagination-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 0 5px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .pagination-button:hover {
            background-color: #0056b3;
        }

        .pagination-button:active {
            background-color: #0056b3;
        }

        .pagination-button.disabled {
            background-color: #ced4da;
            cursor: not-allowed;
        }

        .pagination-info {
            margin: 0 10px;
            font-size: 16px;
            color: #333;
        }

        @media (max-width: 768px) {
            .category-container {
                flex: 0 0 100%;
                margin-bottom: 20px;
            }

            .product-card {
                width: calc(50% - 20px); /* 2 sản phẩm trên mỗi hàng */
            }
        }

        @media (max-width: 576px) {
            .search-box {
                width: 100%;
                max-width: 100%;
            }

            .category-container,
            .product-card {
                width: 100%;
                max-width: 100%;
            }
        }
    </style>
    <link rel="stylesheet" href="style.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            let currentPage = 1;
            let totalPages = 10; // Thay giá trị này bằng số trang thực tế

            loadProducts(currentPage);

            $(document).on("click", ".pagination-button", function () {
                var page = $(this).data("page");
                if (page !== currentPage) {
                    loadProducts(page);
                }
            });

            $(document).on("click", ".prev-button", function () {
                if (currentPage > 1) {
                    currentPage--;
                    loadProducts(currentPage);
                }
            });

            $(document).on("click", ".next-button", function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    loadProducts(currentPage);
                }
            });

            function loadProducts(page) {
                currentPage = page;
                $.ajax({
                    type: "POST",
                    url: "TatCaSanPham.aspx/GetProducts",
                    data: JSON.stringify({ page: page }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var productsHtml = "";
                        $.each(response.d, function (index, product) {
                            productsHtml += '<div class="product-card">';
                            productsHtml += '    <img src="' + product.image + '" alt="' + product.name + '">';
                            productsHtml += '    <div class="product-details">';
                            productsHtml += '        <div class="product-name">' + product.name + '</div>';
                            productsHtml += '        <div class="product-price">$' + product.price + '</div>';
                            productsHtml += '        <p class="product-stock">In stock: ' + product.stock + '</p>';
                            productsHtml += '        <a href="#" class="btn btn-outline-dark mt-auto">Thêm vào giỏ hàng</a>';
                            productsHtml += '    </div>';
                            productsHtml += '</div>';
                        });
                        $(".products-container").html(productsHtml);

                        // Cập nhật nút phân trang
                        updatePagination();
                    },
                    error: function () {
                        alert("Đã xảy ra lỗi khi tải dữ liệu.");
                    }
                });
            }

            function updatePagination() {
                var paginationHtml = '';

                if (currentPage > 1) {
                    paginationHtml += '<button class="pagination-button prev-button" data-page="' + (currentPage - 1) + '">Trang trước</button>';
                }

                paginationHtml += '<span class="pagination-info">' + currentPage + ' / ' + totalPages + '</span>';

                if (currentPage < totalPages) {
                    paginationHtml += '<button class="pagination-button next-button" data-page="' + (currentPage + 1) + '">Trang sau</button>';
                }

                $(".pagination").html(paginationHtml);
            }
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header -->
    <div class="container">
        <div class="search-container">
            <div class="search-box">
                <input type="text" class="search-input" placeholder="Tìm kiếm sản phẩm...">
                <button class="search-button">Tìm kiếm</button>
            </div>
        </div>

        <div class="row">
            <!-- Danh mục sản phẩm -->
            <div class="col-md-3">
                <div class="category-container">
                    <h4>Danh mục sản phẩm</h4>
                    <div class="category-list">
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
            
            <!-- Slider quảng cáo -->
            <div class="col-md-9">
                <div class="ads-slider">
                    <img src="homepageassets/imgs/a3.png" alt="Advertisement 1">
                </div>

                <!-- Danh sách sản phẩm -->
                <div class="products-container">
                    <!-- Đây là nơi sẽ hiển thị danh sách sản phẩm -->
                </div>

                <!-- Phân trang -->
                <div class="pagination">
                    <asp:Literal ID="ltPaging" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
