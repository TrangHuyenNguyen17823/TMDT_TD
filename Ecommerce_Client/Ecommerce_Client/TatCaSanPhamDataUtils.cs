using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Ecommerce_Client
{
    public class TatCaSanPhamDataUtils
    {
        SqlConnection con;

        public TatCaSanPhamDataUtils()
        {
            string sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True";
            con = new SqlConnection(sqlCon);
        }

        public List<Product> GetProductsPerPage(int page, int pageSize)
        {
            List<Product> products = new List<Product>();
            con.Open();

            int offset = (page - 1) * pageSize;

            try
            {
                string sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY product_id) AS RowNum, " +
                             "product_id, sku, name, price, stock, image, category_id " +
                             "FROM product) AS ProductsWithRowNum " +
                             $"WHERE RowNum > {offset} AND RowNum <= {offset + pageSize}";

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
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return products;
        }
    }
}
