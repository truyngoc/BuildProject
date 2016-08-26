using System;
using System.Collections;
using System.Configuration;
using System.Collections.Specialized;
using System.IO;
using System.Windows.Forms;
using System.Data;

namespace BuildProject
{
	/// <summary>
	/// Summary description for BuildProject.
	/// </summary>
	public class frmBuildProject : System.Windows.Forms.Form
	{
		private string folderName = string.Empty;
		private string tableName = string.Empty;
		private string tableSchema = string.Empty;
		private ArrayList tableKeyColumns =new ArrayList();
		private ArrayList tableRefColumns =new ArrayList();
		private ArrayList tableIdentityColumns =new ArrayList();
		private string outputType = string.Empty;
		protected TypeOfDatabase typeOfDb;
		private ArrayList DbKeys = new ArrayList();
		private System.Windows.Forms.GroupBox groupBox2;
		private System.Windows.Forms.Button btnOutputCode;
		private System.Windows.Forms.Label lblOutputFolder;
		private System.Windows.Forms.Button btnSelectOutputFolder;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.RadioButton optOracle;
		private System.Windows.Forms.RadioButton optSQL;
		private System.Windows.Forms.Button btnShowTables;
		private System.Windows.Forms.ComboBox cbxDatabases;
		private System.Windows.Forms.ListBox lstAllTables;
		private System.Windows.Forms.ListBox lstTables;
		private System.Windows.Forms.Button cmdSel;
		private System.Windows.Forms.Button cmdSelAll;
		private System.Windows.Forms.Button cmdDeSelAll;
		private System.Windows.Forms.Button cmdDeSel;
		private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog1;
		private System.Windows.Forms.GroupBox groupBox3;
		private System.Windows.Forms.GroupBox groupBox6;
		private System.Windows.Forms.CheckedListBox chkTemplates;
		private System.Windows.Forms.DataGrid grdExtSettings;
		private System.Windows.Forms.DataGridTableStyle dataGridTableStyle1;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn1;
		private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn2;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		[STAThread]
		static void Main() 
		{
			//			Application.Run(new frmBuildCode());
			Application.Run(new frmBuildProject());
		}
		public frmBuildProject()
		{
			InitializeComponent();
			cbxDatabases.DataSource = BuildKeyArrayList();
			cbxDatabases.ValueMember = "DbKey";
			cbxDatabases.DisplayMember = "DbKey";
			try
			{
				GetString();
				GetTemplates();
				GetExtSettings();
			}
			catch(Exception ex)
			{
			}
			/*			btnShowTables_Click(this,new EventArgs());
			if(lstAllTables.Items.Count>0)
			{
				lstAllTables.SelectedIndex=7;
				cmdSel_Click(this, new EventArgs());
			}
*/		}

		private void GetTemplates()
		{
			chkTemplates.Items.Clear();
			for(int i=0;i<((NameValueCollection)ConfigurationSettings.GetConfig("appTemplates")).Keys.Count;i++)
			{
				Template t = new Template();
				t.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appTemplates")).GetKey(i);
				string[] vals=((NameValueCollection)ConfigurationSettings.GetConfig("appTemplates")).Get(i).Split(';');
				foreach(string val in vals)
				{
					string[] pro = val.Split('=');
					if(pro[0].ToString().Trim()=="FilePath")
						t.FilePath= Application.StartupPath + "\\" + pro[1].ToString();
					if(pro[0].ToString().Trim()=="OutputSubFolder")
						t.OutputSubFolder=pro[1].ToString();
					if(pro[0].ToString().Trim()=="OutputExt")
						t.OutputExt=pro[1].ToString();
					if(pro[0].ToString().Trim()=="GroupFile")
						if(pro[1].ToString().ToLower()=="true")
							t.GroupFile=true;
						else
							t.GroupFile=false;
					t.Selected=true;
					if(pro[0].ToString().Trim()=="Selected")
						if(pro[1].ToString().ToLower()=="true")
							t.Selected=true;
						else
							t.Selected=false;
				}
				chkTemplates.Items.Add(t,t.Selected);
			}
		}

