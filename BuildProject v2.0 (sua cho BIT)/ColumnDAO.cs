using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using System.Text;

namespace BuildProject {
	/// <summary>
	/// Summary description for ColumnDAO.
	/// </summary>
	/// 
			
	public enum TypeOfDatabase: int
	{
		SQL = 0, Oralce = 1
	}
		
	public class ColumnDAO {

		// constructor
		public ColumnDAO() {}

		// accessors
		public static ArrayList GetColumns(string connStr, string tableName, string tableSchema,TypeOfDatabase typeOfDb) {
			ArrayList al = new ArrayList();
			DataTable dt = new DataTable();
			StringBuilder sb = new StringBuilder();

			switch (typeOfDb)
			{
				case TypeOfDatabase.SQL:
					sb.Append("SELECT DISTINCT RTRIM(tbl.table_name) AS TableName");
					sb.Append(", RTRIM(col.table_schema) AS TableSchema");
					sb.Append(", RTRIM(col.column_name) AS ColumnName");
					sb.Append(", RTRIM(col.IS_NULLABLE) AS AllowNull");
					sb.Append(", col.ordinal_position AS OrdinalPosition");
					sb.Append(", RTRIM(col.DATA_TYPE) AS DataType");
					sb.Append(", ISNULL(RTRIM(CHARACTER_MAXIMUM_LENGTH), '') AS MaxLen");
					sb.Append(", ISNULL(RTRIM(NUMERIC_PRECISION), '') AS [Precision]");
					sb.Append(", ISNULL(RTRIM(NUMERIC_SCALE), '') AS Scale");
					sb.Append(" FROM INFORMATION_SCHEMA.TABLES tbl");
					sb.Append(" INNER JOIN INFORMATION_SCHEMA.Columns col ON col.TABLE_NAME = tbl.TABLE_NAME");
					sb.Append(" WHERE tbl.TABLE_SCHEMA = '" + tableSchema + "' AND tbl.TABLE_TYPE = 'BASE TABLE'");
					sb.Append(" AND tbl.table_name = '" + tableName + "'");
					sb.Append(" ORDER BY col.ordinal_position");
					break;
				case TypeOfDatabase.Oralce:
					sb.Append("SELECT TABLE_NAME as TableName, ");
					sb.Append("'TableSchema' as TableSchema, ");
					sb.Append("COLUMN_NAME as ColumnName, ");
					sb.Append("COLUMN_ID as OrdinalPosition, ");
					sb.Append("DATA_TYPE as DataType, ");
					sb.Append("decode(NULLABLE,'N','NO','Y','YES') as AllowNull, ");
					sb.Append("DATA_LENGTH as MaxLen, ");
					sb.Append("DATA_PRECISION as Precision, ");
					sb.Append("DATA_SCALE as Scale ");
					sb.Append("FROM USER_TAB_COLS WHERE TABLE_NAME = '" + tableName + "'");
					break;
			}

			try 
			{
				dt = DataProvider.FillDataSet(connStr, sb.ToString()).Tables[0];
				IEnumerator rows = dt.Rows.GetEnumerator();
				while (rows.MoveNext()) 
				{
					Column dataType = new Column();
					DataRow row = (DataRow) rows.Current;
					dataType.TableSchema = row["TableSchema"].ToString();
					dataType.TableName = row["TableName"].ToString();
					dataType.ColumnName = row["ColumnName"].ToString();
					dataType.AllowNull = ((row["AllowNull"].ToString()).ToUpper()=="YES"?true:false);
					dataType.OrdinalPosition = row["OrdinalPosition"].ToString();
					dataType.DataType = row["DataType"].ToString();
					if(row["MaxLen"].ToString().Equals(string.Empty))
						dataType.MaxLen = 0;
					else
						dataType.MaxLen = Int32.Parse(row["MaxLen"].ToString());
					dataType.Length = Common.getLength(dataType);
					dataType.Precision = row["Precision"].ToString();
					dataType.Scale = row["Scale"].ToString();
					dataType.SQLDataType = Common.getSQLClientType(dataType);
					dataType.OracleDataType = Common.getOracleClientType(dataType);
					dataType.VBDataType = Common.convertTypesFromSql(dataType);
                    dataType.CSharpDataType = Common.convertCSharpTypesFromSql(dataType);
					dataType.JavaDataType = Common.convertToJavaTypesFromSql(dataType);
                    dataType.Oracle2DBType = Common.getOracle2DBType(dataType);
					al.Add(dataType);
				}
				dt.Dispose();

				ArrayList tmpTableKeyColumns = TableDAO.GetTableKeyColumn(connStr, tableName,typeOfDb);
				ArrayList tableRefColumns = TableDAO.GetTableRefColumn(connStr, tableName,typeOfDb);
				ArrayList tableIdentityColumns = TableDAO.GetTableIdentityColumn(connStr, tableName,typeOfDb);

				if(al.Count>0)
				{

					//sap xep lai thu cu cot 
					//keyColumn
					for(int z=0;z<al.Count;z++)
					{
						//Primery key
						for(int t=0;t<tmpTableKeyColumns.Count;t++)
						{
							if(((Column)tmpTableKeyColumns[t]).ColumnName.Equals(((Column)al[z]).ColumnName))
							{
								((Column)al[z]).IsPK=true;
								break;
							}
						}
						//Foreign Key
						for(int t=0;t<tableRefColumns.Count;t++)
						{
							if(((Column)tableRefColumns[t]).ColumnName.Equals(((Column)al[z]).ColumnName))
							{
								((Column)al[z]).IsFK=true;
								((Column)al[z]).RefTable = ((Column)tableRefColumns[t]).RefTable;
								((Column)al[z]).RefColumn = ((Column)tableRefColumns[t]).RefColumn;
								break;
							}
						}
						//Identity Column
						for(int t=0;t<tableIdentityColumns.Count;t++)
						{
							if(((Column)tableIdentityColumns[t]).ColumnName.Equals(((Column)al[z]).ColumnName))
							{
								((Column)al[z]).IsIdentity=true;
								break;
							}
						}
					}
				}
			}
			catch (Exception ex) 
			{
				throw ex;
			}
			return al;
		}
	}
}
