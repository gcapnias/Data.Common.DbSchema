using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class CustomerDemographic
    {
        public CustomerDemographic()
        {  }

        #region ' Properties '

        // Primary Key
        private string _CustomerTypeID;
        public virtual string CustomerTypeID
        {
            get{ return _CustomerTypeID; }
            set{ _CustomerTypeID = value; }
        }

        private string _CustomerDesc;
        public virtual string CustomerDesc
        {
            get{ return _CustomerDesc; }
            set{ _CustomerDesc = value; }
        }

        // Many-To-Many Relation
        private IList<Customer> _Customers = new List<Customer>();
        public virtual IList<Customer> Customers
        {
            get{ return _Customers; }
            set{ _Customers = value; }
        }

        #endregion

    }
}

