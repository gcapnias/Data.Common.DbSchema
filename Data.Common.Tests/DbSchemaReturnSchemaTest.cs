using System;
using System.Configuration;
using System.Data;
using Data.Common;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;

namespace Data.Common.Tests
{


    /// <summary>
    ///This is a test class for DbSchemaTest and is intended
    ///to contain all DbSchemaTest Unit Tests
    ///</summary>
    [TestClass()]
    public class DbSchemaReturnSchemaTest
    {
        string ConnectionName;
        string ConnectionString;
        string ProviderName;
        string tableSchema;
        string procedureSchema;

        public DbSchemaReturnSchemaTest()
        {
            ConnectionName = Properties.Settings.Default.ConnectionName;
            ConnectionString = ConfigurationManager.ConnectionStrings[ConnectionName].ConnectionString;
            ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;

            switch (ProviderName.ToLower())
            {
                case "mysql.data.mysqlclient":
                    tableSchema = "northwind";
                    procedureSchema = "northwind";
                    break;

                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                    tableSchema = null;
                    procedureSchema = null;
                    break;

                case "system.data.sqlite":
                case "system.data.oledb":
                    tableSchema = null;
                    procedureSchema = null;
                    break;


                case "npgsql":
                    tableSchema = "public";
                    procedureSchema = "public";
                    break;

                case "system.data.oracleclient":
                case "oracle.dataaccess.client":
                    tableSchema = "northwind";
                    procedureSchema = "northwind";
                    break;

                default:
                    tableSchema = "dbo";
                    procedureSchema = "dbo";
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
        ///A test for GetSchemaTables - Testing for mininum required datatable's columns
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DbSchemaReturnSchemaGetSchemaTablesTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(ConnectionName);
            DataTable actual = target.GetSchemaTables();
            foreach (DataColumn column in actual.Columns)
            {
                System.Console.WriteLine("Column: {0} ({1})", column.ColumnName, column.DataType.ToString());
            }

            List<DbTable> tables = new List<DbTable>();
            foreach (DataRow Table in actual.Rows)
            {
                tables.Add(new DbTable(Table));
            }
            Assert.IsTrue(tables.Count >= 19, string.Format("Actual <{0}>.", tables.Count));

            string[] requiredColumns = new string[] { 
                "TABLE_CATALOG","TABLE_SCHEMA","TABLE_NAME","TABLE_TYPE"
            };
            foreach (string columnName in requiredColumns)
            {
                Assert.IsTrue(actual.Columns.Contains(columnName), string.Format("Expected column <{0}>.", columnName));
            }

            Type[] requiredColumnsTypes = new Type[] { 
                typeof(System.String),typeof(System.String),typeof(System.String),typeof(System.String)
            };
            for (int currentColumn = 0; currentColumn < requiredColumns.Length; currentColumn++)
            {
                Assert.AreEqual(requiredColumnsTypes[currentColumn].ToString(), actual.Columns[requiredColumns[currentColumn]].DataType.ToString(), string.Format("Column: {0}", requiredColumns[currentColumn]));
            }

        }

        /// <summary>
        ///A test for GetTableColumns - Testing for mininum required datatable's columns
        ///</summary>
        [TestMethod()]
        public void DbSchemaReturnSchemaGetTableColumns()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string tableName = "Employees";
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            foreach (DataColumn column in actual.Columns)
            {
                System.Console.WriteLine("Column: {0} ({1})", column.ColumnName, column.DataType.ToString());
            }

            List<DbColumn> columns = new List<DbColumn>();
            foreach (DataRow Column in actual.Rows)
            {
                columns.Add(new DbColumn(Column));
            }
            Assert.AreEqual(18, columns.Count);

            string[] requiredColumns = new string[] { 
                "AllowDBNull","BaseColumnName","BaseSchemaName","BaseTableName","ColumnName","ColumnOrdinal",
                "ColumnSize","DataType","IsKey","IsLong","IsUnique","NumericPrecision","NumericScale"
            };
            string[] optionalColumns = new string[] { 
                "BaseCatalogName","IsAutoIncrement","IsReadOnly","IsRowVersion","ProviderType"
            };

            foreach (string columnName in requiredColumns)
            {
                Assert.IsTrue(actual.Columns.Contains(columnName), string.Format("Expected column <{0}>.", columnName));
            }
            if (ProviderName.ToLower() != "system.data.oracleclient" && ProviderName.ToLower() != "oracle.dataaccess.client")
            {
                foreach (string columnName in optionalColumns)
                {
                    Assert.IsTrue(actual.Columns.Contains(columnName), string.Format("Expected column <{0}>.", columnName));
                }
            }

            Type[] requiredColumnsTypes = new Type[] { 
                typeof(System.Boolean), typeof(System.String), typeof(System.String), typeof(System.String), 
                typeof(System.String), typeof(System.Int32), typeof(System.Int32), typeof(System.Type), 
                typeof(System.Boolean), typeof(System.Boolean), typeof(System.Boolean), typeof(System.Int16), 
                typeof(System.Int16)
            };
            Type[] optionalColumnsTypes = new Type[] { 
                typeof(System.String), typeof(System.Boolean), typeof(System.Boolean), typeof(System.Boolean), 
                typeof(System.Int32)
            };
            for (int currentColumn = 0; currentColumn < requiredColumns.Length; currentColumn++)
            {
                Assert.AreEqual(requiredColumnsTypes[currentColumn].ToString(), actual.Columns[requiredColumns[currentColumn]].DataType.ToString(), string.Format("Column: {0}", requiredColumns[currentColumn]));
            }
            if (ProviderName.ToLower() != "system.data.oracleclient" && ProviderName.ToLower() != "oracle.dataaccess.client")
            {
                for (int currentColumn = 0; currentColumn < optionalColumns.Length; currentColumn++)
                {
                    Assert.AreEqual(optionalColumnsTypes[currentColumn].ToString(), actual.Columns[optionalColumns[currentColumn]].DataType.ToString(), string.Format("Column: {0}", optionalColumns[currentColumn]));
                }
            }

        }

