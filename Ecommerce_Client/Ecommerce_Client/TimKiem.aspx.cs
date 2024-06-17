using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Web.Services;

namespace Ecommerce_Client
{
    public partial class TimKiem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("DangNhap.aspx");
            }
        }

        [WebMethod]
        public static List<Product> SearchProductsByName(string searchTerm, int page, int itemsPerPage)
        {
            try
            {
                TrangChuDataUtils dataUtils = new TrangChuDataUtils();
                List<Product> products = dataUtils.FilterProductsByName(searchTerm, page, itemsPerPage);
                return products;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception in SearchProductsByName: " + ex.Message);
                throw;
            }
        }

        [WebMethod]
        public static List<Product> FilterProductsByPrice(string searchTerm, decimal priceMin, decimal priceMax, int page, int itemsPerPage)
        {
            try
            {
                TrangChuDataUtils dataUtils = new TrangChuDataUtils();
                List<Product> products = dataUtils.FilterProductsByPrice(searchTerm, priceMin, priceMax, page, itemsPerPage);
                return products;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception in FilterProductsByPrice: " + ex.Message);
                throw;
            }
        }
    }
}
