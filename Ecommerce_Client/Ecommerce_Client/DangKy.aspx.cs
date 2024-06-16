using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce_Client
{
    public partial class DangKy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = FirstName.Text.Trim();
            string lastName = LastName.Text.Trim();
            string email = Email.Text.Trim();
            string password = Password.Text;
            string confirmPassword = ConfirmPassword.Text;
            string address = Address.Text.Trim();
            string phoneNumber = PhoneNumber.Text.Trim();

            RegisterDataUtils registerUtils = new RegisterDataUtils();

            // Kiểm tra các điều kiện hợp lệ trước khi thực hiện đăng ký
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword) || string.IsNullOrEmpty(address) ||
                string.IsNullOrEmpty(phoneNumber))
            {
                ErrorMessage.Text = "Vui lòng nhập đầy đủ thông tin.";
                return;
            }

            if (password != confirmPassword)
            {
                ErrorMessage.Text = "Mật khẩu và nhập lại mật khẩu không khớp.";
                return;
            }

            // Thực hiện đăng ký
            bool registerSuccess = registerUtils.RegisterCustomer(firstName, lastName, email, password, address, phoneNumber);

            if (registerSuccess)
            {
                ErrorMessage.Text = "Đăng ký thành công!";
                // Xóa các trường dữ liệu sau khi đăng ký thành công
                FirstName.Text = "";
                LastName.Text = "";
                Email.Text = "";
                Password.Text = "";
                ConfirmPassword.Text = "";
                Address.Text = "";
                PhoneNumber.Text = "";
            }
            else
            {
                ErrorMessage.Text = "Đăng ký thất bại. Vui lòng thử lại sau.";
            }
        }

    }
}
