//
//  Data.Common.DbSchema - http://dbschema.codeplex.com
//
//  The contents of this file are subject to the New BSD
//  License (the "License"); you may not use this file
//  except in compliance with the License. You may obtain a copy of
//  the License at http://www.opensource.org/licenses/bsd-license.php
//
//  Software distributed under the License is distributed on an 
//  "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
//  implied. See the License for the specific language governing
//  rights and limitations under the License.
//


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

        public override DbType GetDbColumnType(string providerDbType)
        {
            throw new NotImplementedException();
        }

        #endregion


    }
}
