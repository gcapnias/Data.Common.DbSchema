using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Data;
using System.Data.Common;

using Data.Common;

namespace Data.Common.Tests
{
    
    
    /// <summary>
    ///This is a test class for MySqlProviderTest and is intended
    ///to contain all MySqlProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class MySqlSchemaProviderTest
    {
        const string connectionname = "NorthwindMySQL";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "northwind";
        string tableName = "Employees";
        string procedureSchema = "northwind";
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
        public void MySqlProviderQualifiedTableNameTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            string expected = "`northwind`.`Employees`";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetTableColumnsTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetSchemaTablesTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetProceduresTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(6, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetProcedureParametersTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);
            Assert.AreEqual(1, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDBConnection
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetDBConnectionTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetConstraintsTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(17, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetDbTypeTest()
        {
            DbSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            string providerDbType = "18";
            DbType expected = DbType.AnsiString;
            DbType actual = target.GetDbColumnType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void MySqlProviderGetPropertyTypeTest()
        {
            DbSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for MySqlProvider Constructor
        ///</summary>
        [TestMethod()]
        public void MySqlProviderConstructorTest()
        {
            MySqlSchemaProvider target = new MySqlSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }
    }
}
