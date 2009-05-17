using System.Configuration;
using System.Data;
using System.Data.Common;
using Data.Common;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Data.Common.Tests
{
    
    
    /// <summary>
    ///This is a test class for PostgreSqlSchemaProviderTest and is intended
    ///to contain all PostgreSqlSchemaProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class PostgreSqlSchemaProviderTest
    {
        const string connectionname = "NorthwindPostgres";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "public";
        string tableName = "Employees";
        string procedureSchema = "public";
        string procedureName = "getordercount";


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
        public void PostgreSqlProviderQualifiedTableNameTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            string expected = "public.Employees";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetTableColumnsTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetSchemaTablesTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetProceduresTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(4, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetProcedureParametersTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);
            Assert.AreEqual(1, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDBConnection
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetDBConnectionTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetConstraintsTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetDbTypeTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            string providerDbType = "18";
            DbType expected = DbType.Int16;
            DbType actual = target.GetDbColumnType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetPropertyTypeTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetDatabaseName
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderGetDatabaseName()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            string expected = "Northwind";
            string actual = target.GetDatabaseName();
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for PostgreSqlProvider Constructor
        ///</summary>
        [TestMethod()]
        public void PostgreSqlProviderConstructorTest()
        {
            PostgreSqlSchemaProvider target = new PostgreSqlSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }
    }
}
