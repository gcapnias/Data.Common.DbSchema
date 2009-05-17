using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Data.Common.Tests
{
    /// <summary>
    /// Summary description for ManyToMany
    /// </summary>
    [TestClass]
    public class ManyToMany
    {
        string ConnectionName;
        string tableSchema;

        public ManyToMany()
        {
            ConnectionName = Properties.Settings.Default.ConnectionName;
            string ProviderName = ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName;

            switch (ProviderName.ToLower())
            {
                case "mysql.data.mysqlclient":
                case "system.data.oracleclient":
                case "oracle.dataaccess.client":
                    tableSchema = "northwind";
                    break;

                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                case "system.data.sqlite":
                    tableSchema = null;
                    break;

                default:
                    tableSchema = "dbo";
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
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        private string TableNameHash(string tableSchema, string tableName)
        {
            if (!string.IsNullOrEmpty(tableSchema))
                return string.Format("{0}.{1}", tableSchema, tableName).ToLower();
            else
                return string.Format("{0}", tableName).ToLower();
        }

        private string CleanNullOrEmpty(object propertyToFilter)
        {
            string propertyValue = null;
            if (propertyToFilter != DBNull.Value)
            {
                if (!string.IsNullOrEmpty(propertyToFilter.ToString()))
                    propertyValue = propertyToFilter.ToString();
            }

            return propertyValue;
        }

        [TestMethod]
        public void ManyToManyTest()
        {
            string tableName = "Customers";
            string foundTableSchema = null;
            string foundTableName = null;

            DbSchema schema = new DbSchema(ConnectionName);
            DataTable TableManyToManyRelations = schema.GetTableRelationsManyToMany(tableSchema, tableName);

            foreach (DataRow relationRow in TableManyToManyRelations.Rows)
            {
                string fkTableSchema = CleanNullOrEmpty(relationRow["FK_TABLE_SCHEMA"]);
                string fkTableName = relationRow["FK_TABLE_NAME"].ToString();
                DataTable OtherManyToManyRelations = schema.GetTableRelationsManyToOne(fkTableSchema, fkTableName);
                foreach (DataRow manytomanyRow in OtherManyToManyRelations.Rows)
                {
                    string otherTableSchema = CleanNullOrEmpty(manytomanyRow["PK_TABLE_SCHEMA"]);
                    string otherTableName = manytomanyRow["PK_TABLE_NAME"].ToString();
                    if (TableNameHash(tableSchema, tableName) != TableNameHash(otherTableSchema, otherTableName))
                    {
                        foundTableSchema = otherTableSchema;
                        foundTableName = otherTableName;
                    }
                }
            }

            Assert.AreEqual(tableSchema, foundTableSchema);
            Assert.AreEqual("customerdemographics", foundTableName.ToLower());
        }

        [TestMethod]
        public void FindTableRelations()
        {
            string tableName = "Territories";
            DbSchema schema = new DbSchema(ConnectionName);

            DataTable onetomanyRelations = schema.GetTableRelationsOneToMany(tableSchema, tableName);
            foreach (DataRow relationRow in onetomanyRelations.Rows)
            {
                System.Console.WriteLine("(OTM)Table: " + relationRow["FK_TABLE_NAME"].ToString());
            }

            DataTable manytooneRelations = schema.GetTableRelationsManyToOne(tableSchema, tableName);
            foreach (DataRow relationRow in manytooneRelations.Rows)
            {
                System.Console.WriteLine("(MTO)Table: " + relationRow["PK_TABLE_NAME"].ToString());
            }

            DataTable manytomanyRelations = schema.GetTableRelationsManyToMany(tableSchema, tableName);
            foreach (DataRow relationRow in manytomanyRelations.Rows)
            {
                System.Console.WriteLine("(MTM)Table: " + relationRow["FK_TABLE_NAME"].ToString());
            }

            Assert.AreEqual(0, onetomanyRelations.Rows.Count);
            Assert.AreEqual(1, manytooneRelations.Rows.Count);
            Assert.AreEqual(1, manytomanyRelations.Rows.Count);

        }
    }
}
