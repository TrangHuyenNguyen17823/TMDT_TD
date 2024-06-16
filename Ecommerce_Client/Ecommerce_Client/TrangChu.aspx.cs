using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Web.Services;
using Ecommerce_Client.Models; // Assuming you have a Product model

namespace Ecommerce_Client
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }


        [WebMethod]
        public static List<Product> SearchProducts(string searchTerm)
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            List<Product> products = dataUtils.SearchProducts(searchTerm);
            return products;
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {

        }
    }
}
