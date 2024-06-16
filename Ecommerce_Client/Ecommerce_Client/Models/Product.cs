using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Ecommerce_Client.Models
{
    public class Product
    {
        public int product_id { get; set; }
        public string sku { get; set; }
        public string name { get; set; }
        [Column(TypeName = "decimal(10,2)")]
        public decimal price { get; set; }
        public int stock { get; set; }
        public string image { get; set; }
        public int category_id { get; set; }
    }
}