using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Ecommerce_Client
{
    public class DienThoaiDataUtils
    {
        SqlConnection con;

        public DienThoaiDataUtils()
        {
            string sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True";
            con = new SqlConnection(sqlCon);
        }

        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();
            con.Open();
            string sql = "SELECT TOP 30* FROM product where category_id=1";
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


    }
}