//
//  The contents of this file are subject to the Mozilla Public
//  License Version 1.1 (the "License"); you may not use this file
//  except in compliance with the License. You may obtain a copy of
//  the License at http://www.mozilla.org/MPL/
//
//  Software distributed under the License is distributed on an 
//  "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
//  implied. See the License for the specific language governing
//  rights and limitations under the License.
//

using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Linq;
using System.Text;

namespace Data.Common
{
    public class DbSchema
    {
        private string _ConnectionName;
        private string _ConnectionString;
        private string _ProviderName;
        private DbSchemaProvider _Provider;
        private Dictionary<string, DataTable> Cache = new Dictionary<string, DataTable>();
        private ArrayList dictionaryTablesManyToMany = new ArrayList();

        #region ' Properties '

        public string ConnectionName
        {
            get { return _ConnectionName; }
        }

        public string ConnectionString
        {
            get { return _ConnectionString; }
        }

        public string ProviderName
        {
            get { return _ProviderName; }
        }

        #endregion

        #region ' Constractors '

        public DbSchema() :
            this("LocalSqlServer")
        { }

        public DbSchema(string ConnectionName) :
            this(ConnectionName, ConfigurationManager.ConnectionStrings[ConnectionName].ConnectionString, ConfigurationManager.ConnectionStrings[ConnectionName].ProviderName)
        { }

        public DbSchema(string ConnectionName, string ConnectionString, string ProviderName)
        {
            _ConnectionName = ConnectionName;
            _ConnectionString = ConnectionString;
            _ProviderName = ProviderName;
            _Provider = GetSchemaProvider(_ConnectionName, _ProviderName);
        }

        #endregion

        #region ' Methods '

        #region ' Tables and Views '

