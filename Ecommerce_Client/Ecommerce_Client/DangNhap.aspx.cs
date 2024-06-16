using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            string userName = uEmail.Text.ToString();
            string password = uPassword.Text.ToString();
            if (data.checkValidUser(userName, password))
            {
                Response.Redirect("/TrangChu.aspx");
            }
            else
            {
                Response.Redirect("/DangNhap.aspx");
            };
        }
    }
}