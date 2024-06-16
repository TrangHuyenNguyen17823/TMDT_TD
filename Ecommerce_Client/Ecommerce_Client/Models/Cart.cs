using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ecommerce_Client.Models
{
    public class Cart
    {
        public int cart_id {  get; set; }
        public int quantity { get; set; }
        public int customer_id { get; set;}
        public int product_id { get; set; }
    }
}