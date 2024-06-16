<%@ Page Title="" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="Ecommerce_Client.GioHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #eaf6ff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .cart-header, .cart-item {
            display: grid;
            grid-template-columns: 1fr 2fr 1fr 1fr 1fr 1fr;
            padding: 10px;
            border-bottom: 1px solid #dee2e6;
            align-items: center;
        }

        .cart-header {
            background-color: #35b4a4;
            color: white;
            font-weight: bold;
            border-radius: 10px 10px 0 0;
        }

        .cart-item {
            background-color: #f7f7f7;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
            padding: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .cart-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .cart-item img {
            max-width: 80px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-info {
            display: flex;
            align-items: center;
        }

        .product-info img {
            margin-right: 15px;
        }

        .price, .quantity, .total, .remove, .select-product {
            text-align: center;
        }

        .quantity input {
            width: 50px;
            text-align: center;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 5px;
        }

        .remove button, .select-product input[type="checkbox"] {
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .remove button:hover, .select-product input[type="checkbox"]:hover {
            background: #c82333;
        }

        .cart-summary {
            display: flex;
            justify-content: flex-end;
            padding: 20px;
            margin-top: 20px;
            border-top: 1px solid #dee2e6;
            background-color: #35b4a4;
            border-radius: 0 0 10px 10px;
            color: white;
        }

        .cart-summary div {
            margin-left: 20px;
            font-size: 1.2em;
        }

        .checkout-btn {
            background: linear-gradient(145deg, #35b4a4, #018e82);
            border: none;
            color: white;
            padding: 15px 30px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }

        .checkout-btn:active {
            transform: translateY(0);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Giỏ hàng</h1>
    <div class="cart-header">
        <div>Chọn</div>
        <div>Sản phẩm</div>
        <div>Giá</div>
        <div>Số lượng</div>
        <div>Tổng</div>
        <div>Xóa</div>
    </div>

    <div class="cart-item">
        <div class="select-product">
            <input type="checkbox">
        </div>
        <div class="product-info">
            <img src="https://via.placeholder.com/100" alt="Sản phẩm">
            <span>Tên Sản Phẩm 1</span>
        </div>
        <div class="price">1,200,000 VND</div>
        <div class="quantity">
            <input type="number" value="1" min="1">
        </div>
        <div class="total">1,200,000 VND</div>
        <div class="remove">
            <button>Xóa</button>
        </div>
    </div>

    <div class="cart-item">
        <div class="select-product">
            <input type="checkbox">
        </div>
        <div class="product-info">
            <img src="https://via.placeholder.com/100" alt="Sản phẩm">
            <span>Tên Sản Phẩm 2</span>
        </div>
        <div class="price">800,000 VND</div>
        <div class="quantity">
            <input type="number" value="1" min="1">
        </div>
        <div class="total">800,000 VND</div>
        <div class="remove">
            <button>Xóa</button>
        </div>
    </div>

    <div class="cart-summary">
        <div>Tổng cộng: <strong>2,000,000 VND</strong></div>
        <div>
            <a href="ThanhToan.aspx" class="checkout-btn">Thanh toán</a>
        </div>
    </div>
</div>

</body>
</html>



</asp:Content>
