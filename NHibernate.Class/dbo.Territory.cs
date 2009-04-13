using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Territory
    {
        public Territory()
        {  }

        #region ' Properties '

        // Primary Key
        private string _TerritoryID;
        public virtual string TerritoryID
        {
            get{ return _TerritoryID; }
            set{ _TerritoryID = value; }
        }

        private string _TerritoryDescription;
        public virtual string TerritoryDescription
        {
            get{ return _TerritoryDescription; }
            set{ _TerritoryDescription = value; }
        }

        // Many-To-One Relation
        private Region _Region;
        public virtual Region Region
        {
            get{ return _Region; }
            set{ _Region = value; }
        }


        // Many-To-Many Relation
        private IList<Employee> _Employees = new List<Employee>();
        public virtual IList<Employee> Employees
        {
            get{ return _Employees; }
            set{ _Employees = value; }
        }

        #endregion

    }
}

