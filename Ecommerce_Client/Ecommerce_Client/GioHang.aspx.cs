using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class GioHang : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCartItems();
        }
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("DangNhap.aspx");
        }
    }

    private void BindCartItems()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("SELECT c.cart_id, p.product_name, p.price, c.quantity, (p.price * c.quantity) AS Total, p.image_url " +
                                            "FROM cart c JOIN product p ON c.product_id = p.product_id " +
                                            "WHERE c.customer_id = @CustomerId", conn);
            cmd.Parameters.AddWithValue("@CustomerId", /* Add logic to get the current customer ID */);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            cartRepeater.DataSource = reader;
            cartRepeater.DataBind();
        }
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int cartId = int.Parse(btn.CommandArgument);

        string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM cart WHERE cart_id = @CartId", conn);
            cmd.Parameters.AddWithValue("@CartId", cartId);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        BindCartItems();
    }
}
