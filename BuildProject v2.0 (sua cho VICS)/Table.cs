using System;

namespace BuildProject {
	/// <summary>
	/// Summary description for Table.
	/// </summary>
	public class Table {

		private string tableName;
		private string tableSchema;

		// constructor
		public Table() {
		}

		// accessors
		public string TableName {get {return tableName;} set {tableName = value;}}
		public string TableSchema {get {return tableSchema;} set {tableSchema = value;}}
	}
}
