
Imports VICS.DataHelper
Imports VICS.Object

Public Class BB_CBXL_BC
	Public Sub InsertItem(ByVal objData As BB_CBXL_Obj)
		Dim ctl As New BB_CBXL_DH
		ctl.InsertItem(objData)
		ctl = Nothing
	End Sub

	Public Sub UpdateItem(ByVal objData As BB_CBXL_Obj)
		Dim ctl As New BB_CBXL_DH
		ctl.UpdateItem(objData)
		ctl = Nothing
	End Sub

	Public Sub DeleteItem(ByVal ID as integer)
		Dim ctl As New BB_CBXL_DH
		ctl.DeleteItem(ID)
		ctl = Nothing
	End Sub

	Public Function SelectItem(ByVal ID as integer) as BB_CBXL_Obj				
		Return (New BB_CBXL_DH()).SelectItem(ID)
	End Function

	Public Function Search(ByVal objData As BB_CBXL_Obj) as List(Of BB_CBXL_Obj)	
		Return (New BB_CBXL_DH()).Search(objData).ToList()
	End Function
	
  Public Function CheckExist(ByVal ID as integer) As Boolean
    Return (New BB_CBXL_DH()).CheckExist(ID)
  End Function
  
	
End Class

