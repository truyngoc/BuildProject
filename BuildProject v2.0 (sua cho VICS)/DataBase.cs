using System;

namespace BuildProject {
	/// <summary>
	/// Summary description for DataBase.
	/// </summary>
	public class DataBase {

		private int dbIndex;
		private string dbKey;
		private string dbValue;

		public DataBase(int dbIndex, string dbKey, string dbValue) {
			this.dbIndex = dbIndex;
			this.dbKey = dbKey;
			this.dbValue = dbValue;
		}

		public int DbIndex {get{return dbIndex;}}
		public string DbKey {get{return dbKey;}}
		public string DbValue {get{return dbValue;}}
	}
}