        private DataTable GetSchemaTables()
        {
            string CacheKey = "TablesSchema";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable tbl = _Provider.GetSchemaTables();

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        public DataTable GetTables()
        {
            string CacheKey = "Tables";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable schemaTables = GetSchemaTables();
            DataTable tbl = new DataTable("Tables");
            if (schemaTables.Rows.Count > 0)
            {
                string WhereClause = "TABLE_TYPE='TABLE' OR TABLE_TYPE='BASE TABLE'";
                tbl = schemaTables.Clone();
                foreach (DataRow tblRow in schemaTables.Select(WhereClause))
                {
                    tbl.ImportRow(tblRow);
                }
            }

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        public DataTable GetTablesLogical()
        {
            string CacheKey = "TablesLogical";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DiscoverManyToManyTables();

            return GetTablesLogical();
        }

        public DataTable GetViews()
        {
            string CacheKey = "Views";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable schemaTables = GetSchemaTables();
            DataTable tbl = new DataTable("Views");
            if (schemaTables.Rows.Count > 0)
            {
                string WhereClause = "TABLE_TYPE='VIEW'";
                tbl = schemaTables.Clone();
                foreach (DataRow tblRow in schemaTables.Select(WhereClause))
                {
                    tbl.ImportRow(tblRow);
                }
            }

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        #endregion

        #region ' Columns and Primary Keys '

        public DataTable GetTableColumns(string tableSchema, string tableName)
        {
            string CacheKey = "Columns:" + _Provider.QualifiedTableName(tableSchema, tableName);
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable tbl = _Provider.GetTableColumns(tableSchema, tableName);

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        public string GetTablePrimaryKey(string tableSchema, string tableName)
        {
            DataTable tbl = GetTableColumns(tableSchema, tableName);
            string primarykey = "";
            foreach (DataRow columnRow in tbl.Rows)
            {
                bool isPrimaryKey = false;
                if (columnRow["IsKey"] != DBNull.Value)
                    isPrimaryKey = (bool)columnRow["IsKey"];

                if (isPrimaryKey)
                {
                    primarykey = columnRow["ColumnName"].ToString();
                    break;
                }
            }
            return primarykey;
        }

        public DataTable GetTablePrimaryKeys(string tableSchema, string tableName)
        {
            DataTable TableColumns = GetTableColumns(tableSchema, tableName);
            string WhereClause = "IsKey = true";
            DataTable tbl = TableColumns.Clone();
            foreach (DataRow primaryKeyRow in TableColumns.Select(WhereClause))
                tbl.ImportRow(primaryKeyRow);

            return tbl;
        }

        public DataTable GetTableFields(string tableSchema, string tableName)
        {
            //keys, one-to-many, many-to-one
            List<string> filteredcolumns = new List<string>();

            foreach (DataRow primarykey in GetTablePrimaryKeys(tableSchema, tableName).Rows)
            {
                string columnname = "'" + primarykey["ColumnName"].ToString() + "'";
                if (!filteredcolumns.Contains(columnname))
                    filteredcolumns.Add(columnname);
            }
            foreach (DataRow onetomanyrelation in GetTableOneToManyRelations(tableSchema, tableName).Rows)
            {
                string columnname = "'" + onetomanyrelation["PK_COLUMN_NAME"].ToString() + "'";
                if (!filteredcolumns.Contains(columnname))
                    filteredcolumns.Add(columnname);
            }
            foreach (DataRow manytoonerelation in GetTableManyToOneRelations(tableSchema, tableName).Rows)
            {
                string columnname = "'" + manytoonerelation["FK_COLUMN_NAME"].ToString() + "'";
                if (!filteredcolumns.Contains(columnname))
                    filteredcolumns.Add(columnname);
            }

            string WhereClause = "ColumnName NOT IN ( " + string.Join(", ", filteredcolumns.ToArray()) + " )";
            DataTable TableColumns = GetTableColumns(tableSchema, tableName);
            DataTable tbl = TableColumns.Clone();
            foreach (DataRow columnRow in TableColumns.Select(WhereClause))
            {
                tbl.ImportRow(columnRow);
            }

            return tbl;
        }

        #endregion

        #region ' Relations '

        private DataTable GetConstraints()
        {
            string CacheKey = "Constraints";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable tbl = _Provider.GetConstraints();

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        public DataTable GetTableManyToOneRelations(string tableSchema, string tableName)
        {
            string WhereClause;
            if (!string.IsNullOrEmpty(tableSchema))
                WhereClause = string.Format("FK_TABLE_SCHEMA='{0}' AND FK_TABLE_NAME='{1}'", tableSchema, tableName);
            else
                WhereClause = string.Format("FK_TABLE_NAME='{0}'", tableName);

            DataTable relations = GetConstraints();
            DataRow[] fks = (DataRow[])relations.Select(WhereClause);
            DataTable tbl = relations.Clone();
            foreach (DataRow fk in fks)
            {
                tbl.ImportRow(fk);
            }

            return tbl;
        }

        public DataTable GetTableOneToManyRelations(string tableSchema, string tableName)
        {
            string WhereClause;
            if (!string.IsNullOrEmpty(tableSchema))
                WhereClause = string.Format("PK_TABLE_SCHEMA='{0}' AND PK_TABLE_NAME='{1}'", tableSchema, tableName);
            else
                WhereClause = string.Format("PK_TABLE_NAME='{0}'", tableName);

            DataTable relations = GetConstraints();
            DataRow[] pks = (DataRow[])relations.Select(WhereClause);
            DataTable tbl = relations.Clone();
            foreach (DataRow pk in pks)
            {
                string FKTableSchema = null;
                string FKTablename = null;
                if (pk["FK_TABLE_SCHEMA"] != DBNull.Value)
                    FKTableSchema = pk["FK_TABLE_SCHEMA"].ToString();
                FKTablename = pk["FK_TABLE_NAME"].ToString();

                string tableNameHash = string.IsNullOrEmpty(FKTableSchema) ? FKTablename : FKTableSchema + "." + FKTablename;
                if (!dictionaryTablesManyToMany.Contains(tableNameHash))
                    tbl.ImportRow(pk);
            }

            return tbl;
        }

        public DataTable GetTablesManyToManyRelations()
        {
            string CacheKey = "TablesManyToManyRelations";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DiscoverManyToManyTables();

            return GetTablesManyToManyRelations();
        }

        private void DiscoverManyToManyTables()
        {
            DataTable schemaTables = GetTables();
            DataTable tblManyToMany = new DataTable("TablesManyToManyRelations");
            tblManyToMany = schemaTables.Clone();
            DataTable tblLogical = new DataTable("TablesLogical");
            tblLogical = schemaTables.Clone();

            dictionaryTablesManyToMany.Clear();
            foreach (DataRow tableRow in schemaTables.Rows)
            {
                string tableSchema = null;
                if (tableRow["TABLE_SCHEMA"] != DBNull.Value)
                    tableSchema = tableRow["TABLE_SCHEMA"].ToString();
                string tableName = tableRow["TABLE_NAME"].ToString();

                DataTable manyToOneRelations = GetTableManyToOneRelations(tableSchema, tableName);
                if (manyToOneRelations.Rows.Count == GetTableColumns(tableSchema, tableName).Rows.Count)
                {
                    dictionaryTablesManyToMany.Add(_Provider.QualifiedTableName(tableSchema, tableName));
                    tblManyToMany.ImportRow(tableRow);
                }
                else
                    tblLogical.ImportRow(tableRow);
            }

            Cache.Add("TablesManyToManyRelations", tblManyToMany);
            Cache.Add("TablesLogical", tblLogical);
        }

        #endregion

        #region ' Store Procedures '

        public DataTable GetProcedures()
        {
            string CacheKey = "Procedures";
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable tbl = _Provider.GetProcedures();

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        public DataTable GetProcedureParameters(string procedureSchema, string procedureName)
        {
            string CacheKey = "ProcedureParameters:" + (string.IsNullOrEmpty(procedureSchema) ? procedureName : procedureSchema + "." + procedureName);
            if (Cache.Keys.Contains(CacheKey))
                return Cache[CacheKey];

            DataTable tbl = _Provider.GetProcedureParameters(procedureSchema, procedureName);

            Cache.Add(CacheKey, tbl);
            return tbl;
        }

        #endregion

        #endregion

        #region ' Helpers '

        private DbSchemaProvider GetSchemaProvider(string connectionString, string providerName)
        {
            DbSchemaProvider dbProvider;
            switch (providerName.ToLower())
            {
                case "system.data.sqlserverce.3.5":
                case "system.data.sqlserverce":
                    dbProvider = new SqlServerCeSchemaProvider(connectionString, providerName);
                    break;

                case "system.data.oledb":
                    dbProvider = new OleDbSchemaProvider(connectionString, providerName);
                    break;

                case "system.data.sqlclient":
                    dbProvider = new SqlServerSchemaProvider(connectionString, providerName);
                    break;

                case "mysql.data.mysqlclient":
                    dbProvider = new MySqlSchemaProvider(connectionString, providerName);
                    break;

                default:
                    throw new NotImplementedException("The provider '" + providerName + "' is not implemented!");

            }
            return dbProvider;
        }

        #endregion

    }
}
