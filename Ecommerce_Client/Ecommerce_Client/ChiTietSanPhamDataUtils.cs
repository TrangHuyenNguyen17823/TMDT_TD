using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Ecommerce_Client.Models; // Assuming you have a Product model

namespace Ecommerce_Client
{
    public class ChiTietSanPhamDataUtils
    {
        private SqlConnection con;

        public ChiTietSanPhamDataUtils()
        {
            // Initialize connection string (replace with your actual database connection details)
            string sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True";
            con = new SqlConnection(sqlCon);
        }

        public Product GetProductById(int productId) 
        {
            Product product = null;

            // SQL query to retrieve product details by productId
            string query = "SELECT * FROM Products WHERE ProductId = @ProductId";

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

        public List<Product> GetRelatedProducts(int categoryId, int productId, int limit = 5)
        {
            List<Product> relatedProducts = new List<Product>();

            // SQL query to retrieve related products based on category and excluding the current product
            string query = "SELECT TOP 5 * FROM Products WHERE CategoryId = @CategoryId AND ProductId != @ProductId";

            // Use 'using' statement to ensure resources are properly disposed
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Limit", limit);
                cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(reader["productId"]);
                    product.name = Convert.ToString(reader["productName"]);
                    product.price = Convert.ToDecimal(reader["productPrice"]);
                    product.stock = Convert.ToInt32(reader["productStock"]);
                    product.image = Convert.ToString(reader["productImage"]);
                    // Add more properties as needed
                    relatedProducts.Add(product);
                }

                reader.Close();
            }

            con.Close();

            return relatedProducts;
        }
    }
}
