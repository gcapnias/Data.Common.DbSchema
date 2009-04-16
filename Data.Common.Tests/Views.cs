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
        const string ConnectionName = "Northwind";

        public Views()
        {
            //
            // TODO: Add constructor logic here
            //
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
            string viewSchema = "dbo";
            string viewName = "Alphabetical list of products";
            DbSchema schema = new DbSchema(ConnectionName);

            string ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;
            DbProviderFactory provider = DbProviderFactories.GetFactory(ProviderName);
            DataTable viewColumns = new DataTable();
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
            DataRow[] realColumns = viewColumns.Select("IsHidden = 0");
            Assert.AreEqual(11, realColumns.Length);

            foreach (DataRow columnRow in realColumns)
            {
                Console.WriteLine(columnRow["ColumnName"].ToString());
            }
        }

        /// <summary>
        /// In this test we learned that the provider does not return extra columns in views and commands
        /// when using CommandBehavior.SchemaOnly, but it does not return IsKey, IsAlliased, IsExpression
        /// </summary>
        [TestMethod]
        public void GetViewColumnsCommandBehaviorSchemaOnly()
        {
            string viewSchema = "dbo";
            string viewName = "Alphabetical list of products";
            DbSchema schema = new DbSchema(ConnectionName);

            string ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;
            DbProviderFactory provider = DbProviderFactories.GetFactory(ProviderName);
            DataTable viewColumns = new DataTable();
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
            Assert.AreEqual(11, viewColumns.Rows.Count);

            foreach (DataRow columnRow in viewColumns.Rows)
            {
                Console.WriteLine(columnRow["ColumnName"].ToString());
            }
        }

        [TestMethod]
        public void GetViewColumnsBySchema()
        {
            string viewSchema = "dbo";
            string viewName = "Alphabetical list of products";
            DbSchema schema = new DbSchema(ConnectionName);

            DataTable viewColumns = schema.GetTableColumns(viewSchema, viewName);
            Assert.AreEqual(11, viewColumns.Rows.Count);
            foreach (DataRow columnRow in viewColumns.Rows)
            {
                Console.WriteLine(columnRow["ColumnName"].ToString());
            }

        }
    }
}
