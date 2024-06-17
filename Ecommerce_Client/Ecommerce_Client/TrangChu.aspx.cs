using Ecommerce_Client.Models;
using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;

namespace Ecommerce_Client
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure user is logged in; redirect to login if not
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("DangNhap.aspx");
            }
        }
    }
}
