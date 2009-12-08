using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Northwind
{
    public partial class Employee
    {
        public Employee()
        {  }

        #region ' Properties '

        // Primary Key
        private int _EmployeeID;
        public virtual int EmployeeID
        {
            get{ return _EmployeeID; }
            set{ _EmployeeID = value; }
        }

        private string _LastName;
        public virtual string LastName
        {
            get{ return _LastName; }
            set{ _LastName = value; }
        }

        private string _FirstName;
        public virtual string FirstName
        {
            get{ return _FirstName; }
            set{ _FirstName = value; }
        }

        private string _Title;
        public virtual string Title
        {
            get{ return _Title; }
            set{ _Title = value; }
        }

        private string _TitleOfCourtesy;
        public virtual string TitleOfCourtesy
        {
            get{ return _TitleOfCourtesy; }
            set{ _TitleOfCourtesy = value; }
        }

        private DateTime? _BirthDate;
        public virtual DateTime? BirthDate
        {
            get{ return _BirthDate; }
            set{ _BirthDate = value; }
        }

        private DateTime? _HireDate;
        public virtual DateTime? HireDate
        {
            get{ return _HireDate; }
            set{ _HireDate = value; }
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

        private string _Region;
        public virtual string Region
        {
            get{ return _Region; }
            set{ _Region = value; }
        }

        private string _PostalCode;
        public virtual string PostalCode
        {
            get{ return _PostalCode; }
            set{ _PostalCode = value; }
        }

        private string _Country;
        public virtual string Country
        {
            get{ return _Country; }
            set{ _Country = value; }
        }

        private string _HomePhone;
        public virtual string HomePhone
        {
            get{ return _HomePhone; }
            set{ _HomePhone = value; }
        }

        private string _Extension;
        public virtual string Extension
        {
            get{ return _Extension; }
            set{ _Extension = value; }
        }

        private byte[] _Photo;
        public virtual byte[] Photo
        {
            get{ return _Photo; }
            set{ _Photo = value; }
        }

        private string _Notes;
        public virtual string Notes
        {
            get{ return _Notes; }
            set{ _Notes = value; }
        }

        private string _PhotoPath;
        public virtual string PhotoPath
        {
            get{ return _PhotoPath; }
            set{ _PhotoPath = value; }
        }

        // One-To-Many Relation
        private IList<Employee> _Employees = new List<Employee>();
        public virtual IList<Employee> Employees
        {
            get{ return _Employees; }
            set{ _Employees = value; }
        }

        // One-To-Many Relation
        private IList<Order> _Orders = new List<Order>();
        public virtual IList<Order> Orders
        {
            get{ return _Orders; }
            set{ _Orders = value; }
        }

        // Many-To-One Relation
        private Employee _EmployeeMember;
        public virtual Employee EmployeeMember
        {
            get{ return _EmployeeMember; }
            set{ _EmployeeMember = value; }
        }


        // Many-To-Many Relation
        private IList<Territory> _Territories = new List<Territory>();
        public virtual IList<Territory> Territories
        {
            get{ return _Territories; }
            set{ _Territories = value; }
        }

        #endregion

    }
}

