using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;

namespace BuildProject {

	public class DataProvider {

		// constructor
		static DataProvider() {
		}

		// public methods
		/// <summary>
		/// Insert, update, or delete a record in the database.
		/// </summary>
		/// <param name="connStr">A connection string to open the database.</param>
		/// <param name="sqlQuery">The SQL query to run against the database.</param>
		/// <returns>The number of rows affected by the operation.</returns>
		public static int ExecuteNonQuery(string connStr, string sqlQuery) {
			int numRowsAffected = 0;
			try {
				using (OleDbConnection cn = new OleDbConnection(connStr)) {
					cn.Open();
					OleDbCommand cmd = new OleDbCommand(sqlQuery, cn);
					numRowsAffected = cmd.ExecuteNonQuery();
					cmd.Dispose();
					cn.Close();
				}
			}
			catch (OleDbException OleDbex) {
				throw OleDbex;
			}
			catch (Exception ex) {
				throw ex;
			}
			return numRowsAffected;
		}

		/// <summary>
		/// Insert, update, or delete a record in the database.
		/// </summary>
		/// <param name="connStr">A connection string to open the database.</param>
		/// <param name="sqlQuery">The SQL stored procedure to run against the database.</param>
		/// <param name="parms">An ArrayList of OleDbParameters.</param>
		/// <returns>The number of rows affected by the operation.</returns>
		public static int ExecuteNonQuery(string connStr, string sqlQuery, ArrayList parms) {
			int numRowsAffected = 0;
			try {
				using (OleDbConnection cn = new OleDbConnection(connStr)) {
					cn.Open();
					OleDbCommand cmd = new OleDbCommand(sqlQuery, cn);
					cmd.CommandType = CommandType.StoredProcedure;
					IEnumerator eNumParms = parms.GetEnumerator();
					while (eNumParms.MoveNext()) {
						OleDbParameter parm = (OleDbParameter) eNumParms.Current;
						cmd.Parameters.Add(parm);
					}
					numRowsAffected = cmd.ExecuteNonQuery();
					cmd.Dispose();
					cn.Close();
				}
			}
			catch (OleDbException OleDbex) {
				throw OleDbex;
			}
			catch (Exception ex) {
				throw ex;
			}
			return numRowsAffected;
		}

		/// <summary>
		/// Execute a query that returns a scalar value. Especially useful for Insert operations
		/// that will return the identity of the new row (SELECT @@Identity).
		/// </summary>
		/// <param name="connStr">A connection string to open the database.</param>
		/// <param name="sqlQuery">The SQL query to run against the database.</param>
		/// <returns>The scalar value returned by the database.</returns>
		public static string ExecuteScalar(string connStr, string sqlQuery) {
			string result = string.Empty;
			try {
				using (OleDbConnection cn = new OleDbConnection(connStr)) {
					cn.Open();
					OleDbCommand cmd = new OleDbCommand(sqlQuery, cn);
					object oResult = cmd.ExecuteScalar();
					if (oResult != null) {
						result = oResult.ToString();
					}
					cmd.Dispose();
					cn.Close();
				}
			}
			catch (OleDbException OleDbex) {
				throw OleDbex;
			}
			catch (Exception ex) {
				throw ex;
			}
			return result;
		}

		/// <summary>
		/// Execute a query that returns a scalar value. Especially useful for Insert operations
		/// that will return the identity of the new row (SELECT @@Identity).
		/// </summary>
		/// <param name="connStr">A connection string to open the database.</param>
		/// <param name="sqlQuery">The SQL stored procedure to run against the database.</param>
		/// <param name="parms">An ArrayList of OleDbParameters.</param>
		/// <returns>The scalar value returned by the database.</returns>
		public static string ExecuteScalar(string connStr, string sqlQuery, ArrayList parms) {
			string result = string.Empty;
			try {
				using (OleDbConnection cn = new OleDbConnection(connStr)) {
					cn.Open();
					OleDbCommand cmd = new OleDbCommand(sqlQuery, cn);
					cmd.CommandType = CommandType.StoredProcedure;
					IEnumerator eNumParms = parms.GetEnumerator();
					while (eNumParms.MoveNext()) {
						OleDbParameter parm = (OleDbParameter) eNumParms.Current;
						cmd.Parameters.Add(parm);
					}
					object oResult = cmd.ExecuteScalar();
					if (oResult != null) {
						result = oResult.ToString();
					}
					cmd.Dispose();
					cn.Close();
				}
			}
			catch (OleDbException OleDbex) {
				throw OleDbex;
			}
			catch (Exception ex) {
				throw ex;
			}
			return result;
		}

		/// <summary>
		/// Retrieve a data set.
		/// </summary>
		/// <param name="connStr">A connection string to open the database.</param>
		/// <param name="sqlQuery">The SQL Select query to run against the database.</param>
		/// <returns>A populated data set.</returns>
		public static DataSet FillDataSet(string connStr, string sqlQuery) {
			DataSet ds = new DataSet();
			try {
				using (OleDbConnection cn = new OleDbConnection(connStr)) {
					OleDbCommand cmd = cn.CreateCommand();
					cmd.CommandText = sqlQuery;
					OleDbDataAdapter da = new OleDbDataAdapter(cmd);
					da.Fill(ds);
					da.Dispose();
					cmd.Dispose();
					cn.Close();
				}
			}
			catch (OleDbException OleDbex) {
				throw OleDbex;
			}
			catch (Exception ex) {
				throw ex;
			}
			return ds;
		}

		/// <summary>
		/// Retrieve a data set.
		/// </summary>
		/// <param name="connStr">A connection string to open the database.</param>
		/// <param name="sqlQuery">The SQL stored procedure to run against the database.</param>
		/// <param name="parms">An ArrayList of OleDbParameters.</param>
		/// <returns>A populated data set.</returns>
		public static DataSet FillDataSet(string connStr, string sqlQuery, ArrayList parms) {
			DataSet ds = new DataSet();
			try {
				using (OleDbConnection cn = new OleDbConnection(connStr)) {
					OleDbCommand cmd = cn.CreateCommand();
					cmd.CommandText = sqlQuery;
					cmd.CommandType = CommandType.StoredProcedure;
					IEnumerator eNumParms = parms.GetEnumerator();
					while (eNumParms.MoveNext()) {
						OleDbParameter parm = (OleDbParameter) eNumParms.Current;
						cmd.Parameters.Add(parm);
					}
					OleDbDataAdapter da = new OleDbDataAdapter(cmd);
					da.Fill(ds);
					da.Dispose();
					cmd.Dispose();
					cn.Close();
				}
			}
			catch (OleDbException OleDbex) {
				throw OleDbex;
			}
			catch (Exception ex) {
				throw ex;
			}
			return ds;
		}

	}

}
