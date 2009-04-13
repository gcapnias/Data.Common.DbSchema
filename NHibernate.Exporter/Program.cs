using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using NHibernate.Cfg;
using Northwind;
using NHibernate.Tool.hbm2ddl;

namespace NHibernate.Exporter
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Configuration config = new Configuration().Configure();
                SchemaExport exporter = new SchemaExport(config);
                exporter.Execute(true, true, false, true);
            }
            catch (Exception ex)
            {
                System.Console.Error.Write(ex.ToString());
            }
        }
    }
}
