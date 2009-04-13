using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using NHibernate;
using NHibernate.Cfg;

namespace NHibernate.Application
{
    public class NHConfig
    {
        private static ISessionFactory _sessionFactory;

        static NHConfig()
        {
            try
            {
                Configuration config = new Configuration();
                config.Configure();
                _sessionFactory = config.BuildSessionFactory();
            }
            catch (Exception ex)
            {
                throw (ex); ;
            }

        }

        public static ISessionFactory GetSessionFactory()
        {
            return _sessionFactory;
        }
    }
}
