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
        string ConnectionName;
        string ConnectionString;
        string ProviderName;
        string tableSchema;
        string procedureSchema;
        string outputProviderName;
        string databaseName;

        public DbSchemaTest()
        {
            ConnectionName = Properties.Settings.Default.ConnectionName;
            ConnectionString = ConfigurationManager.ConnectionStrings[ConnectionName].ConnectionString;
            ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;

            switch (ProviderName.ToLower())
            {
                case "mysql.data.mysqlclient":
                    databaseName = "northwind";
                    tableSchema = "northwind";
                    procedureSchema = "northwind";
                    outputProviderName = "Data.Common.MySqlSchemaProvider";
                    break;

                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                    databaseName = "Northwind";
                    tableSchema = null;
                    procedureSchema = null;
                    outputProviderName = "Data.Common.SqlServerCeSchemaProvider";
                    break;

                case "system.data.sqlite":
                    databaseName = "Northwind";
                    tableSchema = null;
                    procedureSchema = null;
                    outputProviderName = "Data.Common.SQLiteSchemaProvider";
                    break;

                case "npgsql":
                    databaseName = "Northwind";
                    tableSchema = "public";
                    procedureSchema = "public";
                    outputProviderName = "Data.Common.PostgreSqlSchemaProvider";
                    break;

                case "system.data.oracleclient":
                case "oracle.dataaccess.client":
                    databaseName = "Northwind";
                    tableSchema = "northwind";
                    procedureSchema = "northwind";
                    outputProviderName = "Data.Common.OracleSchemaProvider";
                    break;

                default:
                    databaseName = "Northwind";
                    tableSchema = "dbo";
                    procedureSchema = "dbo";
                    outputProviderName = "Data.Common.SqlServerSchemaProvider";
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
        public void DbSchemaProviderNameTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string actual = target.ProviderName;
            Assert.AreEqual(ProviderName, actual);
        }

        /// <summary>
        ///A test for ConnectionString
        ///</summary>
        [TestMethod()]
        public void DbSchemaConnectionStringTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string actual = target.ConnectionString;
            Assert.AreEqual(ConnectionString, actual);
        }

        /// <summary>
        ///A test for ConnectionName
        ///</summary>
        [TestMethod()]
        public void DbSchemaConnectionNameTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string actual = target.ConnectionName;
            Assert.AreEqual(ConnectionName, actual);
        }

        #region ' Methods '

        #region ' Tables and Views '

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DbSchemaGetSchemaTablesTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(ConnectionName);
            DataTable actual = target.GetSchemaTables();
            string message;

            switch (ProviderName.ToLower())
            {
                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                    message = string.Format("Expected <13> or more. Actual <{0}>.", actual.Rows.Count);
                    Assert.IsTrue(actual.Rows.Count >= 13, message);
                    break;

                default:
                    message = string.Format("Expected <29> or more. Actual <{0}>.", actual.Rows.Count);
                    Assert.IsTrue(actual.Rows.Count >= 29, message);
                    break;
            }
        }

        /// <summary>
        ///A test for GetTables
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTablesTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetTables();
            Assert.AreEqual(13, actual.Rows.Count);

            System.Console.WriteLine("Tables in database:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("View: {0}", relationRow["TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetViews
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetViewsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetViews();

            System.Console.WriteLine("Views in database:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("View: {0}", relationRow["TABLE_NAME"].ToString()));
            }

            switch (ProviderName.ToLower())
            {
                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                    Assert.AreEqual(0, actual.Rows.Count);
                    break;

                default:
                    Assert.AreEqual(16, actual.Rows.Count);
                    break;
            }

        }

        /// <summary>
        ///A test for GetTablesAndViews
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTablesAndViewsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetTablesAndViews();

            System.Console.WriteLine("Tables & Views in database:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table or View: {0}", relationRow["TABLE_NAME"].ToString()));
            }

            switch (ProviderName.ToLower())
            {
                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                    Assert.AreEqual(13, actual.Rows.Count);
                    break;

                default:
                    Assert.AreEqual(29, actual.Rows.Count);
                    break;
            }

        }

        /// <summary>
        ///A test for GetLogicalTables
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetLogicalTablesTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetTablesLogical();

            System.Console.WriteLine("Logical tables (w/o tables belonging to Many-to-Many relations):");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["TABLE_NAME"].ToString()));
            }

            Assert.AreEqual(11, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetManyToManyTables
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetManyToManyTablesTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetTablesManyToMany();
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Τables that belong in many-to-many relations:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("ManyToMany Relation: {0}", relationRow["TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for DiscoverTableRelations
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DbSchemaDiscoverTableRelationsTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(ConnectionName);
            Assert.AreEqual(target.GetTables().Rows.Count, target.GetTablesLogical().Rows.Count + target.GetTablesManyToMany().Rows.Count);
        }

        #endregion

        #region ' Columns and Primary Keys '

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTableColumnsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);

            System.Console.WriteLine("All columns in table");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("- Column: {0}", relationRow["ColumnName"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTablePrimaryKeyColumns
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTablePrimaryKeyColumnsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "EmployeeTerritories";
            DataTable actual = target.GetTablePrimaryKeyColumns(tableSchema, tableName);
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Primary key columns in table");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("- Column: {0}", relationRow["ColumnName"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableFields
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTableFieldsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableFields(tableSchema, tableName);
            Assert.AreEqual(16, actual.Rows.Count);

            System.Console.WriteLine("Columns in table that do not represent relations or primary keys:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("- Column: {0}", relationRow["ColumnName"].ToString()));
            }
        }

        #endregion

        #region ' Relations '

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DbSchemaGetConstraintsTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(ConnectionName);
            DataTable actual = target.GetSchemaConstraints();

            foreach (DataRow constraint in actual.Rows)
            {
                System.Console.WriteLine("PK Schema: " + constraint["PK_TABLE_SCHEMA"].ToString());
                System.Console.WriteLine("PK Table : " + constraint["PK_TABLE_NAME"].ToString());
                System.Console.WriteLine("PK Column: " + constraint["PK_COLUMN_NAME"].ToString());
                System.Console.WriteLine("FK Schema: " + constraint["FK_TABLE_SCHEMA"].ToString());
                System.Console.WriteLine("FK Table : " + constraint["FK_TABLE_NAME"].ToString());
                System.Console.WriteLine("FK Column: " + constraint["FK_COLUMN_NAME"].ToString());
                System.Console.WriteLine();
            }

            string message = string.Format("Expected <13> or more. Actual <{0}>.", actual.Rows.Count);
            Assert.IsTrue(actual.Rows.Count >= 13, message);
        }

        /// <summary>
        ///A test for GetTableOneToManyRelations
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTableOneToManyRelationsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableRelationsOneToMany(tableSchema, tableName);
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("One-to-Many relations with: tables:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["FK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetPrimaryKeyRelations
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetPrimaryKeyRelationsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableRelationsByPrimaryKey(tableSchema, tableName);
            Assert.AreEqual(3, actual.Rows.Count);

            System.Console.WriteLine("Primary key relations with tables:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["FK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableManyToOneRelations
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTableManyToOneRelationsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "EmployeeTerritories";
            DataTable actual = target.GetTableRelationsManyToOne(tableSchema, tableName);
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Many-to-One relations with tables:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["PK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetForeignKeyRelations
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetForeignKeyRelationsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "EmployeeTerritories";
            DataTable actual = target.GetTableRelationsByForeignKey(tableSchema, tableName);
            Assert.AreEqual(2, actual.Rows.Count);

            System.Console.WriteLine("Foreign key relations with tables:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["PK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableManyToManyRelations
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTableManyToManyRelationsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableRelationsManyToMany(tableSchema, tableName);
            Assert.AreEqual(1, actual.Rows.Count);

            System.Console.WriteLine("Many-to-many relations with tables:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["PK_TABLE_NAME"].ToString()));
            }
        }

        /// <summary>
        ///A test for GetTableOneToOneRelations
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetTableOneToOneRelationsTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableRelationsOneToOne(tableSchema, tableName);
            Assert.AreEqual(0, actual.Rows.Count);

            System.Console.WriteLine("One-to-One relations with tables:");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Table: {0}", relationRow["PK_TABLE_NAME"].ToString()));
            }
        }

        #endregion

        #region ' Store Procedures '

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetProceduresTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetProcedures();

            System.Console.WriteLine("Procedures in database");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Procedure: {0}", relationRow["ROUTINE_NAME"].ToString()));
            }

            switch (ProviderName.ToLower())
            {
                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                case "system.data.sqlite":
                    Assert.AreEqual(0, actual.Rows.Count);
                    break;

                default:
                    Assert.AreEqual(7, actual.Rows.Count);
                    break;
            }

        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void DbSchemaGetProcedureParametersTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string procedureName = "CustOrderHist";
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);

            System.Console.WriteLine("Parmeters in Procedure");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Parameter: {0}", relationRow["PARAMETER_NAME"].ToString()));
            }

            switch (ProviderName.ToLower())
            {
                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                case "system.data.sqlite":
                    Assert.AreEqual(0, actual.Rows.Count);
                    break;

                default:
                    Assert.AreEqual(1, actual.Rows.Count);
                    break;
            }
        }

        #endregion

        #endregion

        #region ' Helpers '

        /// <summary>
        ///A test for GetSchemaProvider
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DbSchemaGetSchemaProviderTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(ConnectionName);
            DbSchemaProvider actual = target.GetSchemaProvider(ConnectionString, ProviderName);
            Assert.AreEqual(outputProviderName, actual.GetType().ToString());
        }

        [TestMethod()]
        public void DbSchemaGetDatabaseName()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string actual = target.GetDatabaseName();
            Assert.AreEqual(databaseName, actual);
        }

        #endregion

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
            DbSchema target = new DbSchema(ConnectionName);
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
            DbSchema target = new DbSchema(ConnectionString, ProviderName);
            DataTable tables = target.GetTables();
            Assert.IsNotNull(target);
            Assert.AreEqual(13, tables.Rows.Count);
        }

    }
}
