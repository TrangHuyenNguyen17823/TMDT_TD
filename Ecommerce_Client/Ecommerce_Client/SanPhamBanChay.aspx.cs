using Ecommerce_Client.Models;
using System.Collections.Generic;
using System;

namespace Ecommerce_Client
{
    public partial class SanPhamBanChay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Không cần thêm mã này vào đây, vì phần giao diện sẽ tự động thêm vào.
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("DangNhap.aspx");
            }
        }

        [System.Web.Services.WebMethod]
        public static List<Product> GetProductsBestSelling(int page)
        {
            int itemsPerPage = 50; // Số lượng sản phẩm mỗi trang
            int offset = (page - 1) * itemsPerPage;

            // Sử dụng TrangChuDataUtils để lấy dữ liệu từ CSDL
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            List<Product> products = dataUtils.GetBestSellingProducts(offset, itemsPerPage);

            return products;
        }
    }
}
