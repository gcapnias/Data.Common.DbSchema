using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Data;
using System.Data.Common;

using Data.Common;

namespace Data.Common.Tests
{
    /// <summary>
    ///This is a test class for VistaDBProviderTest and is intended
    ///to contain all VistaDBProviderTest Unit Tests
    ///</summary>
    [TestClass()]
    public class VistaDBSchemaProviderTest
    {
        const string connectionname = "NorthwindVistaDB";
        string connectionstring = ConfigurationManager.ConnectionStrings[connectionname].ConnectionString;
        string providername = ConfigurationManager.ConnectionStrings[connectionname].ProviderName;
        string tableSchema = "dbo";
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
        public void VistaDBProviderQualifiedTableNameTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            string expected = "[dbo].[Employees]";
            string actual = target.QualifiedTableName(tableSchema, tableName);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetTableColumns
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetTableColumnsTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetTableColumns(tableSchema, tableName);
            Assert.AreEqual(18, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetSchemaTables
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetSchemaTablesTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetSchemaTables();

            string message = string.Format("Expected <29> or more. Actual <{0}>.", actual.Rows.Count);
            Assert.IsTrue(actual.Rows.Count >= 29, message);
        }

        /// <summary>
        ///A test for GetProcedures
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetProceduresTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetProcedures();
            Assert.AreEqual(7, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetProcedureParameters
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetProcedureParametersTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
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
        public void VistaDBProviderGetDBConnectionTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            DbConnection actual = target.GetDBConnection();
            Assert.AreEqual(true, actual.State == ConnectionState.Open);
        }

        /// <summary>
        ///A test for GetConstraints
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetConstraintsTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            DataTable actual = target.GetConstraints();
            Assert.AreEqual(13, actual.Rows.Count);
        }

        /// <summary>
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetDbTypeTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            string providerDbType = "18";
            DbType expected = DbType.AnsiString;
            DbType actual = target.GetDbColumnType(providerDbType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetPropertyType
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetPropertyTypeTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            string SystemType = "System.String";
            string expected = "string";
            string actual = target.GetPropertyType(SystemType);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for GetDatabaseName
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderGetDatabaseName()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            string expected = "Northwind";
            string actual = target.GetDatabaseName();
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for VistaDBProvider Constructor
        ///</summary>
        [TestMethod()]
        public void VistaDBProviderConstructorTest()
        {
            VistaDBSchemaProvider target = new VistaDBSchemaProvider(connectionstring, providername);
            using (DbConnection _Connection = target.GetDBConnection())
            {
                Assert.AreEqual(true, _Connection.State == ConnectionState.Open);
                Assert.AreEqual(connectionstring, _Connection.ConnectionString);
            }
        }

    }
}
