using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;

using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Data.Common.Tests
{
    /// <summary>
    /// Summary description for Views
    /// </summary>
    [TestClass]
    public class Views
    {
        string ConnectionName;
        string ProviderName;
        string viewSchema;

        public Views()
        {
            ConnectionName = Properties.Settings.Default.ConnectionName;
            ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;

            switch (ProviderName.ToLower())
            {
                case "mysql.data.mysqlclient":
                case "system.data.oracleclient":
                    viewSchema = "northwind";
                    break;

                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                case "system.data.sqlite":
                    viewSchema = null;
                    break;

                default:
                    viewSchema = "dbo";
                    break;
            }
        }

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        /// <summary>
        /// In this test we learned that the provider returns extra columns in views and commands
        /// The extra columns have the property IsHidden = true when using CommandBehavior.KeyInfo
        /// </summary>
        [TestMethod]
        public void GetViewColumnsCommandBehaviorKeyInfo()
        {
            string ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;
            DbProviderFactory provider = DbProviderFactories.GetFactory(ProviderName);
            DataTable viewColumns = new DataTable();

            string[] ProvidersWithNoViews = new string[] {
                "system.data.sqlserverce.3.5",
                "system.data.sqlserverce"
            };

            if (ProvidersWithNoViews.Contains(ProviderName.ToLower()))
                return;

            string viewName = "Alphabetical list of products";
            DbSchema schema = new DbSchema(ConnectionName);

            using (DbConnection connection = provider.CreateConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings[ConnectionName].ConnectionString;
                DbCommand command = connection.CreateCommand();
                command.CommandText = string.Format("SELECT * FROM {0}", schema.QualifiedTableName(viewSchema, viewName));
                command.CommandType = CommandType.Text;
                System.Console.WriteLine("SQL: " + command.CommandText);
                connection.Open();
                viewColumns = command.ExecuteReader(CommandBehavior.KeyInfo).GetSchemaTable();
                connection.Close();
            }

            DataRow[] realColumns;
            if (viewColumns.Columns.Contains("IsHidden"))
            {
                realColumns = viewColumns.Select("IsHidden = 0 OR IsHidden IS NULL");

                foreach (DataRow columnRow in realColumns)
                {
                    Console.WriteLine(columnRow["ColumnName"].ToString());
                }
            }
            else
            {
                realColumns = viewColumns.Select();
            }

            Assert.AreEqual(11, realColumns.Length);

        }

        /// <summary>
        /// In this test we learned that the provider does not return extra columns in views and commands
        /// when using CommandBehavior.SchemaOnly, but it does not return IsKey, IsAlliased, IsExpression
        /// </summary>
        [TestMethod]
        public void GetViewColumnsCommandBehaviorSchemaOnly()
        {
            string ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;
            DbProviderFactory provider = DbProviderFactories.GetFactory(ProviderName);
            DataTable viewColumns = new DataTable();

            string[] ProvidersWithNoViews = new string[] {
                "system.data.sqlserverce.3.5",
                "system.data.sqlserverce"
            };

            if (ProvidersWithNoViews.Contains(ProviderName.ToLower()))
                return;

            string viewName = "Alphabetical list of products";
            DbSchema schema = new DbSchema(ConnectionName);

            using (DbConnection connection = provider.CreateConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings[ConnectionName].ConnectionString;
                DbCommand command = connection.CreateCommand();
                command.CommandText = string.Format("SELECT * FROM {0}", schema.QualifiedTableName(viewSchema, viewName));
                command.CommandType = CommandType.Text;
                System.Console.WriteLine("SQL: " + command.CommandText);
                connection.Open();
                viewColumns = command.ExecuteReader(CommandBehavior.SchemaOnly).GetSchemaTable();
                connection.Close();
            }

            foreach (DataRow columnRow in viewColumns.Rows)
            {
                Console.WriteLine(columnRow["ColumnName"].ToString());
            }

            Assert.AreEqual(11, viewColumns.Rows.Count);

        }

        [TestMethod]
        public void GetViewColumnsBySchema()
        {
            string[] ProvidersWithNoViews = new string[] {
                "system.data.sqlserverce.3.5",
                "system.data.sqlserverce"
            };

            if (ProvidersWithNoViews.Contains(ProviderName.ToLower()))
                return;

            string viewName = "Alphabetical list of products";
            DbSchema schema = new DbSchema(ConnectionName);

            DataTable viewColumns = schema.GetTableColumns(viewSchema, viewName);

            foreach (DataRow columnRow in viewColumns.Rows)
            {
                Console.WriteLine(columnRow["ColumnName"].ToString());
            }

            Assert.AreEqual(11, viewColumns.Rows.Count);

        }
    }
}
