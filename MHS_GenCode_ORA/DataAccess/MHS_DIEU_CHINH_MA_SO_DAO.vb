
'' =============================================
'' Create date:	12/11/2012 12:50
'' Description:	The methods working with database of  MHS_DIEU_CHINH_MA_SO object
'' Revise History:
'' =============================================

Imports Utils
Imports Common
Imports Oracle.DataAccess.Client

Public Class MHS_MHS_DIEU_CHINH_MA_SO_DAO
    Inherits MHS_DataAccessNghiepVuBase
#Region "Insert"	
    Public Sub InsertItem( ByVal info As MHS_DIEU_CHINH_MA_SO_Info)
		Try
			
			OracleHelper.ExecuteNonQuery(Me.Connection, CommandType.StoredProcedure _
										, "PKG_MHS_DIEU_CHINH_MA_SO.MHS_DIEU_CHINH_MA_SO_Insert" _
										, SqlHelper.CreateParameter("@M_ID", SqlDbType.NUMBER,info.M_ID) _
					, SqlHelper.CreateParameter("@SO_TK", SqlDbType.NUMBER,info.SO_TK) _
					, SqlHelper.CreateParameter("@MA_LH", SqlDbType.VARCHAR2,info.MA_LH) _
					, SqlHelper.CreateParameter("@MA_HQ", SqlDbType.VARCHAR2,info.MA_HQ) _
					, SqlHelper.CreateParameter("@NAM_DK", SqlDbType.NUMBER,info.NAM_DK) _
					, SqlHelper.CreateParameter("@ID_HANG", SqlDbType.NUMBER,info.ID_HANG) _
					, SqlHelper.CreateParameter("@NGAY_DK", SqlDbType.DATE,info.NGAY_DK) _
					, SqlHelper.CreateParameter("@C_ID", SqlDbType.VARCHAR2,IIf(info.C_ID Is Nothing, DBNull.Value, info.C_ID)) _
					)
			
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Sub
#End Region

#Region "Select"
    Public Function SelectItems( ByVal M_ID as Nullable(Of integer) _
				, ByVal SO_TK as Nullable(Of integer) _
				, ByVal MA_LH as string _
				, ByVal MA_HQ as string _
				, ByVal NAM_DK as Nullable(Of integer) _
				, ByVal ID_HANG as Nullable(Of integer) _
				, ByVal NGAY_DK_FROM as Nullable(Of date) _
					, ByVal NGAY_DK_TO as Nullable(Of date) _
				, ByVal C_ID as string _
				) As DataSet
		Try
			Return OracleHelper.ExecuteDataSet(Me.Connection, CommandType.StoredProcedure _
					, "PKG_MHS_DIEU_CHINH_MA_SO.MHS_DIEU_CHINH_MA_SO_Search" _
					 , SqlHelper.CreateParameter("@M_ID", SqlDbType.NUMBER, IIf(M_ID Is Nothing, DBNull.Value, M_ID)) _
				, SqlHelper.CreateParameter("@SO_TK", SqlDbType.NUMBER, IIf(SO_TK Is Nothing, DBNull.Value, SO_TK)) _
				, SqlHelper.CreateParameter("@MA_LH", SqlDbType.VARCHAR2, IIf(String.IsNullOrEmpty(MA_LH), DBNull.Value, MA_LH)) _
				, SqlHelper.CreateParameter("@MA_HQ", SqlDbType.VARCHAR2, IIf(String.IsNullOrEmpty(MA_HQ), DBNull.Value, MA_HQ)) _
				, SqlHelper.CreateParameter("@NAM_DK", SqlDbType.NUMBER, IIf(NAM_DK Is Nothing, DBNull.Value, NAM_DK)) _
				, SqlHelper.CreateParameter("@ID_HANG", SqlDbType.NUMBER, IIf(ID_HANG Is Nothing, DBNull.Value, ID_HANG)) _
				, SqlHelper.CreateParameter("@NGAY_DK_FROM", SqlDbType.DATE, IIf(NGAY_DK_FROM Is Nothing, DBNull.Value, NGAY_DK_FROM)) _
					, SqlHelper.CreateParameter("@NGAY_DK_TO", SqlDbType.DATE, IIf(NGAY_DK_TO Is Nothing, DBNull.Value, NGAY_DK_TO)) _
				, SqlHelper.CreateParameter("@C_ID", SqlDbType.VARCHAR2, IIf(String.IsNullOrEmpty(C_ID), DBNull.Value, C_ID)) _
				)
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Function
#End Region

#Region "Delete"	
    Public Sub DeleteItems( ByVal M_ID as Nullable(Of integer) _
				)
		Try
			OracleHelper.ExecuteNonQuery(Me.Connection, CommandType.StoredProcedure _
					, "PKG_MHS_DIEU_CHINH_MA_SO.MHS_DIEU_CHINH_MA_SO_Delete" _
					 , SqlHelper.CreateParameter("@M_ID", SqlDbType.NUMBER,IIf(M_ID Is Nothing, DBNull.Value, M_ID)) _
		)
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Sub	
#End Region	

#Region "Update"
	Public Sub UpdateItem( ByVal info As MHS_DIEU_CHINH_MA_SO_Info)
		Try
			OracleHelper.ExecuteNonQuery(Me.Connection, CommandType.StoredProcedure _
									, "PKG_MHS_DIEU_CHINH_MA_SO.MHS_DIEU_CHINH_MA_SO_Update" _
									, SqlHelper.CreateParameter("@M_ID", SqlDbType.NUMBER, info.M_ID) _
				, SqlHelper.CreateParameter("@SO_TK", SqlDbType.NUMBER, info.SO_TK) _
				, SqlHelper.CreateParameter("@MA_LH", SqlDbType.VARCHAR2, info.MA_LH) _
				, SqlHelper.CreateParameter("@MA_HQ", SqlDbType.VARCHAR2, info.MA_HQ) _
				, SqlHelper.CreateParameter("@NAM_DK", SqlDbType.NUMBER, info.NAM_DK) _
				, SqlHelper.CreateParameter("@ID_HANG", SqlDbType.NUMBER, info.ID_HANG) _
				, SqlHelper.CreateParameter("@NGAY_DK", SqlDbType.DATE, info.NGAY_DK) _
				, SqlHelper.CreateParameter("@C_ID", SqlDbType.VARCHAR2,IIf(String.IsNullOrEmpty(info.C_ID), DBNull.Value, info.C_ID)) _
				)
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Sub
#End Region	
	
End Class

