using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce_Client
{
    public partial class SanPhamBanChay : System.Web.UI.Page
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