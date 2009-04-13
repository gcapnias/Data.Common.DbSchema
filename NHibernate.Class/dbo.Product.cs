using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Product
    {
        public Product()
        {  }

        #region ' Properties '

        // Primary Key
        private int _ProductID;
        public virtual int ProductID
        {
            get{ return _ProductID; }
            set{ _ProductID = value; }
        }

        private bool _Discontinued;
        public virtual bool Discontinued
        {
            get{ return _Discontinued; }
            set{ _Discontinued = value; }
        }

        private string _ProductName;
        public virtual string ProductName
        {
            get{ return _ProductName; }
            set{ _ProductName = value; }
        }

        private string _QuantityPerUnit;
        public virtual string QuantityPerUnit
        {
            get{ return _QuantityPerUnit; }
            set{ _QuantityPerUnit = value; }
        }

        private short? _ReorderLevel;
        public virtual short? ReorderLevel
        {
            get{ return _ReorderLevel; }
            set{ _ReorderLevel = value; }
        }

        private decimal? _UnitPrice;
        public virtual decimal? UnitPrice
        {
            get{ return _UnitPrice; }
            set{ _UnitPrice = value; }
        }

        private short? _UnitsInStock;
        public virtual short? UnitsInStock
        {
            get{ return _UnitsInStock; }
            set{ _UnitsInStock = value; }
        }

        private short? _UnitsOnOrder;
        public virtual short? UnitsOnOrder
        {
            get{ return _UnitsOnOrder; }
            set{ _UnitsOnOrder = value; }
        }

        // One-To-Many Relation
        private IList<OrderDetail> _OrderDetails = new List<OrderDetail>();
        public virtual IList<OrderDetail> OrderDetails
        {
            get{ return _OrderDetails; }
            set{ _OrderDetails = value; }
        }

        // Many-To-One Relation
        private Category _Category;
        public virtual Category Category
        {
            get{ return _Category; }
            set{ _Category = value; }
        }


        // Many-To-One Relation
        private Supplier _Supplier;
        public virtual Supplier Supplier
        {
            get{ return _Supplier; }
            set{ _Supplier = value; }
        }


        #endregion

    }
}