        /// <summary>
        ///A test for GetSchemaConstraints - Testing for mininum required datatable's columns
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Data.Common.dll")]
        public void DbSchemaReturnSchemaGetSchemaConstraintsTest()
        {
            DbSchema_Accessor target = new DbSchema_Accessor(ConnectionName);
            DataTable actual = target.GetSchemaConstraints();
            foreach (DataColumn column in actual.Columns)
            {
                System.Console.WriteLine("Column: {0} ({1})", column.ColumnName, column.DataType.ToString());
            }

            List<DbRelation> relations = new List<DbRelation>();
            foreach (DataRow Relation in actual.Rows)
            {
                relations.Add(new DbRelation(Relation));
            }
            Assert.AreEqual(13, relations.Count);

            string[] requiredColumns = new string[] { 
                "PK_TABLE_CATALOG","PK_TABLE_SCHEMA","PK_TABLE_NAME","PK_COLUMN_NAME",
                "FK_TABLE_CATALOG","FK_TABLE_SCHEMA","FK_TABLE_NAME","FK_COLUMN_NAME"
            };
            foreach (string columnName in requiredColumns)
            {
                Assert.IsTrue(actual.Columns.Contains(columnName), string.Format("Expected column <{0}>.", columnName));
            }

            Type[] requiredColumnsTypes = new Type[] { 
                typeof(System.String),typeof(System.String),typeof(System.String),typeof(System.String),
                typeof(System.String),typeof(System.String),typeof(System.String),typeof(System.String)
            };
            for (int currentColumn = 0; currentColumn < requiredColumns.Length; currentColumn++)
            {
                Assert.AreEqual(requiredColumnsTypes[currentColumn].ToString(), actual.Columns[requiredColumns[currentColumn]].DataType.ToString(), string.Format("Column: {0}", requiredColumns[currentColumn]));
            }

        }

        /// <summary>
        ///A test for GetProcedures - Testing for mininum required datatable's columns
        ///</summary>
        [TestMethod()]
        public void DbSchemaReturnSchemaGetProceduresTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            DataTable actual = target.GetProcedures();
            foreach (DataColumn column in actual.Columns)
            {
                System.Console.WriteLine("Column: {0} ({1})", column.ColumnName, column.DataType.ToString());
            }

            string[] requiredColumns = new string[] { 
                "ROUTINE_CATALOG","ROUTINE_SCHEMA","ROUTINE_NAME","ROUTINE_TYPE"
            };
            foreach (string columnName in requiredColumns)
            {
                Assert.IsTrue(actual.Columns.Contains(columnName), string.Format("Expected column <{0}>.", columnName));
            }

            Type[] requiredColumnsTypes = new Type[] { 
                typeof(System.String),typeof(System.String),typeof(System.String),typeof(System.String)
            };
            for (int currentColumn = 0; currentColumn < requiredColumns.Length; currentColumn++)
            {
                Assert.AreEqual(requiredColumnsTypes[currentColumn].ToString(), actual.Columns[requiredColumns[currentColumn]].DataType.ToString(), string.Format("Column: {0}", requiredColumns[currentColumn]));
            }

        }

        /// <summary>
        ///A test for GetProcedureParameters - Testing for mininum required datatable's columns
        ///</summary>
        [TestMethod()]
        public void DbSchemaReturnSchemaGetProcedureParametersTest()
        {
            DbSchema target = new DbSchema(ConnectionName);
            string procedureName = "CustOrderHist";
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);
            foreach (DataColumn column in actual.Columns)
            {
                System.Console.WriteLine("Column: {0} ({1})", column.ColumnName, column.DataType.ToString());
            }

            string[] requiredColumns = new string[] { 
                "SPECIFIC_CATALOG","SPECIFIC_SCHEMA","SPECIFIC_NAME","PARAMETER_NAME",
                "ORDINAL_POSITION","PARAMETER_MODE","IS_RESULT","DATA_TYPE"
            };
            foreach (string columnName in requiredColumns)
            {
                Assert.IsTrue(actual.Columns.Contains(columnName), string.Format("Expected column <{0}>.", columnName));
            }

            Type[] requiredColumnsTypes = new Type[] { 
                typeof(System.String),typeof(System.String),typeof(System.String),typeof(System.String),
                typeof(System.Int32),typeof(ParameterDirection),typeof(System.Boolean),typeof(System.Data.DbType)
            };
            for (int currentColumn = 0; currentColumn < requiredColumns.Length; currentColumn++)
            {
                Assert.AreEqual(requiredColumnsTypes[currentColumn].ToString(), actual.Columns[requiredColumns[currentColumn]].DataType.ToString(), string.Format("Column: {0}", requiredColumns[currentColumn]));
            }

        }

    }
}
