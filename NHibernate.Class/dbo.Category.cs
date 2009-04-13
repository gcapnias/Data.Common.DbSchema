using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Category
    {
        public Category()
        {  }

        #region ' Properties '

        // Primary Key
        private int _CategoryID;
        public virtual int CategoryID
        {
            get{ return _CategoryID; }
            set{ _CategoryID = value; }
        }

        private string _CategoryName;
        public virtual string CategoryName
        {
            get{ return _CategoryName; }
            set{ _CategoryName = value; }
        }

        private string _Description;
        public virtual string Description
        {
            get{ return _Description; }
            set{ _Description = value; }
        }

        private byte[] _Picture;
        public virtual byte[] Picture
        {
            get{ return _Picture; }
            set{ _Picture = value; }
        }

        // One-To-Many Relation
        private IList<Product> _Products = new List<Product>();
        public virtual IList<Product> Products
        {
            get{ return _Products; }
            set{ _Products = value; }
        }

        #endregion

    }
}

