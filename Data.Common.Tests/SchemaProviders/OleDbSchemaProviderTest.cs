using Data.Common;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace Data.Common.Tests
{
    
    
    /// <summary>
    ///This is a test class for OleDbSchemaProviderTest and is intended
    ///to contain all OleDbSchemaProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class OleDbSchemaProviderTest
    {
        const string connectionname = "NorthwindOleDbAccess";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = string.Empty;
        string tableName = "Employees";
        string procedureSchema = "dbo";
        string procedureName = "SalesByCategory";

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
        ///A test for QualifiedTableName
        ///</summary>
        [TestMethod()]
        public void OleDbProviderQualifiedTableNameTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            string expected = "[dbo].[Employees]";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetTableColumnsTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);

            using (OleDbConnection _Connection = (OleDbConnection) target.GetDBConnection())
            {
                DataTable tbl = _Connection.GetSchema("DataTypes");
            }

            DataTable actual = target.GetTableColumns(tableSchema, tableName);

            foreach (DataRow columnRow in actual.Rows)
            {
                System.Console.Out.WriteLine("Column: " + columnRow["ColumnName"].ToString() + " - Datatype: " + columnRow["ProviderType"].ToString());
            }

            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetSchemaTablesTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();
            Assert.AreEqual(29, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetProceduresTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(7, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetProcedureParametersTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);

            System.Console.WriteLine("Parmeters in Procedure");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Parameter: {0}", relationRow["PARAMETER_NAME"].ToString()));
            }

            Assert.AreEqual(2, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDBConnection
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetDBConnectionTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            OleDbConnection actual = (OleDbConnection)target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetConstraintsTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetDbTypeTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            string providerDbType = "18";
            DbType expected = DbType.AnsiString;
            DbType actual = target.GetDbColumnType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetPropertyTypeTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetDatabaseName
        ///</summary>
        [TestMethod()]
        public void OleDbProviderGetDatabaseName()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            string expected = "Northwind";
            string actual = target.GetDatabaseName();
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for OleDbProvider Constructor
        ///</summary>
        [TestMethod()]
        public void OleDbProviderConstructorTest()
        {
            OleDbSchemaProvider target = new OleDbSchemaProvider(connectionstring, providername);
            using (OleDbConnection _Connection = (OleDbConnection)target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }

    }
}
