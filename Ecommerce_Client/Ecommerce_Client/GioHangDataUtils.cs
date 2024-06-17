using Ecommerce_Client.Models;
using System.Web;

namespace Ecommerce_Client
{
    public class GioHangDataUtils
    {
        private const string CartSessionKey = "Cart";

        // Get the cart from session or create a new one if not exists
        public static Cart GetCart(HttpContext context)
        {
            if (context.Session != null && context.Session[CartSessionKey] == null)
            {
                context.Session[CartSessionKey] = new Cart();
            }
            return (Cart)context.Session[CartSessionKey];
        }

        // Add a product to the cart
        public static void AddToCart(HttpContext context, Product product)
        {
            Cart cart = GetCart(context);
            cart.Add(product);
            context.Session[CartSessionKey] = cart;
        }

        // Remove a product from the cart
        public static void RemoveFromCart(HttpContext context, Product product)
        {
            Cart cart = GetCart(context);
            cart.Remove(product);
            context.Session[CartSessionKey] = cart;
        }

        // Update the quantity of a product in the cart
        public static void UpdateCart(HttpContext context, int productId, int quantity)
        {
            Cart cart = GetCart(context);
            cart.UpdateQuantity(productId, quantity);
            context.Session[CartSessionKey] = cart;
        }

        // Get the total number of items in the cart
        public static int GetCartItemCount(HttpContext context)
        {
            Cart cart = GetCart(context);
            return cart.ItemCount;
        }

        // Clear the cart
        public static void ClearCart(HttpContext context)
        {
            context.Session[CartSessionKey] = new Cart();
        }
    }
}
