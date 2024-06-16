<%@ Page Title="" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="Ecommerce_Client.DangNhap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Ecommerce Nhóm 8</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            display: block;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            display: flex;
            width: 90%;
            max-width: 1500px;
            background-image: url('homepageassets/imgs/a1.jpg');
            background-size: cover;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            margin: 50px;
        }

        .login-form {
            flex: 1;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.8); /* Màu nền mờ */
        }

        .login-form h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        .login-form label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .login-form .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
        }

        .login-form .login-button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-form .login-button:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 20px;
            display: none; /* Ẩn ban đầu */
        }

        /* Optional styling for the image */
        .login-container img {
            max-width: 100%;
            height: auto;
            object-fit: cover;
        }
    </style>
</head>
<body>
     <div class="login-container">
        <div class="login-form">
            <h2>Đăng nhập - Ecommerce Nhóm 8</h2>
            <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Text="Email hoặc mật khẩu không đúng!" Visible="false" />

            <div>
                <label for="Email">Email:</label>
                <asp:TextBox ID="uEmail" runat="server" CssClass="form-control" TextMode="Email" Required="true" />
            </div>

            <div>
                <label for="Password">Password:</label>
                <asp:TextBox ID="uPassword" runat="server" CssClass="form-control" TextMode="Password" Required="true" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="login-button" OnClick="btnLogin_Click" BackColor="#007bff" Width="300px" />
        </div>
        <img src="homepageassets/imgs/a2.png" alt="Placeholder Image" />
    </div>

    
</body>
</html>

</asp:Content>
