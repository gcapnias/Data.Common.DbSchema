using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using NHibernate.Cfg;
using Northwind;

namespace NHibernate.Application
{
    class Program
    {
        static void Main(string[] args)
        {
            ISession _session = NHConfig.GetSessionFactory().OpenSession();

            IList products = _session.CreateQuery("select from Product").List();
            foreach (Product prod in products)
            {
                Console.WriteLine("Category  : " + prod.Category.CategoryName);
                Console.WriteLine("Product ID: " + prod.ProductID.ToString());
                Console.WriteLine("Product   : " + prod.ProductName);
            }

            _session.Disconnect();
            _session.Close();
            Console.ReadKey();

        }
    }
}
