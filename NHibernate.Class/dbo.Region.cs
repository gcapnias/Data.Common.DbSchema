using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Region
    {
        public Region()
        {  }

        #region ' Properties '

        // Primary Key
        private int _RegionID;
        public virtual int RegionID
        {
            get{ return _RegionID; }
            set{ _RegionID = value; }
        }

        private string _RegionDescription;
        public virtual string RegionDescription
        {
            get{ return _RegionDescription; }
            set{ _RegionDescription = value; }
        }

        // One-To-Many Relation
        private IList<Territory> _Territories = new List<Territory>();
        public virtual IList<Territory> Territories
        {
            get{ return _Territories; }
            set{ _Territories = value; }
        }

        #endregion

    }
}

