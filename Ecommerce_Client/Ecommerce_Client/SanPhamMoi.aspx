<%@ Page Title="Sản Phẩm Mới" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="SanPhamMoi.aspx.cs" Inherits="Ecommerce_Client.SanPhamMoi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Add your styles here */
        .product-list {
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
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            width: calc(25% - 20px); /* Mỗi sản phẩm chiếm 25% chiều rộng và trừ khoảng cách giữa các sản phẩm */
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
    </section>
    <script>
        var currentPage = 1;
        var itemsPerPage = 20; // Số lượng sản phẩm mỗi trang

        function changePage(direction) {
            currentPage += direction;
            loadProducts(currentPage, itemsPerPage);
        }

        function loadProducts(page, itemsPerPage) {
            $.ajax({
                type: "POST",
                url: "SanPhamMoi.aspx/GetProductNew",
                data: JSON.stringify({ page: page, itemsPerPage: itemsPerPage }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var productsHtml = "";
                    $.each(response.d, function (index, product) {
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

                    // Disable/enable pagination buttons based on current page
                    if (currentPage === 1) {
                        $(".prev-button").attr("disabled", "disabled");
                    } else {
                        $(".prev-button").removeAttr("disabled");
                    }

                    // Kiểm tra nếu không còn sản phẩm nào trong trang tiếp theo thì disable nút next
                    if (response.d.length < itemsPerPage) {
                        $(".next-button").attr("disabled", "disabled");
                    } else {
                        $(".next-button").removeAttr("disabled");
                    }
                },
                error: function (response) {
                    console.error("Failed to load products: ", response);
                }
            });
        }

        $(document).ready(function () {
            loadProducts(currentPage, itemsPerPage);
        });
    </script>
</asp:Content>
