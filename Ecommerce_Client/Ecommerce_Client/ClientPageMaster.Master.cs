using System;


namespace Ecommerce_Client
{
    public partial class ClientPageMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                loginButton.Visible = false;
                userGreeting.Visible = true;
                logoutButton.Visible = true;
                userGreeting.InnerHtml = "Xin chào, " + Session["LastName"].ToString();
            }
            else
            {
                loginButton.Visible = true;
                userGreeting.Visible = false;
                logoutButton.Visible = false;
            }
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon(); 
            Response.Redirect("TrangChu.aspx"); 
        }
    }
}