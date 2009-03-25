﻿//
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
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Data.Common
{
    interface IDbSchemaProvider
    {
        DataTable GetSchemaTables();
        DataTable GetTableColumns(string tableSchema, string tableName);
        DataTable GetConstraints();
        DataTable GetProcedures();
        DataTable GetProcedureParameters(string procedureSchema, string procedureName);
        DbType GetDbType(string providerDbType);
        string GetPropertyType(string SystemType);
        string GetPropertyType(string SystemType, bool IsNullable);
        string QualifiedTableName(string tableSchema, string tableName);
    }
}