		private void GetExtSettings()
		{
			DataTable dt = new DataTable("ExtSettings");
			dt.Columns.Add("Name");
			dt.Columns.Add("Value");

			DataRow row;

			for(int i=0;i<((NameValueCollection)ConfigurationSettings.GetConfig("extSettings")).Keys.Count;i++)
			{
				row=dt.NewRow();
				row["Name"] = ((NameValueCollection)ConfigurationSettings.GetConfig("extSettings")).GetKey(i);
				row["Value"]=((NameValueCollection)ConfigurationSettings.GetConfig("extSettings")).Get(i);
				dt.Rows.Add(row);
			}

			grdExtSettings.DataSource=dt;
			
		}

		private void GetString()
		{
			lblOutputFolder.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appStrings"))["OutputFolder"];
			//			txtProjectName.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appStrings"))["ProjectName"];
			//			txtPackage.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appStrings"))["Package"];
			//			txtDataAccessBaseClass.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appStrings"))["DataAccessBase"];
			//			txtFormBaseClass.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appStrings"))["FormBase"];
			//			txtControlBaseClass.Text=((NameValueCollection)ConfigurationSettings.GetConfig("appStrings"))["ControlBase"];
		}
		
		private void SaveConfig()
		{
			AMS.Profile.Config conf = new AMS.Profile.Config();
			conf.GroupName="";
			//SaveString();
			conf.SetValue("appStrings","OutputFolder",lblOutputFolder.Text);

			//Save extention settings

			DataTable dt = (DataTable)grdExtSettings.DataSource;

			for(int i=0;i<dt.Rows.Count;i++)
			{
				try{
					conf.SetValue("extSettings",(string)dt.Rows[i]["Name"],(string)dt.Rows[i]["Value"]);
				}
				catch(Exception ex)
				{}
			}
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.groupBox2 = new System.Windows.Forms.GroupBox();
			this.btnOutputCode = new System.Windows.Forms.Button();
			this.lblOutputFolder = new System.Windows.Forms.Label();
			this.btnSelectOutputFolder = new System.Windows.Forms.Button();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.cmdDeSel = new System.Windows.Forms.Button();
			this.cmdDeSelAll = new System.Windows.Forms.Button();
			this.cmdSelAll = new System.Windows.Forms.Button();
			this.cmdSel = new System.Windows.Forms.Button();
			this.lstTables = new System.Windows.Forms.ListBox();
			this.lstAllTables = new System.Windows.Forms.ListBox();
			this.optOracle = new System.Windows.Forms.RadioButton();
			this.optSQL = new System.Windows.Forms.RadioButton();
			this.btnShowTables = new System.Windows.Forms.Button();
			this.cbxDatabases = new System.Windows.Forms.ComboBox();
			this.folderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
			this.groupBox3 = new System.Windows.Forms.GroupBox();
			this.chkTemplates = new System.Windows.Forms.CheckedListBox();
			this.groupBox6 = new System.Windows.Forms.GroupBox();
			this.grdExtSettings = new System.Windows.Forms.DataGrid();
			this.dataGridTableStyle1 = new System.Windows.Forms.DataGridTableStyle();
			this.dataGridTextBoxColumn1 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.dataGridTextBoxColumn2 = new System.Windows.Forms.DataGridTextBoxColumn();
			this.groupBox2.SuspendLayout();
			this.groupBox1.SuspendLayout();
			this.groupBox3.SuspendLayout();
			this.groupBox6.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.grdExtSettings)).BeginInit();
			this.SuspendLayout();
			// 
			// groupBox2
			// 
			this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox2.Controls.Add(this.btnOutputCode);
			this.groupBox2.Controls.Add(this.lblOutputFolder);
			this.groupBox2.Controls.Add(this.btnSelectOutputFolder);
			this.groupBox2.Location = new System.Drawing.Point(8, 472);
			this.groupBox2.Name = "groupBox2";
			this.groupBox2.Size = new System.Drawing.Size(712, 56);
			this.groupBox2.TabIndex = 7;
			this.groupBox2.TabStop = false;
			this.groupBox2.Text = "Put to File";
			// 
			// btnOutputCode
			// 
			this.btnOutputCode.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.btnOutputCode.Location = new System.Drawing.Point(614, 22);
			this.btnOutputCode.Name = "btnOutputCode";
			this.btnOutputCode.Size = new System.Drawing.Size(88, 24);
			this.btnOutputCode.TabIndex = 11;
			this.btnOutputCode.Text = "Output Code";
			this.btnOutputCode.Click += new System.EventHandler(this.btnOutputCode_Click);
			// 
			// lblOutputFolder
			// 
			this.lblOutputFolder.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.lblOutputFolder.BackColor = System.Drawing.SystemColors.ControlLight;
			this.lblOutputFolder.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.lblOutputFolder.Location = new System.Drawing.Point(148, 22);
			this.lblOutputFolder.Name = "lblOutputFolder";
			this.lblOutputFolder.Size = new System.Drawing.Size(456, 24);
			this.lblOutputFolder.TabIndex = 2;
			this.lblOutputFolder.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// btnSelectOutputFolder
			// 
			this.btnSelectOutputFolder.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left)));
			this.btnSelectOutputFolder.Location = new System.Drawing.Point(8, 22);
			this.btnSelectOutputFolder.Name = "btnSelectOutputFolder";
			this.btnSelectOutputFolder.Size = new System.Drawing.Size(128, 24);
			this.btnSelectOutputFolder.TabIndex = 1;
			this.btnSelectOutputFolder.Text = "Select Output Folder";
			this.btnSelectOutputFolder.Click += new System.EventHandler(this.btnSelectOutputFolder_Click);
			// 
			// groupBox1
			// 
			this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox1.Controls.Add(this.cmdDeSel);
			this.groupBox1.Controls.Add(this.cmdDeSelAll);
			this.groupBox1.Controls.Add(this.cmdSelAll);
			this.groupBox1.Controls.Add(this.cmdSel);
			this.groupBox1.Controls.Add(this.lstTables);
			this.groupBox1.Controls.Add(this.lstAllTables);
			this.groupBox1.Controls.Add(this.optOracle);
			this.groupBox1.Controls.Add(this.optSQL);
			this.groupBox1.Controls.Add(this.btnShowTables);
			this.groupBox1.Controls.Add(this.cbxDatabases);
			this.groupBox1.Location = new System.Drawing.Point(8, 8);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(448, 296);
			this.groupBox1.TabIndex = 8;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = "Source";
			// 
			// cmdDeSel
			// 
			this.cmdDeSel.Location = new System.Drawing.Point(208, 216);
			this.cmdDeSel.Name = "cmdDeSel";
			this.cmdDeSel.Size = new System.Drawing.Size(32, 32);
			this.cmdDeSel.TabIndex = 31;
			this.cmdDeSel.Text = "<";
			this.cmdDeSel.Click += new System.EventHandler(this.cmdDeSel_Click);
			// 
			// cmdDeSelAll
			// 
			this.cmdDeSelAll.Location = new System.Drawing.Point(208, 176);
			this.cmdDeSelAll.Name = "cmdDeSelAll";
			this.cmdDeSelAll.Size = new System.Drawing.Size(32, 32);
			this.cmdDeSelAll.TabIndex = 30;
			this.cmdDeSelAll.Text = "<<";
			this.cmdDeSelAll.Click += new System.EventHandler(this.cmdDeSelAll_Click);
			// 
			// cmdSelAll
			// 
			this.cmdSelAll.Location = new System.Drawing.Point(208, 136);
			this.cmdSelAll.Name = "cmdSelAll";
			this.cmdSelAll.Size = new System.Drawing.Size(32, 32);
			this.cmdSelAll.TabIndex = 29;
			this.cmdSelAll.Text = ">>";
			this.cmdSelAll.Click += new System.EventHandler(this.cmdSelAll_Click);
			// 
			// cmdSel
			// 
			this.cmdSel.Location = new System.Drawing.Point(208, 96);
			this.cmdSel.Name = "cmdSel";
			this.cmdSel.Size = new System.Drawing.Size(32, 32);
			this.cmdSel.TabIndex = 28;
			this.cmdSel.Text = ">";
			this.cmdSel.Click += new System.EventHandler(this.cmdSel_Click);
			// 
			// lstTables
			// 
			this.lstTables.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.lstTables.Location = new System.Drawing.Point(256, 48);
			this.lstTables.Name = "lstTables";
			this.lstTables.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lstTables.Size = new System.Drawing.Size(184, 238);
			this.lstTables.Sorted = true;
			this.lstTables.TabIndex = 27;
			this.lstTables.DoubleClick += new System.EventHandler(this.lstTables_DoubleClickChanged);
			// 
			// lstAllTables
			// 
			this.lstAllTables.Location = new System.Drawing.Point(8, 48);
			this.lstAllTables.Name = "lstAllTables";
			this.lstAllTables.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lstAllTables.Size = new System.Drawing.Size(184, 238);
			this.lstAllTables.Sorted = true;
			this.lstAllTables.TabIndex = 26;
			this.lstAllTables.DoubleClick += new System.EventHandler(this.lstAllTables_DoubleClickChanged);
			// 
			// optOracle
			// 
			this.optOracle.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left)));
			this.optOracle.Location = new System.Drawing.Point(104, 19);
			this.optOracle.Name = "optOracle";
			this.optOracle.Size = new System.Drawing.Size(88, 13);
			this.optOracle.TabIndex = 25;
			this.optOracle.Text = "Oracle";
			// 
			// optSQL
			// 
			this.optSQL.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left)));
			this.optSQL.Checked = true;
			this.optSQL.Location = new System.Drawing.Point(16, 19);
			this.optSQL.Name = "optSQL";
			this.optSQL.Size = new System.Drawing.Size(88, 13);
			this.optSQL.TabIndex = 24;
			this.optSQL.TabStop = true;
			this.optSQL.Text = "SQL Server";
			// 
			// btnShowTables
			// 
			this.btnShowTables.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left)));
			this.btnShowTables.Location = new System.Drawing.Point(328, 16);
			this.btnShowTables.Name = "btnShowTables";
			this.btnShowTables.Size = new System.Drawing.Size(88, 21);
			this.btnShowTables.TabIndex = 5;
			this.btnShowTables.Text = "Show Tables";
			this.btnShowTables.Click += new System.EventHandler(this.btnShowTables_Click);
			// 
			// cbxDatabases
			// 
			this.cbxDatabases.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left)));
			this.cbxDatabases.Location = new System.Drawing.Point(200, 16);
			this.cbxDatabases.Name = "cbxDatabases";
			this.cbxDatabases.Size = new System.Drawing.Size(120, 21);
			this.cbxDatabases.TabIndex = 4;
			// 
			// groupBox3
			// 
			this.groupBox3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox3.Controls.Add(this.chkTemplates);
			this.groupBox3.Location = new System.Drawing.Point(464, 8);
			this.groupBox3.Name = "groupBox3";
			this.groupBox3.Size = new System.Drawing.Size(256, 296);
			this.groupBox3.TabIndex = 33;
			this.groupBox3.TabStop = false;
			this.groupBox3.Text = "Code to build";
			// 
			// chkTemplates
			// 
			this.chkTemplates.Location = new System.Drawing.Point(3, 16);
			this.chkTemplates.Name = "chkTemplates";
			this.chkTemplates.Size = new System.Drawing.Size(250, 274);
			this.chkTemplates.TabIndex = 0;
			// 
			// groupBox6
			// 
			this.groupBox6.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
			this.groupBox6.Controls.Add(this.grdExtSettings);
			this.groupBox6.Location = new System.Drawing.Point(8, 312);
			this.groupBox6.Name = "groupBox6";
			this.groupBox6.Size = new System.Drawing.Size(712, 152);
			this.groupBox6.TabIndex = 34;
			this.groupBox6.TabStop = false;
			this.groupBox6.Text = "Parameters";
			// 
			// grdExtSettings
			// 
			this.grdExtSettings.AllowDrop = true;
			this.grdExtSettings.CaptionVisible = false;
			this.grdExtSettings.DataMember = "";
			this.grdExtSettings.HeaderForeColor = System.Drawing.SystemColors.ControlText;
			this.grdExtSettings.Location = new System.Drawing.Point(8, 16);
			this.grdExtSettings.Name = "grdExtSettings";
			this.grdExtSettings.Size = new System.Drawing.Size(696, 128);
			this.grdExtSettings.TabIndex = 0;
			this.grdExtSettings.TableStyles.AddRange(new System.Windows.Forms.DataGridTableStyle[] {
																									   this.dataGridTableStyle1});
			// 
			// dataGridTableStyle1
			// 
			this.dataGridTableStyle1.DataGrid = this.grdExtSettings;
			this.dataGridTableStyle1.GridColumnStyles.AddRange(new System.Windows.Forms.DataGridColumnStyle[] {
																												  this.dataGridTextBoxColumn1,
																												  this.dataGridTextBoxColumn2});
			this.dataGridTableStyle1.HeaderForeColor = System.Drawing.SystemColors.ControlText;
			this.dataGridTableStyle1.MappingName = "ExtSettings";
			// 
			// dataGridTextBoxColumn1
			// 
			this.dataGridTextBoxColumn1.Format = "";
			this.dataGridTextBoxColumn1.FormatInfo = null;
			this.dataGridTextBoxColumn1.MappingName = "Name";
			this.dataGridTextBoxColumn1.Width = 200;
			// 
			// dataGridTextBoxColumn2
			// 
			this.dataGridTextBoxColumn2.Format = "";
			this.dataGridTextBoxColumn2.FormatInfo = null;
			this.dataGridTextBoxColumn2.MappingName = "Value";
			this.dataGridTextBoxColumn2.Width = 430;
			// 
			// frmBuildProject
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(728, 536);
			this.Controls.Add(this.groupBox6);
			this.Controls.Add(this.groupBox3);
			this.Controls.Add(this.groupBox1);
			this.Controls.Add(this.groupBox2);
			this.MaximizeBox = false;
			this.Name = "frmBuildProject";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "BuildProject";
			this.groupBox2.ResumeLayout(false);
			this.groupBox1.ResumeLayout(false);
			this.groupBox3.ResumeLayout(false);
			this.groupBox6.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.grdExtSettings)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion
		private void btnShowTables_Click(object sender, System.EventArgs e) 
		{
			try 
			{
				this.Cursor = Cursors.WaitCursor;

				if (this.optSQL.Checked) 
				{
					typeOfDb = TypeOfDatabase.SQL;
				}
				else
				{
					typeOfDb = TypeOfDatabase.Oralce;
				}	

				lstAllTables.Items.Clear();
				lstTables.Items.Clear();

				ArrayList arr=TableDAO.GetTables(GetConnectionString(cbxDatabases.SelectedValue.ToString()),typeOfDb);
				for(int i=0;i<arr.Count;i++)
				{
					lstAllTables.Items.Add(((Table)arr[i]).TableName);
				}

				this.Cursor = Cursors.Arrow;
			}
			catch (Exception ex) 
			{
				MessageBox.Show("Khong ket noi duoc toi Database, hay kiem tra lai file Config !" + ex.ToString());
			}
		}

		private void btnSelectOutputFolder_Click(object sender, System.EventArgs e) 
		{
			this.folderBrowserDialog1.Description = "Select the folder that you want to write output to.";
			this.folderBrowserDialog1.ShowNewFolderButton = true;
			this.folderBrowserDialog1.RootFolder = Environment.SpecialFolder.Desktop;
			DialogResult result = folderBrowserDialog1.ShowDialog();
			if (result == DialogResult.OK) 
			{
				folderName = folderBrowserDialog1.SelectedPath;
				lblOutputFolder.Text = folderName;
			}
		}
		private string GetConnectionString(string key) 
		{
			string connStr = string.Empty;
			try 
			{
				connStr = ConfigurationSettings.AppSettings[key];
				//Encrypter encrypter = new Encrypter(Encrypter.Algorithm.Rijndael);
				//connStr = encrypter.Decrypt(connStr, "coDe%prOjeCt");
			}
			catch (Exception ex) 
			{
				MessageBox.Show(ex.ToString());
			}
			return connStr;
		}

		private ArrayList BuildKeyArrayList() 
		{
			NameValueCollection appSettings = ConfigurationSettings.AppSettings;
			
			IEnumerator appSettingsEnum = appSettings.Keys.GetEnumerator();
			int r = 0;
			while (appSettingsEnum.MoveNext()) 
			{
				string key = appSettings.Keys[r];
				DbKeys.Add(new DataBase(r, appSettings.Keys[r], appSettings.GetValues(r)[0]));
				r++;
			}
			return DbKeys;
		}

		private void cmdSel_Click(object sender, System.EventArgs e)
		{			
			if(lstAllTables.SelectedItems.Count>0)
			{
				while(lstAllTables.SelectedItems.Count>0)
				{
					lstTables.Items.Add(lstAllTables.SelectedItems[0]);
					lstAllTables.Items.Remove(lstAllTables.SelectedItems[0]);
				}
			}
		}

		private void cmdDeSel_Click(object sender, System.EventArgs e)
		{
			if(lstTables.SelectedItems.Count>0)
			{
				while(lstTables.SelectedItems.Count>0)
				{
					lstAllTables.Items.Add(lstTables.SelectedItems[0]);
					lstTables.Items.Remove(lstTables.SelectedItems[0]);
				}
			}
		}

		private void cmdSelAll_Click(object sender, System.EventArgs e)
		{
			for(int i=0;i<lstAllTables.Items.Count;i++)
			{
				lstTables.Items.Add(lstAllTables.Items[i]);
			}
			lstAllTables.Items.Clear();
		}

		private void cmdDeSelAll_Click(object sender, System.EventArgs e)
		{
			for(int i=0;i<lstTables.Items.Count;i++)
			{
				lstAllTables.Items.Add(lstTables.Items[i]);
			}
			lstTables.Items.Clear();
		}

		private void btnOutputCode_Click(object sender, System.EventArgs e)
		{
			try
			{
				SaveConfig();

			}
			catch(Exception ex)
			{
			}

			if(this.lblOutputFolder.Text.Equals(string.Empty))
			{
				MessageBox.Show("Chọn thư mục đã, ngu vừa thôi !");
				return ;
			}			
			if(lstTables.Items.Count>0)
			{
				ArrayList al = new ArrayList();
				for(int iT=0;iT<lstTables.Items.Count;iT++)
				{
					tableName=(string)lstTables.Items[iT];
					tableSchema = TableDAO.GetTableSchema(GetConnectionString(cbxDatabases.SelectedValue.ToString()), tableName,typeOfDb);
					Table table = new Table();
					table.TableName=tableName;
					table.TableSchema = tableSchema;
					al = ColumnDAO.GetColumns(GetConnectionString(cbxDatabases.SelectedValue.ToString()), tableName, tableSchema,typeOfDb);

					if(al.Count>0)
					{
						ArrayList extSettings = new ArrayList();
						DataTable dt = (DataTable)grdExtSettings.DataSource;
						for(int i=0;i<dt.Rows.Count;i++)
						{
							ExtSetting et = new ExtSetting();
							et.Name=dt.Rows[i]["Name"].ToString();
							et.Value=dt.Rows[i]["Value"].ToString();
							extSettings.Add(et);
						}
						
						foreach(Template t in chkTemplates.CheckedItems)
						{
							string sFolder;
							if(t.GroupFile)
								sFolder = System.IO.Path.Combine(this.lblOutputFolder.Text, t.OutputSubFolder + "\\" + table.TableName );
							else
								sFolder = System.IO.Path.Combine(this.lblOutputFolder.Text, t.OutputSubFolder);
							Directory.CreateDirectory(sFolder);
							XMLHelper.GenCode(table, al, extSettings, t.FilePath,System.IO.Path.Combine(sFolder, table.TableName + t.OutputExt ));
						}
					}
				}
				MessageBox.Show("Xong rồi!");
			}
			else
			{
				MessageBox.Show("Chọn bảng đi!");
			}

		}

		private void lstAllTables_DoubleClickChanged(object sender, System.EventArgs e)
		{
			cmdSel_Click(sender,e);
		}
		private void lstTables_DoubleClickChanged(object sender, System.EventArgs e)
		{
			cmdDeSel_Click(sender,e);
		}

		//		private void cmdAddRow_Click(object sender, System.EventArgs e)
		//		{
		//			((ArrayList)this.grdExtSettings.DataSource).Add(
		//		}
		//
		//		private void cmdDelRow_Click(object sender, System.EventArgs e)
		//		{
		//		
		//		}


	}


}

