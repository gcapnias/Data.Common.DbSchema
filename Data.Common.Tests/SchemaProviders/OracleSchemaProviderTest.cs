using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Data;
using System.Data.Common;

using Data.Common;

namespace Data.Common.Tests
{
    /// <summary>
    ///This is a test class for OracleProviderTest and is intended
    ///to contain all OracleProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class OracleSchemaProviderTest
    {
        //const string connectionname = "NorthwindOracle";
        const string connectionname = "NorthwindOracleClient";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "northwind";
        string tableName = "Employees";
        string procedureSchema = "northwind";
        string procedureName = "Sales by Year";

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
        public void OracleProviderQualifiedTableNameTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            string expected = "northwind.Employees";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetTableColumnsTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);

            foreach (DataRow columnRow in actual.Rows)
            {
                System.Console.WriteLine("Column: " + columnRow["ColumnName"].ToString());
            }

            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetSchemaTablesTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();

            string message = string.Format("Expected <29> or more. Actual <{0}>.", actual.Rows.Count);
            Assert.IsTrue(actual.Rows.Count >= 29, message);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetProceduresTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(7, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetProcedureParametersTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
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
        public void OracleProviderGetDBConnectionTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetConstraintsTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetDbTypeTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            string providerDbType = "4";
            DbType expected = DbType.AnsiString;
            DbType actual = target.GetDbColumnType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetPropertyTypeTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetDatabaseName
        ///</summary>
        [TestMethod()]
        public void OracleProviderGetDatabaseName()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            string expected = string.Empty;
            string actual = target.GetDatabaseName();
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for OracleProvider Constructor
        ///</summary>
        [TestMethod()]
        public void OracleProviderConstructorTest()
        {
            OracleSchemaProvider target = new OracleSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }

    }
}
