using System;
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
            
        }

        [WebMethod]
        public static List<Product> GetProductsBestSelling(int page)
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            return dataUtils.GetBestSellingProducts(); // Mặc định lấy 20 sản phẩm mỗi trang
        }
    }
}
