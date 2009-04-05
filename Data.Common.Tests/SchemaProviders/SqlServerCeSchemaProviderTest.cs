using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Data;
using System.Data.Common;

using Data.Common;

namespace Data.Common.Tests
{
    
    
    /// <summary>
    ///This is a test class for SqlServerCeProviderTest and is intended
    ///to contain all SqlServerCeProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class SqlServerCeSchemaProviderTest
    {
        const string connectionname = "NorthwindSqlCe";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "";
        string tableName = "Employees";
        string procedureSchema = "";
        string procedureName = "CustOrdersOrders";

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
        ///A test for QualifiedTableName
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderQualifiedTableNameTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            string expected = "[Employees]";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetTableColumnsTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(16, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetSchemaTablesTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();
            Assert.AreEqual(8, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetProceduresTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(0, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetProcedureParametersTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);
            Assert.AreEqual(0, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDBConnection
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetDBConnectionTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetConstraintsTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(7, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetDbTypeTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            string providerDbType = "18";
            DbType expected = DbType.AnsiString;
            DbType actual = target.GetDbType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderGetPropertyTypeTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for SqlServerCeProvider Constructor
        ///</summary>
        [TestMethod()]
        public void SqlServerCeProviderConstructorTest()
        {
            DbSchemaProvider target = new SqlServerCeSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }
    }
}
