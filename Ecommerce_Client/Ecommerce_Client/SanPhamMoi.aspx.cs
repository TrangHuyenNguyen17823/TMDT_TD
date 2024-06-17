﻿using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.UI;
using Ecommerce_Client.Models; // Adjust the namespace as per your project structure

namespace Ecommerce_Client
{
    public partial class SanPhamMoi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductRepeater(1, 20); // Mặc định hiển thị trang 1 với 20 sản phẩm mỗi trang
            }
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("DangNhap.aspx");
            }
        }

        [WebMethod]
        public static List<Product> GetProductNew(int page, int itemsPerPage)
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            return dataUtils.GetProductNew(page, itemsPerPage);
        }

        private void BindProductRepeater(int page, int itemsPerPage)
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            List<Product> products = dataUtils.GetProductNew(page, itemsPerPage);
            productsRepeater.DataSource = products;
            productsRepeater.DataBind();
        }
    }
}