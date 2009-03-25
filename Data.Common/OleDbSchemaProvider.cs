using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;

namespace Data.Common
{
    public class OleDbSchemaProvider : DbSchemaProvider
    {
        public OleDbSchemaProvider(string connectionstring, string providername) : base(connectionstring, providername) { }

        #region ' IDbProvider Members '

        public override DataTable GetConstraints()
        {
            DataTable tbl = new DataTable("Constraints");
            using (OleDbConnection OleDbConn = (OleDbConnection)GetDBConnection())
            {
                tbl = OleDbConn.GetOleDbSchemaTable(OleDbSchemaGuid.Foreign_Keys, new object[] { });
            }

            return tbl;
        }

        public override DbType GetDbType(string providerDbType)
        {
            throw new NotImplementedException();
        }

        #endregion


    }
}
