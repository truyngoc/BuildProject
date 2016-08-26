using System;

namespace BuildProject
{
	/// <summary>
	/// Summary description for common.
	/// </summary>

	public class Common
	{
		public Common()
		{
			//
			// TODO: Add constructor logic here
			//
		}
		public static string initialLower(string columnName) 
		{
			return columnName.Substring(0, 1).ToLower() + columnName.Substring(1);
		}

		public static string convertTypesFromSql (Column col) 
		{
			string outType = string.Empty;
			string sqlType = col.DataType.ToLower().Trim();
			switch (sqlType) 
			{
				case "binary": 
					outType = "byte";
					break;
				case "bit":
					outType = "boolean";
					break;
				case "datetime":
					outType = "datetime";
					break;
				case "date":
					outType = "date";
					break;
				case "smalldatetime":
					outType = "datetime";
					break;
				case "timestamp":
					outType = "string";
					break;
				case "decimal":
					outType = "double";
					break;
				case "float":
					outType = "double";
					break;
				case "numeric":
					outType = "double";
					break;
				case "int":
					outType = "integer";
					break;
				case "number":
					if(col.Precision=="" || col.Precision=="0")
						outType = "integer";
					else
						outType = "double";
					break;
				case "integer":
					outType = "integer";
					break;
				case "real":
					outType = "double";
					break;
				case "money":
					outType = "double";
					break;
				case "smallmoney":
					outType = "double";
					break;
				case "char":
					outType = "string";
					break;
				case "nchar":
					outType = "string";
					break;
				case "ntext":
					outType = "string";
					break;
				case "nvarchar":
					outType = "string";
					break;
				case "nvarchar2":
					outType = "string";
					break;
				case "varchar":
					outType = "string";
					break;
				case "varchar2":
					outType = "string";
					break;
				case "text":
					outType = "string";
					break;
				case "smallint":
					outType = "integer";
					break;
				case "tinyint":
					outType = "integer";
					break;
				case "uniqueidentifier":
					outType = "guid";
					break;
				default:
					outType = "xxx";
					break;
			}
			return outType;
		}


        public static string convertCSharpTypesFromSql(Column col)
        {
            string outType = string.Empty;
            string sqlType = col.DataType.ToLower().Trim();
            switch (sqlType)
            {
                case "binary":
                    outType = "byte";
                    break;
                case "bit":
                    outType = "bool";
                    break;
                case "datetime":
                    outType = "DateTime";
                    break;
                case "date":
                    outType = "DateTime";
                    break;
                case "smalldatetime":
                    outType = "DateTime";
                    break;
                case "timestamp":
                    outType = "string";
                    break;
                case "decimal":
                    outType = "decimal";
                    break;
                case "float":
                    outType = "float";
                    break;
                case "numeric":
                    outType = "double";
                    break;
                case "int":
                    outType = "int";
                    break;
                case "number":
                    if (col.Precision == "" || col.Precision == "0")
                        outType = "int";
                    else
                        outType = "double";
                    break;
                case "integer":
                    outType = "int";
                    break;
                case "real":
                    outType = "decimal";
                    break;
                case "money":
                    outType = "decimal";
                    break;
                case "smallmoney":
                    outType = "decimal";
                    break;
                case "char":
                    outType = "string";
                    break;
                case "nchar":
                    outType = "string";
                    break;
                case "ntext":
                    outType = "string";
                    break;
                case "nvarchar":
                    outType = "string";
                    break;
                case "nvarchar2":
                    outType = "string";
                    break;
                case "varchar":
                    outType = "string";
                    break;
                case "varchar2":
                    outType = "string";
                    break;
                case "text":
                    outType = "string";
                    break;
                case "smallint":
                    outType = "int";
                    break;
                case "tinyint":
                    outType = "int";
                    break;
                case "uniqueidentifier":
                    outType = "Guid";
                    break;
                default:
                    outType = "xxx";
                    break;
            }
            return outType;
        }

		public static string convertToJavaTypesFromSql (Column col) 
		{
			string outType = string.Empty;
			string sqlType = col.DataType.ToLower().Trim();
			switch (sqlType) 
			{
				case "binary": 
					outType = "Byte";
					break;
				case "bit":
					outType = "Boolean";
					break;
				case "datetime":
					outType = "DateTime";
					break;
				case "date":
					outType = "Date";
					break;
				case "smalldatetime":
					outType = "DateTime";
					break;
				case "timestamp":
					outType = "String";
					break;
				case "decimal":
					outType = "Double";
					break;
				case "float":
					outType = "Double";
					break;
				case "numeric":
					outType = "Double";
					break;
				case "int":
					outType = "Integer";
					break;
				case "number":
					if(col.Precision=="" || col.Precision=="0")
						outType = "Integer";
					else
						outType = "Double";
					break;
				case "integer":
					outType = "Integer";
					break;
				case "real":
					outType = "Double";
					break;
				case "money":
					outType = "Double";
					break;
				case "smallmoney":
					outType = "Double";
					break;
				case "char":
					outType = "String";
					break;
				case "nchar":
					outType = "String";
					break;
				case "ntext":
					outType = "String";
					break;
				case "nvarchar":
					outType = "String";
					break;
				case "nvarchar2":
					outType = "String";
					break;
				case "varchar":
					outType = "String";
					break;
				case "varchar2":
					outType = "String";
					break;
				case "text":
					outType = "String";
					break;
				case "smallint":
					outType = "Integer";
					break;
				case "tinyint":
					outType = "Integer";
					break;
				case "uniqueidentifier":
					outType = "Guid";
					break;
				default:
					outType = "xxx";
					break;
			}
			return outType;
		}

