using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Web.Services;
using Ecommerce_Client.Models;

namespace Ecommerce_Client
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load all products when the page is first loaded
                LoadAllProducts();
            }
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("DangNhap.aspx");
            }
        }

        // Method to load all products initially or when needed
        private void LoadAllProducts()
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            List<Product> products = dataUtils.GetProducts();
            DisplayProducts(products);
        }

        // Server-side method to get products by category
        [WebMethod]
        public static List<Product> GetProductsByCategory(string category)
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            List<Product> products = dataUtils.GetProductsByCategory(category);
            return products;
        }

        // Server-side method to search products by name
        [WebMethod]
        public static List<Product> SearchProducts(string searchTerm)
        {
            TrangChuDataUtils dataUtils = new TrangChuDataUtils();
            List<Product> products = dataUtils.SearchProducts(searchTerm);
            return products;
        }

        // Method to display products in the UI
        private void DisplayProducts(List<Product> products)
        {
            string productsHtml = "";
            foreach (Product product in products)
            {
                productsHtml += $@"
                <div class='card'>
                    <a href='ChiTietSanPham.aspx?productId={product.product_id}'>
                        <img class='card-img-top' src='{product.image}' alt='Product Image' />
                        <div class='card-body'>
                            <h5 class='product-name'>{product.name}</h5>
                            <p class='product-price'>$ {product.price}</p>
                            <p class='stock-info'>Còn lại: {product.stock} sản phẩm</p>
                        </div>
                    </a>
                    <div class='add-to-cart'>
                        <a class='btn btn-outline-light' href='#'>Thêm vào giỏ hàng</a>
                    </div>
                </div>";
            }

        }
    }
}
