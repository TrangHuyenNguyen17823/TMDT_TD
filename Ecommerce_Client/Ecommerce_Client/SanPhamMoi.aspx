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
        </div>
    </section>
</asp:Content>
