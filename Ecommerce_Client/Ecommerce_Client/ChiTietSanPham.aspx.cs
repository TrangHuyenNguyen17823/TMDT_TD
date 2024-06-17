using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using Ecommerce_Client.Models;

namespace Ecommerce_Client
{
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["productId"] != null)
                {
                    if (int.TryParse(Request.QueryString["productId"], out int productId))
                    {
                        LoadProductDetails(productId);
                        LoadRelatedProducts(productId);
                    }
                    else
                    {
                        Response.Redirect("TrangChu.aspx");
                    }
                }
            }
        }

        private void LoadProductDetails(int productId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM product WHERE product_id = @ProductId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        imgProduct.ImageUrl = reader["image"].ToString();
                        lblProductName.Text = reader["name"].ToString();
                        lblProductPrice.Text = string.Format("{0:C}", reader["price"]);
                        lblProductStock.Text = "Còn lại: " + reader["stock"].ToString() + " sản phẩm";
                        btnAddToCart.CommandArgument = productId.ToString();
                    }
                    else
                    {
                        Response.Redirect("TrangChu.aspx");
                    }
                }
                catch (Exception ex)
                {
                    // Log exception
                    Response.Redirect("TrangChu.aspx");
                }
            }
        }

        private void LoadRelatedProducts(int productId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 5 * FROM product WHERE category_id = (SELECT category_id FROM product WHERE product_id = @ProductId) AND product_id <> @ProductId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    rptRelatedProducts.DataSource = reader;
                    rptRelatedProducts.DataBind();
                }
                catch (Exception ex)
                {
                    // Log exception
                }
            }
        }

        protected void rptRelatedProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ChiTietSanPham.aspx?productId={productId}");
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int productId = GetProductIdFromQueryString();
            Product product = GetProductById(productId);

            if (product != null)
            {
                GioHangDataUtils.AddToCart(Context, product);
                Response.Redirect("GioHang.aspx");
            }
        }

        private int GetProductIdFromQueryString()
        {
            return int.TryParse(Request.QueryString["productId"], out int productId) ? productId : -1;
        }

        private Product GetProductById(int productId)
        {
            Product product = null;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM product WHERE product_id = @ProductId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    product = new Product
                    {
                        product_id = Convert.ToInt32(reader["product_id"]),
                        name = reader["name"].ToString(),
                        price = Convert.ToDecimal(reader["price"]),
                        stock = Convert.ToInt32(reader["stock"]),
                        image = reader["image"].ToString()
                    };
                }
            }
            return product;
        }

       
    }
}
