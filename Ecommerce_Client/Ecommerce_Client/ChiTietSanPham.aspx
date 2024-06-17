<%@ Page Title="" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="Ecommerce_Client.ChiTietSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* CSS styles can be moved to an external CSS file for better organization */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .product-image {
            flex: 1;
            padding: 20px;
        }

        .product-image img {
            max-width: 100%;
            height: auto;
        }

        .product-details {
            flex: 1;
            padding: 20px;
        }

        .product-details .product-name {
            font-size: 24px;
            margin: 10px 0;
        }

        .product-details .product-price {
            font-size: 18px;
            color: #333;
        }

        .product-details .product-quantity {
            font-size: 16px;
            color: #666;
        }

        .add-to-cart-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-to-cart-btn:hover {
            background-color: #45a049;
        }

        .related-products {
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .related-products h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .product-card {
            display: flex;
            border: 1px solid #ddd;
            margin-bottom: 10px;
            padding: 10px;
            transition: transform 0.3s;
        }

        .product-card:hover {
            transform: scale(1.02);
        }

        .product-card img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            margin-right: 10px;
        }

        .product-card .product-name {
            font-size: 18px;
            margin: 5px 0;
        }

        .product-card .product-price {
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }

        .product-card .product-quantity {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }

        .product-card .add-to-cart-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .product-card .add-to-cart-btn:hover {
            background-color: #45a049;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="product-image">
            <asp:Image ID="imgProduct" runat="server" CssClass="product-image" />
        </div>
        <div class="product-details">
            <h1 class="product-name"><asp:Label ID="lblProductName" runat="server" CssClass="product-name"></asp:Label></h1>
            <p class="product-price"><asp:Label ID="lblProductPrice" runat="server" CssClass="product-price"></asp:Label></p>
            <p class="product-quantity"><asp:Label ID="lblProductStock" runat="server" CssClass="product-quantity"></asp:Label></p>
            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="add-to-cart-btn" OnClick="btnAddToCart_Click1"  />
        </div>
    </div>

    <div class="related-products">
        <h2>Related Products</h2>
        <asp:Repeater ID="rptRelatedProducts" runat="server" OnItemCommand="rptRelatedProducts_ItemCommand">
            <ItemTemplate>
                <div class="product-card">
                    <asp:Image ID="imgRelatedProduct" runat="server" CssClass="product-image" ImageUrl='<%# Eval("image") %>' />
                    <h3 class="product-name"><%# Eval("name") %></h3>
                    <p class="product-price"><%# string.Format("{0:C}", Eval("price")) %></p>
                    <p class="product-quantity">In Stock: <%# Eval("stock") %></p>
                    <asp:Button ID="btnAddToCartRelated" runat="server" Text="Add to Cart" CssClass="add-to-cart-btn"
                        CommandName="ViewDetails" CommandArgument='<%# Eval("product_id") %>' />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <script>
        // You can add JavaScript here if needed for dynamic behaviors
    </script>
</asp:Content>
