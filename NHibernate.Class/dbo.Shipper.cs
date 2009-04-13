using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Shipper
    {
        public Shipper()
        {  }

        #region ' Properties '

        // Primary Key
        private int _ShipperID;
        public virtual int ShipperID
        {
            get{ return _ShipperID; }
            set{ _ShipperID = value; }
        }

        private string _CompanyName;
        public virtual string CompanyName
        {
            get{ return _CompanyName; }
            set{ _CompanyName = value; }
        }

        private string _Phone;
        public virtual string Phone
        {
            get{ return _Phone; }
            set{ _Phone = value; }
        }

        // One-To-Many Relation
        private IList<Order> _Orders = new List<Order>();
        public virtual IList<Order> Orders
        {
            get{ return _Orders; }
            set{ _Orders = value; }
        }

        #endregion

    }
}

