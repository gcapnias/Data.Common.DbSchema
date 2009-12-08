using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class OrderDetail
    {
        public OrderDetail()
        {  }

        #region ' Properties '

        // Primary Key
        private int _OrderID;
        public virtual int OrderID
        {
            get{ return _OrderID; }
            set{ _OrderID = value; }
        }

        // Primary Key
        private int _ProductID;
        public virtual int ProductID
        {
            get{ return _ProductID; }
            set{ _ProductID = value; }
        }

        private decimal _UnitPrice;
        public virtual decimal UnitPrice
        {
            get{ return _UnitPrice; }
            set{ _UnitPrice = value; }
        }

        private short _Quantity;
        public virtual short Quantity
        {
            get{ return _Quantity; }
            set{ _Quantity = value; }
        }

        private float _Discount;
        public virtual float Discount
        {
            get{ return _Discount; }
            set{ _Discount = value; }
        }

        // Many-To-One Relation
        private Order _Order;
        public virtual Order Order
        {
            get{ return _Order; }
            set{ _Order = value; }
        }


        // Many-To-One Relation
        private Product _Product;
        public virtual Product Product
        {
            get{ return _Product; }
            set{ _Product = value; }
        }


        #endregion

        #region ' Overrides '

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            return base.Equals(obj);
        }

        #endregion
    }
}

