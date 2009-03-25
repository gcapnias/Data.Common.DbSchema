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
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Reflection;
using System.Text;


namespace Data.Common
{
    public class MySqlSchemaProvider : DbSchemaProvider
    {
        public MySqlSchemaProvider(string connectionstring, string providername) : base(connectionstring, providername) { }

        #region ' IDbProvider Members '

        public override DataTable GetConstraints()
        {
            DataTable tbl = new DataTable("Constraints");
            using (DbConnection _Connection = this.GetDBConnection())
            {
                DbCommand _Command = _Connection.CreateCommand();
                _Command.CommandText = sqlConstraints;
                _Command.CommandType = CommandType.Text;
                tbl.Load(_Command.ExecuteReader());
            }

            return tbl;
        }

        public override string QualifiedTableName(string tableSchema, string tableName)
        {
            if (!string.IsNullOrEmpty(tableSchema))
                return string.Format("`{0}`.`{1}`", tableSchema, tableName);
            else
                return string.Format("`{0}`", tableName);
        }

        public override DataTable GetProcedureParameters(string procedureSchema, string procedureName)
        {
            DataTable tbl = GetDTProcedureParameters();
            using (DbConnection _Connection = GetDBConnection())
            {
                DbCommand _Command = _Connection.CreateCommand();
                _Command.CommandText = this.QualifiedTableName(procedureSchema, procedureName);
                _Command.CommandType = CommandType.StoredProcedure;

                DbParameter par = _Command.CreateParameter();

                DbProviderFactory pf = DbProviderFactories.GetFactory(this.ProviderName);
                DbCommandBuilder cb = pf.CreateCommandBuilder();
                MethodInfo theMethod = cb.GetType().GetMethod("DeriveParameters");
                theMethod.Invoke(cb, new object[] { _Command });

                int counter = 1;
                foreach (DbParameter p in _Command.Parameters)
                {
                    DataRow parameterRow = tbl.NewRow();
                    if (!string.IsNullOrEmpty(procedureSchema))
                        parameterRow["SPECIFIC_SCHEMA"] = procedureSchema;
                    parameterRow["SPECIFIC_NAME"] = procedureName;
                    parameterRow["PARAMETER_NAME"] = p.ParameterName;
                    parameterRow["ORDINAL_POSITION"] = counter;
                    parameterRow["PARAMETER_MODE"] = p.Direction;
                    parameterRow["IS_RESULT"] = p.Direction == ParameterDirection.ReturnValue;
                    parameterRow["DATA_TYPE"] = p.DbType;
                    parameterRow["CHARACTER_MAXIMUM_LENGTH"] = p.Size;

                    tbl.Rows.Add(parameterRow);
                    counter++;
                }
            }

            return tbl;
        }

        public override DbType GetDbType(string providerDbType)
        {
            switch (providerDbType)
            {
                case "0":   // MySqlDbType.Decimal
                case "246": // MySqlDbType.NewDecimal
                    return DbType.Decimal;

                case "1":   // MySqlDbType.Byte
                    return DbType.SByte;

                case "2":   // MySqlDbType.Int16
                    return DbType.Int16;

                case "3":   // MySqlDbType.Int32
                case "9":   // MySqlDbType.Int24
                    return DbType.Int32;

                case "4":   // MySqlDbType.Float
                    return DbType.Single;

                case "5":   // MySqlDbType.Double
                    return DbType.Double;

                case "7":   // MySqlDbType.Timestamp
                case "12":  // MySqlDbType.DateTime
                    return DbType.DateTime;

                case "8":   // MySqlDbType.Int64
                    return DbType.Int64;

                case "10":  // MySqlDbType.Date
                case "13":  // MySqlDbType.Year
                case "14":  // MySqlDbType.Newdate
                    return DbType.Date;

                case "11":  // MySqlDbType.Time
                    return DbType.Time;

                case "16":  // MySqlDbType.Bit
                case "508": // MySqlDbType.UInt64
                    return DbType.UInt64;

                case "249": // MySqlDbType.TinyBlob
                case "250": // MySqlDbType.MediumBlob
                case "251": // MySqlDbType.LongBlob
                case "252": // MySqlDbType.Blob
                    return DbType.Binary;

                case "254": // MySqlDbType.String
                    return DbType.StringFixedLength;

                case "247": // MySqlDbType.Enum
                    return DbType.String;

                case "248": // MySqlDbType.Set
                case "253": // MySqlDbType.VarChar
                case "750": // MySqlDbType.MediumText
                case "749": // MySqlDbType.TinyText
                case "751": // MySqlDbType.LongText
                case "752": // MySqlDbType.Text
                    return DbType.String;

                case "501": // MySqlDbType.UByte
                    return DbType.Byte;

                case "502": // MySqlDbType.UInt16
                    return DbType.UInt16;

                case "503": // MySqlDbType.UInt32
                case "509": // MySqlDbType.UInt24
                    return DbType.UInt32;

                default:
                    return DbType.AnsiString;
            }
        }

        #endregion

        #region ' SQL code: database constrains '
        //
        // MySQL Server: find database constrains
        //
        const string sqlConstraints =
            "SELECT" +
            "	KCUUC.TABLE_CATALOG AS PK_TABLE_CATALOG," +
            "	KCUUC.TABLE_SCHEMA AS PK_TABLE_SCHEMA," +
            "	KCUUC.TABLE_NAME AS PK_TABLE_NAME," +
            "	KCUUC.COLUMN_NAME AS PK_COLUMN_NAME," +
            "	KCUUC.ORDINAL_POSITION AS PK_ORDINAL_POSITION," +
            "	KCUUC.CONSTRAINT_NAME AS PK_NAME," +
            "	KCUC.TABLE_CATALOG AS FK_TABLE_CATALOG," +
            "	KCUC.TABLE_SCHEMA AS FK_TABLE_SCHEMA," +
            "	KCUC.TABLE_NAME AS FK_TABLE_NAME," +
            "	KCUC.COLUMN_NAME AS FK_COLUMN_NAME," +
            "	KCUC.ORDINAL_POSITION AS FK_ORDINAL_POSITION," +
            "	KCUC.CONSTRAINT_NAME AS FK_NAME " +
            "FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC " +
            "INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCUC" +
            "	ON (KCUC.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA" +
            "  AND KCUC.CONSTRAINT_NAME = RC.CONSTRAINT_NAME" +
            "  AND KCUC.TABLE_NAME = RC.TABLE_NAME)" +
            "INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCUUC" +
            "	ON (KCUUC.CONSTRAINT_SCHEMA = RC.UNIQUE_CONSTRAINT_SCHEMA" +
            "  AND KCUUC.CONSTRAINT_NAME = RC.UNIQUE_CONSTRAINT_NAME" +
            "  AND KCUUC.TABLE_NAME = RC.REFERENCED_TABLE_NAME)";

        #endregion

    }
}