		public static int getLength (Column col) 
		{
			int outLength = 0;
			string sqlType = col.DataType.ToLower().Trim();
			switch (sqlType) 
			{
				case "binary": 
				case "bit":
				case "datetime":
				case "date":
				case "smalldatetime":
				case "timestamp":
				case "decimal":
				case "float":
				case "numeric":
				case "int":
				case "number":
				case "integer":
				case "real":
				case "money":
				case "smallmoney":
				case "smallint":
				case "tinyint":
				case "uniqueidentifier":
				case "text":
				case "ntext":
				case "image":
					outLength = 0;
					break;
				case "char":
				case "nchar":
				case "nvarchar":
				case "nvarchar2":
				case "varchar":
				case "varchar2":
					outLength = col.MaxLen;
					break;
				default:
					outLength = col.MaxLen;
					break;
			}
			return outLength;
		}

		public static string getSQLClientType (Column col) 
		{
			return col.DataType;
		}

		public static string getOracleClientType (Column col) 
		{
			string outType = string.Empty;
			switch (col.DataType.ToLower().Trim()) 
			{
				case "number": 
					if(col.Precision=="" || col.Precision=="0")
						outType = "Int32";
					else
						outType = "Decimal";
					break;
				case "bit":
					outType = "Byte";
					break;
				case "datetime":
				case "date":
				case "smalldatetime":
					outType = "Date";
					break;
				case "timestamp":
					outType = "TimeStamp";
					break;
				case "decimal":
				case "numeric":
					outType = "Decimal";
					break;
				case "int":
				case "integer":
					outType = "Int32";
					break;
				case "real":
					outType = "Decimal";
					break;
				case "money":
				case "smallmoney":
					outType = "Decimal";
					break;
				case "char":
					outType = "Char";
					break;
				case "nchar":
					outType = "NChar";
					break;
				case "ntext":
					outType = "NText";
					break;
				case "nvarchar":
				case "nvarchar2":
					outType = "NVarchar2";
					break;
				case "varchar":
				case "varchar2":
					outType = "Varchar2";
					break;
				case "text":
					outType = "Text";
					break;
				case "smallint":
				case "tinyint":
					outType = "Int32";
					break;
				default:
					outType = "BIBI";
					break;
			}
			return outType;
		}

        public static string getOracle2DBType(Column col)
        {
            string outType = string.Empty;
            switch (col.DataType.ToLower().Trim())
            {
                case "number":
                    if (col.Precision == "" || col.Precision == "0")
                        outType = "Int32";
                    else
                        outType = "Decimal";
                    break;
                case "bit":
                    outType = "Byte";
                    break;
                case "datetime":
                case "date":
                case "smalldatetime":
                    outType = "Date";
                    break;
                case "timestamp":
                    outType = "TimeStamp";
                    break;
                case "decimal":
                case "numeric":
                    outType = "Decimal";
                    break;
                case "int":
                case "integer":
                    outType = "Int32";
                    break;
                case "real":
                    outType = "Decimal";
                    break;
                case "money":
                case "smallmoney":
                    outType = "Decimal";
                    break;
                case "char":
                    outType = "String";
                    break;
                case "nchar":
                    outType = "String";
                    break;
                case "ntext":
                    outType = "String";
                    break;
                case "nvarchar":
                case "nvarchar2":
                    outType = "String";
                    break;
                case "varchar":
                case "varchar2":
                    outType = "String";
                    break;
                case "text":
                    outType = "String";
                    break;
                case "smallint":
                case "tinyint":
                    outType = "Int32";
                    break;
                default:
                    outType = "BIBI";
                    break;
            }
            return outType;
        }
	}

	public class Template
	{
		public Template()
		{
		}
		private string _Text;
		private string _FilePath;
		private string _OutputExt;
		private string _OutputSubFolder;
		private bool _GroupFile;
		private bool _Selected;

		public string Text{get{return _Text;} set{_Text=value;}}
		public string FilePath{get{return _FilePath;} set{_FilePath=value;}}
		public string OutputExt{get{return _OutputExt;} set{_OutputExt=value;}}
		public string OutputSubFolder{get{return _OutputSubFolder;} set{_OutputSubFolder=value;}}
		public bool GroupFile{get{return _GroupFile;} set{_GroupFile=value;}}
		public bool Selected{get{return _Selected;} set{_Selected=value;}}
		public override string ToString(){return _Text;}
	}
	public class ExtSetting
	{
		public ExtSetting()
		{
		}
		public ExtSetting(string name, string val)
		{
			_Name = name;
			_Value = val;
		}
		private string _Name;
		private string _Value;

		public string Value{get{return _Value;} set{_Value=value;}}
		public string Name{get{return _Name;} set{_Name=value;}}
		public override string ToString(){return _Name;}
	}
}
