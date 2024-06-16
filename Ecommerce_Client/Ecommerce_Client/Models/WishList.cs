using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ecommerce_Client.Models
{
    public class WishList
    {
        public int wishlist_id { get; set; }
        public int customer_id { get; set; }
        public int product_id { get;set; }
    }
}