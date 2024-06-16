using System;
using System.Collections.Generic;
using System.Web.Services;
using Ecommerce_Client.Models;

namespace Ecommerce_Client
{
    public partial class TatCaSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static List<Product> GetProducts(int page)
        {
            TatCaSanPhamDataUtils dataUtils = new TatCaSanPhamDataUtils();
            return dataUtils.GetProductsPerPage(page, 12); // Mặc định lấy 20 sản phẩm mỗi trang
        }
    }
}
