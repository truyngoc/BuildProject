
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports VICS.Object
Imports VICS.Common

Public Class BB_CBXL_DH
	Inherits DataAccessBase
	  Public Sub InsertItem(ByVal obj As BB_CBXL_Obj)
        defaultDB.ExecuteNonQuery("PKG_BB_CBXL.bb_cbxl_insert" _
        , GetDBNull(obj.ID) _
		, GetDBNull(obj.BIENBAN_ID) _
		, GetDBNull(obj.HOTEN) _
		, GetDBNull(obj.CHUCVU) _
		, GetDBNull(obj.MADONVI) _
		, GetDBNull(obj.TENDONVI) _
		, GetDBNull(obj.LOAI) _
		)
    End Sub

    Public Sub UpdateItem(ByVal obj As BB_CBXL_Obj)
        defaultDB.ExecuteNonQuery("PKG_BB_CBXL.bb_cbxl_update" _
        , GetDBNull(obj.ID) _
		, GetDBNull(obj.BIENBAN_ID) _
		, GetDBNull(obj.HOTEN) _
		, GetDBNull(obj.CHUCVU) _
		, GetDBNull(obj.MADONVI) _
		, GetDBNull(obj.TENDONVI) _
		, GetDBNull(obj.LOAI) _
		)
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
   	
End Class

