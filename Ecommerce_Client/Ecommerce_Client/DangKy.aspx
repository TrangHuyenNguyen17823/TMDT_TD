<%@ Page Title="Đăng ký" Language="C#" MasterPageFile="~/ClientPageMaster.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="Ecommerce_Client.DangKy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa; /* Màu nền xám nhạt */
        }
        .register-container {
            background-color: #fff; /* Nền trắng cho container */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 800px;
            margin: auto; /* Canh giữa trang */
            margin-top: 50px; /* Khoảng cách với phần trên cùng của trang */
            display: flex;
            justify-content: space-between; /* Canh bên trái và bên phải */
        }
        .register-container .left {
            flex: 1; /* Chiếm phần bằng nhau */
            margin-right: 20px; /* Khoảng cách với phần quảng cáo */
        }
        .register-container .right {
            flex: 1; /* Chiếm phần bằng nhau */
        }
        .register-container .left h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .register-container .left label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .register-container .left .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ced4da; /* Viền xám nhạt */
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box; /* Đảm bảo kích thước tính cả padding và border */
        }
        .register-container .left button {
            width: 100%;
            padding: 10px;
            background-color: #007bff; /* Màu nền xanh dương */
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s; /* Hiệu ứng chuyển màu khi hover */
        }
        .register-container .left button:hover {
            background-color: #0056b3; /* Màu xanh dương sâu khi hover */
        }
        .register-container .error-message {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }
        .register-container .right img {
            width: 100%;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn btn-primary{
            padding: 10px;
        }
        .btn btn-primary:hover{
            background-color: ActiveBorder deepskyblue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="register-container">
        <div class="left">
            <h2>Đăng ký - Ecommerce Nhóm 8</h2>
            <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" />
            
            <div>
                <label for="FirstName">Họ:</label>
                <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" Required="true" />
            </div>
            
            <div>
                <label for="LastName">Tên:</label>
                <asp:TextBox ID="LastName" runat="server" CssClass="form-control" Required="true" />
            </div>

            <div>
                <label for="Email">Email:</label>
                <asp:TextBox ID="Email" runat="server" TextMode="Email" CssClass="form-control" Required="true" />
            </div>

            <div>
                <label for="Password">Mật khẩu:</label>
                <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" Required="true" />
            </div>

            <div>
                <label for="ConfirmPassword">Nhập lại mật khẩu:</label>
                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" Required="true" />
            </div>

            <div>
                <label for="Address">Địa chỉ:</label>
                <asp:TextBox ID="Address" runat="server" CssClass="form-control" Required="true" />
            </div>

            <div>
                <label for="PhoneNumber">Số điện thoại:</label>
                <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control" Required="true" />
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" CssClass="btn btn-primary" OnClick="btnRegister_Click" Width="700px"  />
        </div>
        <div class="right">
            <!-- Ảnh quảng cáo -->
            <img src="homepageassets/imgs/a1.png" alt="Quảng cáo" />
        </div>
    </div>
</asp:Content>
