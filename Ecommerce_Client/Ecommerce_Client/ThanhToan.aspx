<%@ Page Title="" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="Ecommerce_Client.ThanhToan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('background-image.jpg');
            background-size: cover;
            background-position: center;
            filter: blur(5px);
            z-index: -1;
        }

        .container {
            width: 70%;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }

        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
            font-size: 2.5em;
            text-transform: uppercase;
            position: relative;
            font-weight: 700;
        }

        h1::before, h1::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 4px;
            background-color: #007bff;
            top: 50%;
            transform: translateY(-50%);
        }

        h1::before {
            left: -70px;
        }

        h1::after {
            right: -70px;
        }

        form {
            margin-top: 20px;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-group input:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .product-list {
            margin-bottom: 20px;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }

        .product-item img {
            max-width: 100px;
            margin-right: 20px;
            border-radius: 5px;
        }

        .product-info {
            flex: 1;
        }

        .product-info h3 {
            margin: 0;
            color: #333;
        }

        .product-info span {
            color: #666;
            display: block;
            margin-bottom: 5px;
        }

        .checkout-btn {
            display: block;
            margin-top: 20px;
            padding: 15px 0;
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
            width: 100%;
            box-sizing: border-box;
        }

        .checkout-btn:hover {
            background-color: #218838;
            transform: scale(1.02);
        }

        .total-amount {
            font-size: 1.5em;
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
            color: #ff5722;
        }

        .payment-methods {
            margin-top: 20px;
            text-align: center;
        }

        .payment-methods label {
            font-weight: bold;
            display: inline-block;
            cursor: pointer;
            padding: 10px 20px;
            border: 2px solid transparent;
            border-radius: 5px;
            transition: all 0.3s ease;
            margin-right: 10px;
            background-color: #f5f5f5;
        }

        .payment-methods label:hover {
            border-color: #007bff;
        }

        .payment-methods input[type="radio"] {
            display: none;
        }

        .payment-methods input[type="radio"]:checked + label {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
        }
    </style>
</head>
<body>

<div class="background"></div>
<div class="container">
    <h1>Thanh toán</h1>
    <form id="checkout-form" action="#">
        <div class="form-group">
            <label for="ho-ten">Họ và tên:</label>
            <input type="text" id="ho-ten" name="ho-ten" required>
        </div>
        <div class="form-group">
            <label for="so-dien-thoai">Số điện thoại:</label>
            <input type="tel" id="so-dien-thoai" name="so-dien-thoai" pattern="[0-9]{10,11}" required>
        </div>
        <div class="form-group">
            <label for="dia-chi">Địa chỉ:</label>
            <input type="text" id="dia-chi" name="dia-chi" required>
        </div>
        <div class="product-list">
            <div class="product-item">
                <img src="homepageassets/imgs/a2.png" alt="iPhone 12 Pro Max">
                <div class="product-info">
                    <h3>iPhone 12 Pro Max</h3>
                    <span>Số lượng: 1</span>
                    <span>Giá: $1,099</span>
                    <span>Thành tiền: $1,099</span>
                </div>
            </div>
            <div class="product-item">
                <img src="samsung.jpg" alt="Samsung Galaxy S21 Ultra">
                <div class="product-info">
                    <h3>Samsung Galaxy S21 Ultra</h3>
                    <span>Số lượng: 1</span>
                    <span>Giá: $1,199</span>
                    <span>Thành tiền: $1,199</span>
                </div>
            </div>
        </div>
        <div class="total-amount">
            Tổng tiền: $2,298
        </div>
        <div class="payment-methods">
            <input type="radio" id="tien-mat" name="phuong-thuc" value="tien-mat" required>
            <label for="tien-mat">Tiền mặt</label>
            <input type="radio" id="the-tin-dung" name="phuong-thuc" value="the-tin-dung">
            <label for="the-tin-dung">Thẻ tín dụng</label>
            <input type="radio" id="chuyen-khoan" name="phuong-thuc" value="chuyen-khoan">
            <label for="chuyen-khoan">Chuyển khoản</label>
        </div>
        <button type="submit" class="checkout-btn">Thanh toán</button>
    </form>
</div>

</body>
</html>

</asp:Content>
