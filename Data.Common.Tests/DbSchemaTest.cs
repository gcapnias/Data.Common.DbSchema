using System.Configuration;
using System.Data;
using System.Data.Common;
using Microsoft.VisualStudio.TestTools.UnitTesting;

using Data.Common;

namespace Data.Common.Tests
{    
    /// <summary>
    ///This is a test class for DbSchemaTest and is intended
    ///to contain all DbSchemaTest Unit Tests
    ///</summary>
    [TestClass()]
    public class DbSchemaTest
    {
        const string connectionname = "Northwind";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "dbo";
        string procedureSchema = "dbo";


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

        #region ' Additional test attributes '
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for ProviderName
        ///</summary>
        [TestMethod()]
        public void ProviderNameTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string actual = target.ProviderName;
            Assert.AreEqual(providername, actual);
        }

        /// <summary>
        ///A test for ConnectionString
        ///</summary>
        [TestMethod()]
        public void ConnectionStringTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string actual = target.ConnectionString;
            Assert.AreEqual(connectionstring, actual);
        }

        /// <summary>
        ///A test for ConnectionName
        ///</summary>
        [TestMethod()]
        public void ConnectionNameTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string actual = target.ConnectionName;
            Assert.AreEqual(connectionname, actual);
        }

        /// <summary>
        ///A test for GetViews
        ///</summary>
        [TestMethod()]
        public void GetViewsTest()
        {
            DbSchema target = new DbSchema(connectionname);
            DataTable actual = target.GetViews();
            Assert.AreEqual(16, actual.Rows.Count);

            System.Console.WriteLine("Views in database");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("View: {0}", relationRow["TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTablesManyToManyRelations
        ///</summary>
        [TestMethod()]
        public void GetTablesManyToManyRelationsTest()
        {
            DbSchema target = new DbSchema(connectionname);
            DataTable actual = target.GetTablesManyToManyRelations();
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Τables that belong to manytomany relations");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("ManyToMany Relation: {0}", relationRow["TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTablesLogical
        ///</summary>
        [TestMethod()]
        public void GetTablesLogicalTest()
        {
            DbSchema target = new DbSchema(connectionname);
            DataTable actual = target.GetTablesLogical();
            Assert.AreEqual(11, actual.Rows.Count);

            System.Console.WriteLine("Logical tables (w/o manytomany tables");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTables
        ///</summary>
        [TestMethod()]
        public void GetTablesTest()
        {
            DbSchema target = new DbSchema(connectionname);
            DataTable actual = target.GetTables();
            Assert.AreEqual(13, actual.Rows.Count);

            System.Console.WriteLine("Tables in database");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("View: {0}", relationRow["TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTablePrimaryKeys
        ///</summary>
        [TestMethod()]
        public void GetTablePrimaryKeysTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string tableName = "EmployeeTerritories";
            DataTable actual = target.GetTablePrimaryKeyColumns(tableSchema, tableName);
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Primary key columns in table");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Column: {0}", relationRow["ColumnName"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableOneToManyRelations
        ///</summary>
        [TestMethod()]
        public void GetTableOneToManyRelationsTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string tableName = "Employees";
            DataTable actual = target.GetTableOneToManyRelations(tableSchema, tableName);
            Assert.AreEqual(3, actual.Rows.Count);

            System.Console.WriteLine("One to many relations in table");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["FK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableManyToOneRelations
        ///</summary>
        [TestMethod()]
        public void GetTableManyToOneRelationsTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string tableName = "EmployeeTerritories"; // TODO: Initialize to an appropriate value
            DataTable actual = target.GetTableManyToOneRelations(tableSchema, tableName);
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Many to one relations in table");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["PK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableFields
        ///</summary>
        [TestMethod()]
        public void GetTableFieldsTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string tableName = "Employees";
            DataTable actual = target.GetTableFields(tableSchema, tableName);
            Assert.AreEqual(16, actual.Rows.Count);

            System.Console.WriteLine("Columns in table that do not represent relations or primary keys");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Column: {0}", relationRow["ColumnName"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void GetTableColumnsTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string tableName = "Employees";
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);

            System.Console.WriteLine("All columns in table");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Column: {0}", relationRow["ColumnName"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void GetSchemaTablesTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(connectionname);
            DataTable actual = target.GetSchemaTables();
            Assert.AreEqual(29, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaProvider
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void GetSchemaProviderTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(connectionname);
            DbSchemaProvider actual = target.GetSchemaProvider(connectionstring, providername);
            Assert.AreEqual("Data.Common.SqlServerSchemaProvider", actual.GetType().ToString());
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void GetProceduresTest()
        {
            DbSchema target = new DbSchema(connectionname);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(7, actual.Rows.Count);

            System.Console.WriteLine("Procedures in database");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Procedure: {0}", relationRow["ROUTINE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void GetProcedureParametersTest()
        {
            DbSchema target = new DbSchema(connectionname);
            string procedureName = "CustOrderHist";
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);
            Assert.AreEqual(1, actual.Rows.Count);

            System.Console.WriteLine("Parmeters in Procedure");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Parameter: {0}", relationRow["PARAMETER_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void GetConstraintsTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(connectionname);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for DiscoverManyToManyTables
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DiscoverManyToManyTablesTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(connectionname);
            target.DiscoverManyToManyTables();
            Assert.AreEqual(target.GetTables().Rows.Count, target.GetTablesLogical().Rows.Count + target.GetTablesManyToManyRelations().Rows.Count);
        }

        /// <summary>
        ///A test for DbSchema Constructor
        ///</summary>
        //[TestMethod()]
        //public void DbSchemaConstructorTest()
        //{
        //    DbSchema target = new DbSchema();
        //    DataTable tables = target.GetTables();
        //    Assert.IsNotNull(target);
        //    Assert.AreEqual(true, tables.Rows.Count > 0);
        //}

        /// <summary>
        ///A test for DbSchema Constructor
        ///</summary>
        [TestMethod()]
        public void DbSchemaConstructorTest1()
        {
            DbSchema target = new DbSchema(connectionname);
            DataTable tables = target.GetTables();
            Assert.IsNotNull(target);
            Assert.AreEqual(13, tables.Rows.Count);
        }

        /// <summary>
        ///A test for DbSchema Constructor
        ///</summary>
        [TestMethod()]
        public void DbSchemaConstructorTest2()
        {
            DbSchema target = new DbSchema(connectionstring, providername);
            DataTable tables = target.GetTables();
            Assert.IsNotNull(target);
            Assert.AreEqual(13, tables.Rows.Count);
        }
    }
}
