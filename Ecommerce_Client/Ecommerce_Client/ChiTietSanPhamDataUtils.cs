using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Ecommerce_Client.Models;
using Microsoft.SqlServer.Server; // Assuming you have a Product model

namespace Ecommerce_Client
{
    public class ChiTietSanPhamDataUtils
    {
        private SqlConnection con;
        private String sqlCon;

        public ChiTietSanPhamDataUtils()
        {
            // Initialize connection string (replace with your actual database connection details)
             sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True;Encrypt=False";

            con = new SqlConnection(sqlCon);
        }

        public Product GetProductById(int productId) 
        {
            Product product = null;

            // SQL query to retrieve product details by productId
            string query = "SELECT * FROM product WHERE ProductId = @ProductId";

            // Use 'using' statement to ensure resources are properly disposed
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductId", productId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    product = new Product();
                    product.product_id = Convert.ToInt32(reader["productId"]);
                    product.name = Convert.ToString(reader["productName"]);
                    product.price = Convert.ToDecimal(reader["productPrice"]);
                    product.stock = Convert.ToInt32(reader["productStock"]);
                    product.image = Convert.ToString(reader["productImage"]);
                    // Add more properties as needed
                }

                reader.Close();
            }

            con.Close();

            return product;
        }

        public List<Product> GetRelatedProducts(int categoryId, int productId, int limit = 4 )
        {
            List<Product> relatedProducts = new List<Product>();

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                string query = "SELECT TOP (@Limit) * FROM product WHERE category_id = @CategoryId AND product_id <> @ProductId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Limit", limit);
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Product product = new Product
                        {
                            product_id = Convert.ToInt32(reader["product_id"]),
                            name = Convert.ToString(reader["name"]),
                            price = Convert.ToDecimal(reader["price"]),
                            stock = Convert.ToInt32(reader["stock"]),
                            image = Convert.ToString(reader["image"]),
                            category_id = Convert.ToInt32(reader["category_id"])
                        };
                        relatedProducts.Add(product);
                    }
                    reader.Close();
                }
            }

            return relatedProducts;
        }

    }
}
