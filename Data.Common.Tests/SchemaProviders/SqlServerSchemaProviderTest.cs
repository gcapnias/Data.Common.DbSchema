using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Data;
using System.Data.Common;

using Data.Common;

namespace Data.Common.Tests
{
    /// <summary>
    ///This is a test class for SqlServerProviderTest and is intended
    ///to contain all SqlServerProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class SqlServerSchemaProviderTest
    {
        const string connectionname = "Northwind";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "dbo";
        string tableName = "Employees";
        string procedureSchema = "dbo";
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
        public void SqlServerProviderQualifiedTableNameTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            string expected = "[dbo].[Employees]";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetTableColumnsTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetSchemaTablesTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();
            Assert.AreEqual(29, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetProceduresTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(7, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetProcedureParametersTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);
            Assert.AreEqual(1, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDBConnection
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetDBConnectionTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetConstraintsTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetDbTypeTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            string providerDbType = "18";
            DbType expected = DbType.AnsiString;
            DbType actual = target.GetDbType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderGetPropertyTypeTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for SqlServerProvider Constructor
        ///</summary>
        [TestMethod()]
        public void SqlServerProviderConstructorTest()
        {
            DbSchemaProvider target = new SqlServerSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }

    }
}
