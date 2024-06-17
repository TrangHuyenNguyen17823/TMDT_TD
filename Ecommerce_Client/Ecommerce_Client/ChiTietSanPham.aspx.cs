using System;
using System.Data.SqlClient;
using System.Configuration;
using Ecommerce_Client.Models;
using System.Web.UI.WebControls;

namespace Ecommerce_Client
{
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        SqlConnection con;

        public ChiTietSanPham()
        {
            string sqlCon = "Data Source=DESKTOP-GEKCIIL\\SQLEXPRESS;Initial Catalog=nhom8db;Integrated Security=True;Encrypt=False";
            con = new SqlConnection(sqlCon);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["productId"] != null)
                {
                    int productId;
                    if (int.TryParse(Request.QueryString["productId"], out productId))
                    {
                        LoadProductDetails(productId);
                    }
                    else
                    {
                        // Handle invalid productId
                    }
                }
            }
        }

        private void LoadProductDetails(int productId)
        {
            Product product = GetProductById(productId);
            if (product != null)
            {
                imgProduct.ImageUrl = product.image;
                lblProductName.Text = product.name;
                lblProductPrice.Text = string.Format("{0:C}", product.price);
                lblProductStock.Text = "In Stock: " + product.stock.ToString();
                btnAddToCart.CommandArgument = productId.ToString();
            }
            else
            {
                // Handle product not found
                Response.Redirect("Default.aspx");
            }
        }

        public Product GetProductById(int productId)
        {
            Product product = null;
            string query = "SELECT * FROM Products WHERE product_id = @productId";

            // Sử dụng đối tượng SqlConnection đã được khởi tạo ở constructor của lớp
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@product_id", productId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    product = new Product
                    {
                        product_id = Convert.ToInt32(reader["product_id"]),
                        name = Convert.ToString(reader["ProductName"]),
                        price = Convert.ToDecimal(reader["ProductPrice"]),
                        stock = Convert.ToInt32(reader["ProductStock"]),
                        image = Convert.ToString(reader["ProductImage"])
                    };
                }
                reader.Close();
            }
            return product;
        }


        protected void rptRelatedProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ChiTietSanPham.aspx?productId={productId}");
            }
        }

        protected void btnAddToCart_Click1(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32(btnAddToCart.CommandArgument);

        }
    }
}
