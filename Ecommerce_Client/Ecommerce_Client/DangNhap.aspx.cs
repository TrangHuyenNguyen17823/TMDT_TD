using System;
using System.Web.UI;

namespace Ecommerce_Client
{
    public partial class DangNhap : System.Web.UI.Page
    {
        LoginDataUtils data = new LoginDataUtils();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = uEmail.Text.Trim(); 
            string password = uPassword.Text; 

            
            if (data.checkValidUser(userName, password))
            {
                Session["UserEmail"] = userName;
                string lastName = data.GetLastName(userName);
                Session["LastName"] = lastName;
                Server.Transfer("/TrangChu.aspx");
            }
            else
            {
                Session.Clear();
                Server.Transfer("/DangNhap.aspx?login=failed");
            }
        }
    }
}
