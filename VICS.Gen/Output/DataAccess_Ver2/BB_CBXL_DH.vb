
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports VICS.Object
Imports VICS.Common

Public Class BB_CBXL_DH
	Inherits DataAccessBase
	  Public Sub InsertItem(ByVal obj As BB_CBXL_Obj)
      Using dbCommand As DbCommand = defaultDB.GetStoredProcCommand("PKG_BB_CBXL.bb_cbxl_insert")
        ' add parameter
        defaultDB.AddInParameter(dbCommand,"p_ID", DbType.Int32, GetDBNull(obj.ID))
		defaultDB.AddInParameter(dbCommand,"p_BIENBAN_ID", DbType.Int32, GetDBNull(obj.BIENBAN_ID))
		defaultDB.AddInParameter(dbCommand,"p_HOTEN", DbType.String, GetDBNull(obj.HOTEN))
		defaultDB.AddInParameter(dbCommand,"p_CHUCVU", DbType.String, GetDBNull(obj.CHUCVU))
		defaultDB.AddInParameter(dbCommand,"p_MADONVI", DbType.String, GetDBNull(obj.MADONVI))
		defaultDB.AddInParameter(dbCommand,"p_TENDONVI", DbType.String, GetDBNull(obj.TENDONVI))
		defaultDB.AddInParameter(dbCommand,"p_LOAI", DbType.Int32, GetDBNull(obj.LOAI))
		
        ' execute
        defaultDB.ExecuteNonQuery(dbCommand)    
      End Using        
    End Sub

    Public Sub UpdateItem(ByVal obj As BB_CBXL_Obj)
    Using dbCommand As DbCommand = defaultDB.GetStoredProcCommand("PKG_BB_CBXL.bb_cbxl_update")
        ' add parameter
        defaultDB.AddInParameter(dbCommand,"p_ID", DbType.Int32, GetDBNull(obj.ID))
    defaultDB.AddInParameter(dbCommand,"p_BIENBAN_ID", DbType.Int32, GetDBNull(obj.BIENBAN_ID))
    defaultDB.AddInParameter(dbCommand,"p_HOTEN", DbType.String, GetDBNull(obj.HOTEN))
    defaultDB.AddInParameter(dbCommand,"p_CHUCVU", DbType.String, GetDBNull(obj.CHUCVU))
    defaultDB.AddInParameter(dbCommand,"p_MADONVI", DbType.String, GetDBNull(obj.MADONVI))
    defaultDB.AddInParameter(dbCommand,"p_TENDONVI", DbType.String, GetDBNull(obj.TENDONVI))
    defaultDB.AddInParameter(dbCommand,"p_LOAI", DbType.Int32, GetDBNull(obj.LOAI))
    
        ' execute
        defaultDB.ExecuteNonQuery(dbCommand)
    End Using
    End Sub

    Public Sub DeleteItem(ByVal ID as integer)
        defaultDB.ExecuteNonQuery("PKG_BB_CBXL.bb_cbxl_delete" _
        , ID _
		)
    End Sub

    Public Function SelectItem(ByVal ID as integer) As BB_CBXL_Obj
        Return defaultDB.ExecuteSprocAccessor(Of BB_CBXL_Obj)("PKG_BB_CBXL.bb_cbxl_getItem" _
        , ID _
		, Nothing _
        ).FirstOrDefault
    End Function

    Public Function Search(ByVal obj As BB_CBXL_Obj) As IEnumerable(Of BB_CBXL_Obj)
        Return defaultDB.ExecuteSprocAccessor(Of BB_CBXL_Obj)("PKG_BB_CBXL.bb_cbxl_get" _
        , GetDBNull(obj.ID) _
  , GetDBNull(obj.BIENBAN_ID) _
  , GetDBNull(obj.HOTEN) _
  , GetDBNull(obj.CHUCVU) _
  , GetDBNull(obj.MADONVI) _
  , GetDBNull(obj.TENDONVI) _
  , GetDBNull(obj.LOAI) _
  , Nothing _
    )
    End Function

    Public Function CheckExist(ByVal ID as integer) As Boolean
        Dim sqlCommand As String = "PKG_BB_CBXL.bb_cbxl_checkExist"
        Dim ret As Object
        
        Using dbCommand As DbCommand = defaultDB.GetStoredProcCommand(sqlCommand)
          defaultDB.AddInParameter(dbCommand,"p_ID", DbType.Int32, ID)
    defaultDB.AddOutParameter(dbCommand, "reccount", DbType.Int32, 0)

          defaultDB.ExecuteNonQuery(dbCommand)

          ret = defaultDB.GetParameterValue(dbCommand, "reccount")
        End Using

        If ret > 0 Then
          Return True
        Else
          Return False
        End If
    End Function
    
End Class

