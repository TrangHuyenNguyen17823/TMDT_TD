<%@ Page Title="Kết Quả Tìm Kiếm" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="TimKiem.aspx.cs" Inherits="Ecommerce_Client.TimKiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            display: flex;
            flex-direction: row;
        }
        .filter-container {
            flex: 1;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            margin-right: 20px;
            height: fit-content;
        }
        .filter-container h3 {
            margin-bottom: 20px;
            font-size: 1.5rem;
            color: #343a40;
        }
        .filter-container label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            color: #495057;
        }
        .filter-container input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
        }
        .filter-container button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .filter-container button:hover {
            background-color: #0056b3;
        }
        .product-list-container {
            flex: 3;
        }
        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            width: calc(25% - 20px);
            background: white;
            border: 1px solid #e0e0e0;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
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
            padding: 1.25rem;
        }
        .product-name {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 0.75rem;
            line-height: 1.2;
            max-height: 2.4em;
            overflow: hidden;
            color: #343a40;
        }
        .product-price {
            color: #ffc107;
            font-weight: bold;
        }
        .stock-info {
            font-size: 0.875rem;
            text-align: right;
            color: #6c757d;
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
        .pagination {
            display: flex;
            justify-content: center;
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
        .pagination-button:disabled {
            background-color: #ced4da;
            cursor: not-allowed;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="py-5">
        <div class="container">
            <div class="filter-container">
                <h3>Lọc sản phẩm</h3>
                <label for="priceMin">Giá từ:</label>
                <input type="number" id="priceMin" min="0" step="1000" value="0" />
                <label for="priceMax">Giá đến:</label>
                <input type="number" id="priceMax" min="0" step="1000" value="1000000" />
                <button onclick="applyFilters()">Áp dụng</button>
            </div>
            <div class="product-list-container">
                <h1>Kết Quả Tìm Kiếm</h1>
                <div class="product-list">
                    <asp:Repeater ID="productsRepeater" runat="server">
                        <ItemTemplate>
                            <div class="card">
                                <a href='ChiTietSanPham.aspx?productId=<%# Eval("product_id") %>'>
                                    <img class="card-img-top" src='<%# Eval("image") %>' alt="Product Image" />
                                    <div class="card-body">
                                        <h5 class="product-name"><%# Eval("name") %></h5>
                                        <p class="product-price">$<%# Eval("price") %></p>
                                        <p class="stock-info">Còn lại: <%# Eval("stock") %> sản phẩm</p>
                                    </div>
                                </a>
                                <div class="add-to-cart">
                                    <a class="btn btn-outline-light" href="#">Thêm vào giỏ hàng</a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="pagination">
                    <button class="pagination-button prev-button" onclick="changePage(-1)">Previous</button>
                    <button class="pagination-button next-button" onclick="changePage(1)">Next</button>
                </div>
            </div>
        </div>
    </section>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var currentPage = 1;
    var itemsPerPage = 20; // Giảm số sản phẩm mỗi trang để kiểm tra nhanh hơn

    function changePage(direction) {
        currentPage += direction;
        loadProducts(currentPage, itemsPerPage);
    }

    function applyFilters() {
        currentPage = 1;
        loadProducts(currentPage, itemsPerPage);
    }

    function loadProducts(page, itemsPerPage) {
        var urlParams = new URLSearchParams(window.location.search);
        var searchTerm = urlParams.get('searchTerm') || '';
        var priceMin = $('#priceMin').val() || 0;
        var priceMax = $('#priceMax').val() || 1000000;

        var postData = {
            searchTerm: searchTerm,
            priceMin: priceMin,
            priceMax: priceMax,
            page: page,
            itemsPerPage: itemsPerPage
        };

        var apiEndpoint = searchTerm ? "TimKiem.aspx/SearchProductsByName" : "TimKiem.aspx/FilterProductsByPrice";

        $.ajax({
            type: "POST",
            url: apiEndpoint,
            data: JSON.stringify(postData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                renderProducts(response.d);
            },
            error: function (response) {
                console.error("Failed to load products: ", response);
            }
        });
    }

    function renderProducts(products) {
        var productsHtml = "";
        $.each(products, function (index, product) {
            productsHtml += '<div class="card">';
            productsHtml += '    <a href="ChiTietSanPham.aspx?productId=' + product.product_id + '">';
            productsHtml += '        <img class="card-img-top" src="' + product.image + '" alt="Product Image" />';
            productsHtml += '        <div class="card-body">';
            productsHtml += '            <h5 class="product-name">' + product.name + '</h5>';
            productsHtml += '            <p class="product-price">$' + product.price.toFixed(2) + '</p>';
            productsHtml += '            <p class="stock-info">Còn lại: ' + product.stock + ' sản phẩm</p>';
            productsHtml += '        </div>';
            productsHtml += '    </a>';
            productsHtml += '    <div class="add-to-cart">';
            productsHtml += '        <a class="btn btn-outline-light" href="#">Thêm vào giỏ hàng</a>';
            productsHtml += '    </div>';
            productsHtml += '</div>';
        });

        $(".product-list").html(productsHtml);

        // Cập nhật trạng thái của các nút phân trang
        if (currentPage === 1) {
            $(".prev-button").attr("disabled", "disabled");
        } else {
            $(".prev-button").removeAttr("disabled");
        }

        if (products.length < itemsPerPage) {
            $(".next-button").attr("disabled", "disabled");
        } else {
            $(".next-button").removeAttr("disabled");
        }
    }

    $(document).ready(function () {
        loadProducts(currentPage, itemsPerPage);
    });


</script>
</asp:Content>
