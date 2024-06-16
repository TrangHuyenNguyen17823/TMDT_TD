using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ecommerce_Client.Models
{
    public class TotalSold
    {
        public int product_id { get; set; }
        public string sku { get; set; }
        public decimal price { get; set; }
        public string image { get; set; }
        public string name { get; set; }
        public int stock { get; set; }
        public int total_sold { get; set; }
    }
}