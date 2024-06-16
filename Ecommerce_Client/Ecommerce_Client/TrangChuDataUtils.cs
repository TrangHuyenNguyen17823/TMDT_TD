using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace Ecommerce_Client
{
    public class TrangChuDataUtils
    {
        SqlConnection con;

        public TrangChuDataUtils()
        {
            string sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True";
            con = new SqlConnection(sqlCon);
        }

        public List<Category> GetCategories()
        {
            List<Category> categories = new List<Category>();
            con.Open();
            string sql = "SELECT * FROM category";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                Category category = new Category();
                category.category_id = Convert.ToInt32(rd["category_id"]);
                category.category_name = rd["category_name"].ToString();
                categories.Add(category);
            }
            con.Close();
            return categories;
        }


        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();
            con.Open();
            string sql = "SELECT TOP 30* FROM product";
            SqlCommand cmd = new SqlCommand(sql, con);
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
            con.Close();
            return products;
        }

        public List<Product> GetProductNew()
        {
            List<Product> products = new List<Product>();
            con.Open();
            string sql = "SELECT * FROM product WHERE stock > 800 ORDER BY stock DESC";
            SqlCommand cmd = new SqlCommand(sql, con);
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
            con.Close(); // Đóng kết nối sau khi sử dụng xong

            return products;
        }

        public List<Product> GetBestSellingProducts()
        {
            List<Product> products = new List<Product>();
            con.Open();
            string sql = "SELECT * FROM product WHERE stock < 25 ORDER BY stock ASC";
            SqlCommand cmd = new SqlCommand(sql, con);
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
            con.Close(); // Đóng kết nối sau khi sử dụng xong

            return products;
        }




        public List<Product> SearchProducts(string searchTerm)
        {
            List<Product> products = new List<Product>();

            string query = "SELECT * FROM Products WHERE productName LIKE @SearchTerm";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
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
                    products.Add(product);
                }

                reader.Close();
            }

            con.Close();

            return products;
        }


    }
}
