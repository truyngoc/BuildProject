

'' =============================================
'' Create date:	12/11/2012 12:50
'' Description:	The bussiness methods of MHS_DIEU_CHINH_MA_SO object
'' Revise History:	
'' =============================================
Imports GTT
Imports GTT.Common
Imports GTT.Info
Imports GTT.DataAccess

Public Class MHS_DIEU_CHINH_MA_SO_BO
    Inherits BusinessLogicBase
    Private Sub KiemTraDieuKienSua( ByVal objData As MHS_DIEU_CHINH_MA_SO_Info)

	End Sub

	Private Sub KiemTraDieuKienHuy(ByVal M_ID as integer)

    End Sub

    Private Sub KiemTraDieuKienThemMoi( ByVal info As MHS_DIEU_CHINH_MA_SO_Info)
		
	End Sub
	
#Region "Select"
	Private Function SelectItems_MHS_DIEU_CHINH_MA_SO( ByVal M_ID as Nullable(Of integer) _
				, ByVal SO_TK as Nullable(Of integer) _
				, ByVal MA_LH as string _
				, ByVal MA_HQ as string _
				, ByVal NAM_DK as Nullable(Of integer) _
				, ByVal ID_HANG as Nullable(Of integer) _
				, ByVal NGAY_DK_FROM as Nullable(Of date) _
					, ByVal NGAY_DK_TO as Nullable(Of date) _
				, ByVal C_ID as string _
				) As List(Of MHS_DIEU_CHINH_MA_SO_Info)
		Dim kq As List(Of MHS_DIEU_CHINH_MA_SO_Info) = Nothing
    Dim ds As DataSet = Nothing
    Dim da As New MHS_DIEU_CHINH_MA_SO_DAO With {.Transaction = Transaction}
		ds = da.SelectItems(M_ID:=M_ID, SO_TK:=SO_TK, MA_LH:=MA_LH, MA_HQ:=MA_HQ, NAM_DK:=NAM_DK, ID_HANG:=ID_HANG, NGAY_DK_FROM:=NGAY_DK_FROM, NGAY_DK_TO:=NGAY_DK_TO, C_ID:=C_ID)
		If (ds IsNot Nothing AndAlso ds.Tables.Count > 0) Then kq = CBO.MapDataTableToList(Of MHS_DIEU_CHINH_MA_SO_Info)(ds.Tables(0))		
		Return kq
	End Function
	
	Private Function SelectItem_MHS_DIEU_CHINH_MA_SO( ByVal M_ID as integer _			
		) As MHS_DIEU_CHINH_MA_SO_Info
		Dim kq As MHS_DIEU_CHINH_MA_SO_Info = Nothing
		Dim lst As List(Of MHS_DIEU_CHINH_MA_SO_Info) = SelectItems_MHS_DIEU_CHINH_MA_SO(M_ID := M_ID, SO_TK:=Nothing, MA_LH:=Nothing, MA_HQ:=Nothing, NAM_DK:=Nothing, ID_HANG:=Nothing, NGAY_DK_FROM:=Nothing, NGAY_DK_TO:=Nothing, C_ID:=Nothing)
		If lst Is Nothing OrElse lst.Count = 0 Then
			kq = Nothing
		ElseIf lst.Count = 1 Then
			kq = lst(0)
		Else
			Throw New Exception("Xem lại bộ key của database (bảng MHS_DIEU_CHINH_MA_SO)")
		End If
		Return kq
	End Function
#End Region

#Region "Insert"
	Private Sub InsertItem_MHS_DIEU_CHINH_MA_SO( ByVal info As MHS_DIEU_CHINH_MA_SO_Info)
		Dim da As New MHS_DIEU_CHINH_MA_SO_DAO With {.Transaction = Transaction}
		da.InsertItem(info)
	End Sub
#End Region

#Region "Update"
	Private Sub UpdateItem_MHS_DIEU_CHINH_MA_SO( ByVal info As MHS_DIEU_CHINH_MA_SO_Info)
		Dim da As New MHS_DIEU_CHINH_MA_SO_DAO With {.Transaction = Transaction}
		da.UpdateItem(info)
	End Sub
#End Region

#Region "Delete"
	Private Sub DeleteItem_MHS_DIEU_CHINH_MA_SO( ByVal M_ID as integer _
	)
	   Dim da As New MHS_DIEU_CHINH_MA_SO_DAO With {.Transaction = Transaction}
		 da.DeleteItems(M_ID:=M_ID _
	)
	End Sub
	
	Private Sub DeleteItems_MHS_DIEU_CHINH_MA_SO( Byval infos as List(Of MHS_DIEU_CHINH_MA_SO_Info))
	    Dim da As New MHS_DIEU_CHINH_MA_SO_DAO With {.Transaction = Transaction}
	    For Each info as MHS_DIEU_CHINH_MA_SO_Info In infos
	        da.DeleteItems(M_ID:=info.M_ID _
	)
	    Next
	End Sub	
#End Region	
 
End Class

