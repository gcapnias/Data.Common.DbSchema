using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Customer
    {
        public Customer()
        {  }

        #region ' Properties '

        // Primary Key
        private string _CustomerID;
        public virtual string CustomerID
        {
            get{ return _CustomerID; }
            set{ _CustomerID = value; }
        }

        private string _Address;
        public virtual string Address
        {
            get{ return _Address; }
            set{ _Address = value; }
        }

        private string _City;
        public virtual string City
        {
            get{ return _City; }
            set{ _City = value; }
        }

        private string _CompanyName;
        public virtual string CompanyName
        {
            get{ return _CompanyName; }
            set{ _CompanyName = value; }
        }

        private string _ContactName;
        public virtual string ContactName
        {
            get{ return _ContactName; }
            set{ _ContactName = value; }
        }

        private string _ContactTitle;
        public virtual string ContactTitle
        {
            get{ return _ContactTitle; }
            set{ _ContactTitle = value; }
        }

        private string _Country;
        public virtual string Country
        {
            get{ return _Country; }
            set{ _Country = value; }
        }

        private string _Fax;
        public virtual string Fax
        {
            get{ return _Fax; }
            set{ _Fax = value; }
        }

        private string _Phone;
        public virtual string Phone
        {
            get{ return _Phone; }
            set{ _Phone = value; }
        }

        private string _PostalCode;
        public virtual string PostalCode
        {
            get{ return _PostalCode; }
            set{ _PostalCode = value; }
        }

        private string _Region;
        public virtual string Region
        {
            get{ return _Region; }
            set{ _Region = value; }
        }

        // One-To-Many Relation
        private IList<Order> _Orders = new List<Order>();
        public virtual IList<Order> Orders
        {
            get{ return _Orders; }
            set{ _Orders = value; }
        }

        // Many-To-Many Relation
        private IList<CustomerDemographic> _CustomerDemographics = new List<CustomerDemographic>();
        public virtual IList<CustomerDemographic> CustomerDemographics
        {
            get{ return _CustomerDemographics; }
            set{ _CustomerDemographics = value; }
        }

        #endregion

    }
}

