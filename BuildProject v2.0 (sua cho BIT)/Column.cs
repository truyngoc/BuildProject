using System;

namespace BuildProject {
	/// <summary>
	/// Summary description for Column.
	/// </summary>
	public class Column {

		private string tableName;
		private string tableSchema;
		private string columnName;
		private bool isPK;
		private bool isFK;
		private bool isIdentity;
		private bool allowNull;
		private string ordinalPosition;
		private string dataType;
		private string sqlDataType;
		private string oracleDataType;
		private string vbDataType;
        private string csharpDataType;
		private string javaDataType;
        private string oracle2DBType;
		private int maxLen;
		private int length;
		private string precision;
		private string scale;
		private string refColumn;
		private string refTable;

		// constructor
		public Column() 
		{
		}

		// accessors
		public string TableName {get {return tableName;} set {tableName = value;}}
		public string TableSchema {get {return tableSchema;} set {tableSchema = value;}}
		public string ColumnName {get {return columnName;} set {columnName = value;}}
		public bool IsPK {get {return isPK;} set {isPK = value;}}
		public bool IsFK {get {return isFK;} set {isFK = value;}}
		public bool IsIdentity {get {return isIdentity;} set {isIdentity = value;}}
		public bool AllowNull {get {return allowNull;} set {allowNull = value;}}
		public string OrdinalPosition {get {return ordinalPosition;} set {ordinalPosition = value;}}
		public string DataType {get {return dataType;} set {dataType = value;}}
		public string SQLDataType {get {return sqlDataType;} set {sqlDataType = value;}}
		public string OracleDataType {get {return oracleDataType;} set {oracleDataType = value;}}
		public string VBDataType {get {return vbDataType;} set {vbDataType = value;}}
        public string CSharpDataType { get { return csharpDataType; } set { csharpDataType = value; } }
		public string JavaDataType {get {return javaDataType;} set {javaDataType = value;}}
        public string Oracle2DBType { get { return oracle2DBType; } set { oracle2DBType = value; } }
		public int MaxLen {get {return maxLen;} set {maxLen = value;}}
		public int Length {get {return length;} set {length = value;}}
		public string Precision {get {return precision;} set {precision = value;}}
		public string Scale {get {return scale;} set {scale = value;}}
		public string RefTable {get {return refTable;} set {refTable = value;}}
		public string RefColumn {get {return refColumn;} set {refColumn = value;}}
		
		public void setValue(Column p)
		{
			tableName = p.TableName;
			tableSchema = p.TableSchema;
			columnName	= p.ColumnName;
			allowNull	= p.AllowNull;
			ordinalPosition = p.OrdinalPosition;
			dataType	= p.DataType;
			maxLen		= p.MaxLen;
			precision	= p.Precision;
			scale		= p.Scale;
			//refColumn	= p.RefColumn;
			//refTable	= p.RefTable;
		}
	}
}
