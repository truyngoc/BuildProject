using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using System.Text;

namespace BuildProject {
	/// <summary>
	/// Summary description for TableDAO.
	/// </summary>
	/// 
	public class TableDAO 
	{
		// constructor
		public TableDAO() {
		}

		// accessors
		public static ArrayList GetTables(string connStr, TypeOfDatabase typeOfDb) {
			ArrayList al = new ArrayList();
			DataTable dt = new DataTable();
			StringBuilder sb = new StringBuilder();
			//SQL Provider
			switch (typeOfDb)
			{
				case TypeOfDatabase.SQL:
					sb.Append("SELECT DISTINCT RTRIM(tbl.table_name) AS TableName");
					sb.Append(" FROM INFORMATION_SCHEMA.TABLES tbl");
					sb.Append(" WHERE tbl.TABLE_TYPE = 'BASE TABLE'");
					break;
				case TypeOfDatabase.Oralce:
					sb.Append("SELECT TABLE_NAME AS TableName ");
					sb.Append("FROM USER_TABLES");
					break;
			}

			try {
				dt = DataProvider.FillDataSet(connStr, sb.ToString()).Tables[0];
				IEnumerator rows = dt.Rows.GetEnumerator();
				while (rows.MoveNext()) {
					Table dataType = new Table();
					DataRow row = (DataRow) rows.Current;
					dataType.TableName = row["TableName"].ToString();
					al.Add(dataType);
				}
				dt.Dispose();
			}
			catch (Exception ex) {
				throw ex;
			}
			return al;
		}

		public static string GetTableSchema(string connStr, string tableName,TypeOfDatabase typeOfDb) {
			string schema = string.Empty;
			StringBuilder sb = new StringBuilder();

			switch (typeOfDb)
			{
				case TypeOfDatabase.SQL:
					sb.Append("SELECT RTRIM(tbl.table_schema) AS TableSchema");
					sb.Append(" FROM INFORMATION_SCHEMA.TABLES tbl");
					sb.Append(" WHERE tbl.TABLE_NAME = '" + tableName + "'");
					try 
					{
						schema = DataProvider.ExecuteScalar(connStr, sb.ToString()).ToString();
					}
					catch (Exception ex) 
					{
						throw ex;
					}
					break;
				case TypeOfDatabase.Oralce:
					//Provider=msdaora;Data Source=KDT;User Id=binhh;Password=binhh
					char[] spliter1 = {';'};
					string[] ret1 =  connStr.Split(spliter1);
					char[] spliter2 = {'='};
					string[] ret2 = ret1[2].Split(spliter2);
					try 
					{
						//schema = OLEDBDataProvider.ExecuteScalar(connStr, sb.ToString()).ToString();
						schema = ret2[1].ToString().Trim().ToUpper();
					}
					catch (Exception ex) 
					{
						throw ex;
					}
					break;
			}
			return schema;
		}

		public static ArrayList GetTableIdentityColumn(string connStr, string tableName, TypeOfDatabase typeOfDb) 
		{
			string identityCol = string.Empty;
			StringBuilder sb = new StringBuilder();
			ArrayList al = new ArrayList();
			DataTable dt = new DataTable();

			if(typeOfDb==TypeOfDatabase.Oralce) return al;

			ArrayList arr = new ArrayList();
			dt = DataProvider.FillDataSet(connStr, "Select c.name as Column_Name from sysobjects o join syscolumns c on o.id=c.id where o.name='" + tableName + "' and not c.autoval is null").Tables[0];

			try 
			{
				if(dt.Rows.Count>0)
				{
					IEnumerator rows = dt.Rows.GetEnumerator();
					while (rows.MoveNext()) 
					{
						Column iCol = new Column();
						DataRow row = (DataRow) rows.Current;
						iCol.ColumnName = row["Column_Name"].ToString();
						al.Add(iCol);
					}
				}
				dt.Dispose();
			}
			catch (Exception ex) 
			{
				throw ex;
			}
			return al;
		}

		public static ArrayList GetTableKeyColumn(string connStr, string tableName,TypeOfDatabase typeOfDb) 
		{
			string identityCol = string.Empty;
			StringBuilder sb = new StringBuilder();
			ArrayList al = new ArrayList();
			DataTable dt = new DataTable();

			switch (typeOfDb)
			{
				case TypeOfDatabase.SQL:
					ArrayList arr = new ArrayList();
					arr.Add(new OleDbParameter("@Table_Name",tableName));
					dt = DataProvider.FillDataSet(connStr, "sp_pkeys",arr).Tables[0];
					break;
				case TypeOfDatabase.Oralce:
					sb.Append("SELECT COLUMN_NAME FROM user_cons_columns a, user_constraints b WHERE a.constraint_name = b.constraint_name AND b.constraint_type = 'P' and a.TABLE_NAME='" + tableName + "'");
					dt = DataProvider.FillDataSet(connStr, sb.ToString()).Tables[0];
					break;
			}

			try 
			{
				//IEnumerator rows = dt.Rows.GetEnumerator();
				for(int i=0;i<dt.Rows.Count;i++) 
				{
					Column iCol = new Column();
					DataRow row = (DataRow) dt.Rows[i];
					iCol.ColumnName = row["Column_Name"].ToString();
					al.Add(iCol);
				}

				dt.Dispose();
			}
			catch (Exception ex) 
			{
				throw ex;
			}
			return al;
		}
		public static ArrayList GetTableRefColumn(string connStr, string tableName,TypeOfDatabase typeOfDb) 
		{
			string refCol = string.Empty;
			StringBuilder sb = new StringBuilder();
			ArrayList al = new ArrayList();
			DataTable dt = new DataTable();

			switch (typeOfDb)
			{
				case TypeOfDatabase.SQL:
					dt = DataProvider.FillDataSet(connStr, "exec sp_fkeys @fktable_name='" + tableName + "'").Tables[0];
					break;
				case TypeOfDatabase.Oralce:
					sb.Append("SELECT a.TABLE_NAME FKTable_Name, a.COLUMN_NAME FKColumn_Name, "
									+ "d.TABLE_NAME PKTable_Name, d.COLUMN_NAME PKColumn_Name "
							+ "FROM user_cons_columns a join user_constraints b on a.constraint_name = b.constraint_name "
									+ "join user_cons_columns d on B.R_CONSTRAINT_NAME = d.constraint_name "
				 					+ "and a.POSITION = d.POSITION "
							+ "WHERE  b.constraint_type = 'R' "
							+	" and a.TABLE_NAME='" + tableName + "'");
					dt = DataProvider.FillDataSet(connStr, sb.ToString()).Tables[0];
					break;
			}

			try 
			{
				IEnumerator rows = dt.Rows.GetEnumerator();
				while (rows.MoveNext()) 
				{
					Column iCol = new Column();
					DataRow row = (DataRow) rows.Current;
					iCol.ColumnName = row["FKColumn_Name"].ToString();
					iCol.RefTable = row["PKTable_Name"].ToString();
					iCol.RefColumn = row["PKColumn_Name"].ToString();
					al.Add(iCol);
				}

				dt.Dispose();
			}
			catch (Exception ex) 
			{
				throw ex;
			}
			return al;
		}
	}
}
