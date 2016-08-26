using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Data;
using System.Diagnostics;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;

//using Microsoft.SqlServer.Management;
//using Microsoft.SqlServer.Management.Smo;

namespace BuildProject
{
    /// <summary>
    /// SmoHelper is a helper class to populate SQL server objects via SMO library.
    /// </summary>
    public class XMLHelper
    {
        /// <summary>
        /// BUILDPROJECT_VERSION indicates the current version and date of BUILDPROJECT.
        /// </summary>
        internal const string BUILDPROJECT_VERSION = "v0.9a 2006-10-15";


        /// <summary>
        /// GenerateEntityXmlFromTable generates a xml file basing on the information of the table passed in.
        /// </summary>
        public static void GenerateEntityXmlFromTable(Table table, ArrayList columns, ArrayList extSettings, string outputFile)
        {
            if (table != null && System.IO.File.Exists(outputFile))
            {
                System.Xml.XmlTextWriter xtw = new System.Xml.XmlTextWriter(outputFile, System.Text.Encoding.UTF8);
                xtw.Formatting = System.Xml.Formatting.Indented;
                xtw.WriteProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-8\"");

                //generate entity calss
                xtw.WriteStartElement("entity");
				xtw.WriteAttributeString("tableName", table.TableName);
				xtw.WriteAttributeString("tableSchema", table.TableSchema);
				if(extSettings!=null)
				{
					foreach(ExtSetting e in extSettings)
					{
						xtw.WriteAttributeString(e.Name, e.Value);
					}
				}
//					xtw.WriteAttributeString("namespace", codeNamespace);
//                    xtw.WriteAttributeString("author", Utility.GetCurrentIdentityName());
//                    xtw.WriteAttributeString("createdDateTime", System.DateTime.Now.ToString("s"));
                xtw.WriteAttributeString("BuildProject", BUILDPROJECT_VERSION);

                #region columns/properties
                //generate property node
                xtw.WriteStartElement("columns");
                for(int i =0;i<columns.Count;i++)
                {
                    GenerateXmlElementFromColumn((Column)columns[i], xtw);
                }
                xtw.WriteEndElement();
                #endregion

                xtw.WriteEndElement();
                xtw.Flush();
                xtw.Close();
            }
        }

        /// <summary>
        /// GenerateXmlElementFromColumn generate a xml element from column's definition.
        /// </summary>
        private static void GenerateXmlElementFromColumn(Column c, System.Xml.XmlTextWriter xtw)
        {
            xtw.WriteStartElement("property");
            xtw.WriteAttributeString("columnName", c.ColumnName);
            xtw.WriteAttributeString("dataType", c.DataType);
			xtw.WriteAttributeString("sqlDataType", c.SQLDataType);
			xtw.WriteAttributeString("oracleDataType", c.OracleDataType);
			xtw.WriteAttributeString("vbDataType", c.VBDataType);
			xtw.WriteAttributeString("javaDataType", c.JavaDataType);
            xtw.WriteAttributeString("oracle2DBType", c.Oracle2DBType);
			xtw.WriteAttributeString("maxLength", c.MaxLen.ToString());
			xtw.WriteAttributeString("length", c.Length.ToString());
			xtw.WriteAttributeString("scale", c.Scale);
            xtw.WriteAttributeString("ordinalPosition", c.OrdinalPosition);
            xtw.WriteAttributeString("precision", c.Precision);
            xtw.WriteAttributeString("allowNull", c.AllowNull.ToString());
            xtw.WriteAttributeString("isPK", c.IsPK.ToString());
            xtw.WriteAttributeString("isFK", c.IsFK.ToString());
            xtw.WriteAttributeString("isIdentity", c.IsIdentity.ToString());
            xtw.WriteAttributeString("refTable", c.RefTable);
            xtw.WriteAttributeString("refColumn", c.RefColumn);
            xtw.WriteEndElement();
        }

		public static void Transform(string xsltFile, string xmlFile, string outputFile)
		{
			if (xsltFile!="" && xmlFile!="")
			{
				if (File.Exists(xsltFile) && File.Exists(xmlFile))
				{
//					XslTransform xslTran = new XslTransform();
//					xslTran.Load(xsltFile);				
//					xslTran.Transform(xmlFile,outputFile);

					XPathDocument xpathDoc = new XPathDocument(xmlFile);
					XPathNavigator xpathNavigator = xpathDoc.CreateNavigator();
					XslTransform xslTran = new XslTransform();
					xslTran.Load(xsltFile);				

					XsltArgumentList args = new XsltArgumentList();
					//Add the namespaceURI and object to the object collection
					XsltDateTime xsltExtObj = new XsltDateTime();
					args.AddExtensionObject("urn:xsltExtension-DateTime",xsltExtObj);
					//Create file writer
					System.IO.FileStream xw = new FileStream(outputFile,System.IO.FileMode.Create);
					
					xslTran.Transform(xpathNavigator,args,xw);
					xw.Close();
				}
			}
		}
		public static void GenCode(Table table, ArrayList columns, ArrayList extSettings, string xslFile, string outputFile)
		{
			string xmlFile = Path.GetTempFileName();
			//System.IO.File.Create(xmlFile);
			GenerateEntityXmlFromTable(table,columns,extSettings,xmlFile);
			Transform(xslFile,xmlFile, outputFile);
			System.IO.File.Delete(xmlFile);
		}
	
	}
	public class XsltDateTime 
	{
		DateTime _date;
		public XsltDateTime() 
		{
			_date = DateTime.Now;
		}
		public DateTime GetDateTime() 
		{
			return _date;
		}
		public string GetDateTime(string format) 
		{
			return _date.ToString(format);
		}
	}

}
