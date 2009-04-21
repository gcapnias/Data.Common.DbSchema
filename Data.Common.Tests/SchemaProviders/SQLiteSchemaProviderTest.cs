using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Data;
using System.Data.Common;

using Data.Common;

namespace Data.Common.Tests
{
    /// <summary>
    ///This is a test class for SQLiteProviderTest and is intended
    ///to contain all SQLiteProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class SQLiteSchemaProviderTest
    {
        const string connectionname = "NorthwindSQLite";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = null;
        string tableName = "Employees";
        string procedureSchema = null;
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
        public void SQLiteProviderQualifiedTableNameTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            string expected = "[Employees]";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetTableColumnsTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetSchemaTablesTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();
            string message = string.Format("Expected <29> or more. Actual <{0}>.", actual.Rows.Count);
            Assert.IsTrue(actual.Rows.Count >= 29, message);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetProceduresTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(0, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetProcedureParametersTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedureParameters(procedureSchema, procedureName);

            System.Console.WriteLine("Parmeters in Procedure");
            foreach (DataRow relationRow in actual.Rows)
            {
                System.Console.WriteLine(string.Format("Parameter: {0}", relationRow["PARAMETER_NAME"].ToString()));
            }

            Assert.AreEqual(0, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDBConnection
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetDBConnectionTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetConstraintsTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetDbTypeTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            string providerDbType = "16";
            DbType expected = DbType.String;
            DbType actual = target.GetDbColumnType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderGetPropertyTypeTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for SQLiteProvider Constructor
        ///</summary>
        [TestMethod()]
        public void SQLiteProviderConstructorTest()
        {
            DbSchemaProvider target = new SQLiteSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }

    }
}
