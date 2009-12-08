using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data.Common;

namespace SchemaExplorer
{
    class DbSchemaProvider : IDbSchemaProvider, IDbConnectionStringEditor
    {
        #region ' IDbSchemaProvider Members '

        public string Description
        {
            get { throw new NotImplementedException(); }
        }

        public ParameterSchema[] GetCommandParameters(string connectionString, CommandSchema command)
        {
            throw new NotImplementedException();
        }

        public CommandResultSchema[] GetCommandResultSchemas(string connectionString, CommandSchema command)
        {
            throw new NotImplementedException();
        }

        public string GetCommandText(string connectionString, CommandSchema command)
        {
            throw new NotImplementedException();
        }

        public CommandSchema[] GetCommands(string connectionString, DatabaseSchema database)
        {
            throw new NotImplementedException();
        }

        public string GetDatabaseName(string connectionString)
        {
            throw new NotImplementedException();
        }

        public ExtendedProperty[] GetExtendedProperties(string connectionString, SchemaObjectBase schemaObject)
        {
            throw new NotImplementedException();
        }

        public ColumnSchema[] GetTableColumns(string connectionString, TableSchema table)
        {
            throw new NotImplementedException();
        }

        public System.Data.DataTable GetTableData(string connectionString, TableSchema table)
        {
            throw new NotImplementedException();
        }

        public IndexSchema[] GetTableIndexes(string connectionString, TableSchema table)
        {
            throw new NotImplementedException();
        }

        public TableKeySchema[] GetTableKeys(string connectionString, TableSchema table)
        {
            throw new NotImplementedException();
        }

        public PrimaryKeySchema GetTablePrimaryKey(string connectionString, TableSchema table)
        {
            throw new NotImplementedException();
        }

        public TableSchema[] GetTables(string connectionString, DatabaseSchema database)
        {
            throw new NotImplementedException();
        }

        public ViewColumnSchema[] GetViewColumns(string connectionString, ViewSchema view)
        {
            throw new NotImplementedException();
        }

        public System.Data.DataTable GetViewData(string connectionString, ViewSchema view)
        {
            throw new NotImplementedException();
        }

        public string GetViewText(string connectionString, ViewSchema view)
        {
            throw new NotImplementedException();
        }

        public ViewSchema[] GetViews(string connectionString, DatabaseSchema database)
        {
            throw new NotImplementedException();
        }

        public string Name
        {
            get { throw new NotImplementedException(); }
        }

        public void SetExtendedProperties(string connectionString, SchemaObjectBase schemaObject)
        {
            throw new NotImplementedException();
        }

        #endregion

        #region IDbConnectionStringEditor Members

        public string ConnectionString
        {
            get { throw new NotImplementedException(); }
        }

        public bool EditorAvailable
        {
            get { throw new NotImplementedException(); }
        }

        public bool ShowEditor(string currentConnectionString)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
