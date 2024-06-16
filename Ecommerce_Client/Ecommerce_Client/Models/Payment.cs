using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Ecommerce_Client.Models
{
    public class Payment
    {
        public int payment_id { get; set; }
        public DateTime payment_date { get; set; }
        public string payment_method { get; set; }
        public string amount { get; set; }
        [Column(TypeName ="decimal(10,2)" )]
        public int customer_id { get; set; }
    }
}