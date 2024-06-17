using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace Ecommerce_Client
{
    public class TrangChuDataUtils
    {
        SqlConnection con;

        public TrangChuDataUtils()
        {
            string sqlCon = "Data Source=DESKTOP-GEKCIIL\\SQLEXPRESS;Initial Catalog=nhom8db;Integrated Security=True;Encrypt=False";
            con = new SqlConnection(sqlCon);
        }

        public List<Category> GetCategories()
        {
            List<Category> categories = new List<Category>();

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM category", con))
            {
                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Category category = new Category();
                    category.category_id = Convert.ToInt32(rd["category_id"]);
                    category.category_name = rd["category_name"].ToString();
                    categories.Add(category);
                }
                rd.Close();
            }

            con.Close();
            return categories;
        }

        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            using (SqlCommand cmd = new SqlCommand("SELECT TOP 30 * FROM product", con))
            {
                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(rd["product_id"]);
                    product.sku = rd["sku"].ToString();
                    product.name = rd["name"].ToString();
                    product.price = Convert.ToDecimal(rd["price"]);
                    product.stock = Convert.ToInt32(rd["stock"]);
                    product.image = rd["image"].ToString();
                    product.category_id = Convert.ToInt32(rd["category_id"]);
                    products.Add(product);
                }
                rd.Close();
            }

            con.Close();
            return products;
        }

        public List<Product> GetProductNew(int page, int itemsPerPage)
        {
            List<Product> products = new List<Product>();

            int offset = (page - 1) * itemsPerPage;

            string sql = @"
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY product_id DESC) AS RowNum 
    FROM product 
    WHERE stock >= 25
) AS Sub 
WHERE RowNum BETWEEN @StartIndex AND @EndIndex";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@StartIndex", offset + 1);
                cmd.Parameters.AddWithValue("@EndIndex", offset + itemsPerPage);

                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(rd["product_id"]);
                    product.sku = rd["sku"].ToString();
                    product.name = rd["name"].ToString();
                    product.price = Convert.ToDecimal(rd["price"]);
                    product.stock = Convert.ToInt32(rd["stock"]);
                    product.image = rd["image"].ToString();
                    product.category_id = Convert.ToInt32(rd["category_id"]);
                    products.Add(product);
                }
                rd.Close();
            }

            con.Close();
            return products;
        }

        public List<Product> GetBestSellingProducts(int offset, int itemsPerPage)
        {
            List<Product> products = new List<Product>();

            string sql = @"
            SELECT * FROM (
                SELECT *, ROW_NUMBER() OVER (ORDER BY stock ASC) AS RowNum 
                FROM product 
                WHERE stock > 0 AND stock < 20
            ) AS Sub 
            WHERE RowNum BETWEEN @StartIndex AND @EndIndex";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@StartIndex", offset + 1);
                cmd.Parameters.AddWithValue("@EndIndex", offset + itemsPerPage);

                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(rd["product_id"]);
                    product.sku = rd["sku"].ToString();
                    product.name = rd["name"].ToString();
                    product.price = Convert.ToDecimal(rd["price"]);
                    product.stock = Convert.ToInt32(rd["stock"]);
                    product.image = rd["image"].ToString();
                    product.category_id = Convert.ToInt32(rd["category_id"]);
                    products.Add(product);
                }
                rd.Close();
            }

            con.Close();
            return products;
        }

        public List<Product> SearchProducts(string searchTerm)
        {
            List<Product> products = new List<Product>();

            string query = "SELECT * FROM product WHERE name LIKE @SearchTerm";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(reader["product_id"]);
                    product.sku = reader["sku"].ToString();
                    product.name = reader["name"].ToString();
                    product.price = Convert.ToDecimal(reader["price"]);
                    product.stock = Convert.ToInt32(reader["stock"]);
                    product.image = reader["image"].ToString();
                    product.category_id = Convert.ToInt32(reader["category_id"]);
                    products.Add(product);
                }

                reader.Close();
            }

            con.Close();
            return products;
        }

        public List<Product> FilterProductsByName(string searchTerm, int page, int itemsPerPage)
        {
            List<Product> products = new List<Product>();

            // Calculate offset for pagination
            int offset = (page - 1) * itemsPerPage;

            string query = @"
        SELECT * FROM (
            SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) AS RowNum 
            FROM product 
            WHERE name LIKE @SearchTerm
        ) AS Sub 
        WHERE RowNum BETWEEN @StartIndex AND @EndIndex";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                cmd.Parameters.AddWithValue("@StartIndex", offset + 1);
                cmd.Parameters.AddWithValue("@EndIndex", offset + itemsPerPage);

                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(rd["product_id"]);
                    product.sku = rd["sku"].ToString();
                    product.name = rd["name"].ToString();
                    product.price = Convert.ToDecimal(rd["price"]);
                    product.stock = Convert.ToInt32(rd["stock"]);
                    product.image = rd["image"].ToString();
                    product.category_id = Convert.ToInt32(rd["category_id"]);
                    products.Add(product);
                }
                rd.Close();
            }
            con.Close();
            return products;
        }

        public List<Product> FilterProductsByPrice(string searchTerm, decimal priceMin, decimal priceMax, int page, int itemsPerPage)
        {
            List<Product> products = new List<Product>();
            int offset = (page - 1) * itemsPerPage;
            string query = @"
        SELECT * FROM (
            SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) AS RowNum 
            FROM product 
            WHERE price >= @PriceMin AND price <= @PriceMax AND name LIKE @SearchTerm
        ) AS Sub 
        WHERE RowNum BETWEEN @StartIndex AND @EndIndex";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@PriceMin", priceMin);
                cmd.Parameters.AddWithValue("@PriceMax", priceMax);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                cmd.Parameters.AddWithValue("@StartIndex", offset + 1);
                cmd.Parameters.AddWithValue("@EndIndex", offset + itemsPerPage);

                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Product product = new Product();
                    product.product_id = Convert.ToInt32(rd["product_id"]);
                    product.sku = rd["sku"].ToString();
                    product.name = rd["name"].ToString();
                    product.price = Convert.ToDecimal(rd["price"]);
                    product.stock = Convert.ToInt32(rd["stock"]);
                    product.image = rd["image"].ToString();
                    product.category_id = Convert.ToInt32(rd["category_id"]);
                    products.Add(product);
                }
                rd.Close();
            }
            con.Close();
            return products;
        }
    }
}
