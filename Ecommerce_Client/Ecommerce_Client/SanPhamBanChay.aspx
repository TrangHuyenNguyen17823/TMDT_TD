<%@ Page Title="Sản Phẩm Bán Chạy" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="SanPhamBanChay.aspx.cs" Inherits="Ecommerce_Client.SanPhamBanChay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Copy all necessary CSS styles from TatCaSanPham.aspx */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa; /* Background color */
            margin: 0;
            padding: 0;
        }

        /* Paste all CSS styles here */
        .container {
            max-width: 1500px;
            margin: 0 auto;
            padding: 20px;
        }

        .products-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .product-card {
            width: calc(25% - 20px);
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
            color: #f39c12;
            font-size: 18px;
            font-weight: bold;
        }

        .product-stock {
            margin-top: 5px;
            color: #6c757d;
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
            .product-card {
                width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .product-card {
                width: 100%;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            let currentPage = 1;
            let totalPages = 10; // Replace with actual total pages

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
                    url: "SanPhamBanChay.aspx/GetBestSellingProducts",
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
                            productsHtml += '        <div class="product-price">' + formatCurrency(product.price) + '</div>';
                            productsHtml += '        <div class="product-stock">' + (product.stock > 0 ? 'In Stock' : 'Out of Stock') + '</div>';
                            productsHtml += '        <a href="ChiTietSanPham.aspx?id=' + product.id + '" class="btn-outline-dark">Chi tiết</a>';
                            productsHtml += '    </div>';
                            productsHtml += '</div>';
                        });

                        $(".products-container").html(productsHtml);
                        updatePagination(currentPage, totalPages);
                    },
                    error: function () {
                        alert("Error loading products.");
                    }
                });
            }

            function updatePagination(currentPage, totalPages) {
                var paginationHtml = '';
                paginationHtml += '<button class="pagination-button prev-button" ' + (currentPage === 1 ? 'disabled' : '') + '>Previous</button>';
                for (var i = 1; i <= totalPages; i++) {
                    paginationHtml += '<button class="pagination-button ' + (i === currentPage ? 'active' : '') + '" data-page="' + i + '">' + i + '</button>';
                }
                paginationHtml += '<button class="pagination-button next-button" ' + (currentPage === totalPages ? 'disabled' : '') + '>Next</button>';
                $(".pagination").html(paginationHtml);
            }

            function formatCurrency(amount) {
                // Implement currency formatting logic if needed
                return amount.toFixed(2);
            }
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content specific to this page can go here -->
    <div class="container">
        <!-- Product cards and pagination section -->
        <div class="products-container">
            <!-- Product cards will be dynamically added here -->
        </div>

        <!-- Pagination buttons -->
        <div class="pagination">
            <!-- Pagination buttons will be dynamically added here -->
        </div>
    </div>
</asp:Content>
