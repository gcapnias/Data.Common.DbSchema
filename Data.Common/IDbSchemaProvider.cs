﻿//
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


using System.Data;

namespace Data.Common
{
    interface IDbSchemaProvider
    {
        DataTable GetSchemaTables();
        DataTable GetTableColumns(string tableSchema, string tableName);
        DataTable GetConstraints();
        DataTable GetProcedures();
        DataTable GetProcedureParameters(string procedureSchema, string procedureName);
        DbType GetDbColumnType(string providerDbType);
        string GetPropertyType(string SystemType);
        string GetPropertyType(string SystemType, bool IsNullable);
        string QualifiedTableName(string tableSchema, string tableName);
    }
}
