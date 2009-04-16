﻿using System;
using System.Collections.Generic;
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
        const string ConnectionName = "Northwind";

        public ManyToMany()
        {
            //
            // TODO: Add constructor logic here
            //
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
            string tableSchema = "dbo";
            string tableName = "Customers";
            string foundTableSchema = null;
            string foundTableName = null;

            DbSchema schema = new DbSchema(ConnectionName);
            DataTable TableManyToManyRelations = schema.GetTableManyToManyRelations(tableSchema, tableName);

            foreach (DataRow relationRow in TableManyToManyRelations.Rows)
            {
                string fkTableSchema = CleanNullOrEmpty(relationRow["FK_TABLE_SCHEMA"]);
                string fkTableName = relationRow["FK_TABLE_NAME"].ToString();
                DataTable OtherManyToManyRelations = schema.GetTableManyToOneRelations(fkTableSchema, fkTableName);
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

            Assert.AreEqual("dbo", foundTableSchema);
            Assert.AreEqual("CustomerDemographics", foundTableName);
        }

        [TestMethod]
        public void FindTableRelations()
        {
            string tableSchema = "dbo";
            string tableName = "Territories";
            DbSchema schema = new DbSchema(ConnectionName);

            DataTable onetomanyRelations = schema.GetTableOneToManyRelations(tableSchema, tableName);
            foreach (DataRow relationRow in onetomanyRelations.Rows)
            {
                System.Console.WriteLine("(OTM)Table: " + relationRow["FK_TABLE_NAME"].ToString());
            }

            DataTable manytooneRelations = schema.GetTableManyToOneRelations(tableSchema, tableName);
            foreach (DataRow relationRow in manytooneRelations.Rows)
            {
                System.Console.WriteLine("(MTO)Table: " + relationRow["PK_TABLE_NAME"].ToString());
            }

            DataTable manytomanyRelations = schema.GetTableManyToManyRelations(tableSchema, tableName);
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