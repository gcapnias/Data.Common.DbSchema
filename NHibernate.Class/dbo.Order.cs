using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Order
    {
        public Order()
        {  }

        #region ' Properties '

        // Primary Key
        private int _OrderID;
        public virtual int OrderID
        {
            get{ return _OrderID; }
            set{ _OrderID = value; }
        }

        private decimal? _Freight;
        public virtual decimal? Freight
        {
            get{ return _Freight; }
            set{ _Freight = value; }
        }

        private DateTime? _OrderDate;
        public virtual DateTime? OrderDate
        {
            get{ return _OrderDate; }
            set{ _OrderDate = value; }
        }

        private DateTime? _RequiredDate;
        public virtual DateTime? RequiredDate
        {
            get{ return _RequiredDate; }
            set{ _RequiredDate = value; }
        }

        private string _ShipAddress;
        public virtual string ShipAddress
        {
            get{ return _ShipAddress; }
            set{ _ShipAddress = value; }
        }

        private string _ShipCity;
        public virtual string ShipCity
        {
            get{ return _ShipCity; }
            set{ _ShipCity = value; }
        }

        private string _ShipCountry;
        public virtual string ShipCountry
        {
            get{ return _ShipCountry; }
            set{ _ShipCountry = value; }
        }

        private string _ShipName;
        public virtual string ShipName
        {
            get{ return _ShipName; }
            set{ _ShipName = value; }
        }

        private DateTime? _ShippedDate;
        public virtual DateTime? ShippedDate
        {
            get{ return _ShippedDate; }
            set{ _ShippedDate = value; }
        }

        private string _ShipPostalCode;
        public virtual string ShipPostalCode
        {
            get{ return _ShipPostalCode; }
            set{ _ShipPostalCode = value; }
        }

        private string _ShipRegion;
        public virtual string ShipRegion
        {
            get{ return _ShipRegion; }
            set{ _ShipRegion = value; }
        }

        // One-To-Many Relation
        private IList<OrderDetail> _OrderDetails = new List<OrderDetail>();
        public virtual IList<OrderDetail> OrderDetails
        {
            get{ return _OrderDetails; }
            set{ _OrderDetails = value; }
        }

        // Many-To-One Relation
        private Customer _Customer;
        public virtual Customer Customer
        {
            get{ return _Customer; }
            set{ _Customer = value; }
        }


        // Many-To-One Relation
        private Employee _Employee;
        public virtual Employee Employee
        {
            get{ return _Employee; }
            set{ _Employee = value; }
        }


        // Many-To-One Relation
        private Shipper _Shipper;
        public virtual Shipper Shipper
        {
            get{ return _Shipper; }
            set{ _Shipper = value; }
        }


        #endregion

    }
}

