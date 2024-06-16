using System;
using System.Data.SqlClient;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;

namespace Ecommerce_Client
{
    public class LoginDataUtils
    {
      
        SqlConnection con;
        public LoginDataUtils()
        {
            string sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True";
            con = new SqlConnection(sqlCon);
        }

        public bool checkValidUser(string email, string password)
        {
            con.Open();
            string sql = "select * from [customer] where email=@email and password=@password";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("email", email);
            cmd.Parameters.AddWithValue("password", password);
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.HasRows)
            {
                con.Close();
                return true;
            }
            con.Close();
            return false;
        }
    }
}
