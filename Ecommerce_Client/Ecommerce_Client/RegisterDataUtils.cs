using System;
using System.Data.SqlClient;

namespace Ecommerce_Client
{
    public class RegisterDataUtils
    {
        SqlConnection con;

        public RegisterDataUtils()
        {
            string sqlCon = "Data Source=DESKTOP-I9SL2BR\\SQLEXPRESS04;Initial Catalog=nhom8db;Integrated Security=True";
            con = new SqlConnection(sqlCon);
        }

        public bool RegisterCustomer(string firstName, string lastName, string email, string password, string address, string phoneNumber)
        {
            // Kiểm tra password và re_password phải trùng nhau
            if (!PasswordMatch(password, password))
            {
                
                return false;
            }

            try
            {
                con.Open();
                string query = "INSERT INTO customer (first_name, last_name, email, password, address, phone_number) VALUES (@FirstName, @LastName, @Email, @Password, @Address, @PhoneNumber)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                // Xử lý các ngoại lệ, ví dụ: ghi log, thông báo lỗi, ...
                Console.WriteLine("Error: " + ex.Message);
                return false;
            }
            finally
            {
                con.Close();
            }
        }

        private bool PasswordMatch(string password, string rePassword)
        {
            return password == rePassword;
        }
    }
}
