using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;

namespace Ecommerce_Client
{
    public class TrangChuDataUtils
    {
        // Update your connection string as necessary
        string connectionString = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True;Encrypt=False";

        public List<Category> GetCategories()
        {
            List<Category> categories = new List<Category>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT * FROM category";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        Category category = new Category
                        {
                            category_id = Convert.ToInt32(rd["category_id"]),
                            category_name = rd["category_name"].ToString()
                        };
                        categories.Add(category);
                    }
                }
            }

            return categories;
        }

        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT TOP 30 * FROM product";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        Product product = new Product
                        {
                            product_id = Convert.ToInt32(rd["product_id"]),
                            sku = rd["sku"].ToString(),
                            name = rd["name"].ToString(),
                            price = Convert.ToDecimal(rd["price"]),
                            stock = Convert.ToInt32(rd["stock"]),
                            image = rd["image"].ToString(),
                            category_id = Convert.ToInt32(rd["category_id"])
                        };
                        products.Add(product);
                    }
                }
            }

            return products;
        }

       


        public List<Product> GetProductNew(int offset, int itemsPerPage)
        {
            List<Product> products = new List<Product>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();

                    string sql = @"
                        SELECT * FROM (
                            SELECT *, ROW_NUMBER() OVER (ORDER BY product_id DESC) AS RowNum 
                            FROM product 
                            WHERE stock >= 25
                        ) AS Sub 
                        WHERE RowNum BETWEEN @StartIndex AND @EndIndex";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@StartIndex", offset + 1);
                    cmd.Parameters.AddWithValue("@EndIndex", offset + itemsPerPage);

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        Product product = new Product
                        {
                            product_id = Convert.ToInt32(rd["product_id"]),
                            sku = rd["sku"].ToString(),
                            name = rd["name"].ToString(),
                            price = Convert.ToDecimal(rd["price"]),
                            stock = Convert.ToInt32(rd["stock"]),
                            image = rd["image"].ToString(),
                            category_id = Convert.ToInt32(rd["category_id"])
                        };
                        products.Add(product);
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions appropriately
                    Console.WriteLine("Error: " + ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }

            return products;
        }
        public List<Product> GetBestSellingProducts(int offset, int itemsPerPage)
        {
            List<Product> products = new List<Product>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();

                    string sql = @"
                        SELECT * FROM (
                            SELECT *, ROW_NUMBER() OVER (ORDER BY stock ASC) AS RowNum 
                            FROM product 
                            WHERE stock > 0 AND stock < 20
                        ) AS Sub 
                        WHERE RowNum BETWEEN @StartIndex AND @EndIndex
                    ";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@StartIndex", offset + 1);
                    cmd.Parameters.AddWithValue("@EndIndex", offset + itemsPerPage);

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        Product product = new Product
                        {
                            product_id = Convert.ToInt32(rd["product_id"]),
                            sku = rd["sku"].ToString(),
                            name = rd["name"].ToString(),
                            price = Convert.ToDecimal(rd["price"]),
                            stock = Convert.ToInt32(rd["stock"]),
                            image = rd["image"].ToString(),
                            category_id = Convert.ToInt32(rd["category_id"])
                        };
                        products.Add(product);
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions appropriately
                    Console.WriteLine("Error: " + ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }

            return products;
        }

        public List<Product> GetProductsByCategory(string category)
        {
            // Implement your data retrieval logic here
            // Example:
            List<Product> products = new List<Product>();
            // Add logic to fetch products based on category
            return products;
        }

        public List<Product> SearchProducts(string searchTerm)
        {
            // Filter products by search term
            return allProducts
                .Where(p => p.name.IndexOf(searchTerm, System.StringComparison.OrdinalIgnoreCase) >= 0)
                .ToList();
        }
    }
}
