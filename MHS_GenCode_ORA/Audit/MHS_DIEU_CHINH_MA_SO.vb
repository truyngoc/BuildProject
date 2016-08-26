
Imports GTT.Utils
Imports System.Text
Imports System.Reflection

Namespace PrepareAudit
    Friend Class MHS_DIEU_CHINH_MA_SO
    Inherits PrepareAuditBase

      'Tạo nội dung XML theo bộ key kèm theo thẻ tên bảng
      Protected Friend Shared Function XMLObject(M_ID	As integer) As String
          Dim kq As New StringBuilder()
          kq.Append("<MHS_DIEU_CHINH_MA_SO>")
            kq.Append(PrepareAuditBase.CreateXMLElement("M_ID",M_ID.ToString()))
          kq.Append("</MHS_DIEU_CHINH_MA_SO>")
          Return kq.ToString()
      End Function
		
		  'Tạo nội dung XML theo toàn bộ các trường kèm theo thẻ tên bảng
		  Protected Friend Shared Function XMLObject(ByVal M_ID As Nullable(Of integer),ByVal SO_TK As Nullable(Of integer),ByVal MA_LH As string,ByVal MA_HQ As string,ByVal NAM_DK As Nullable(Of integer),ByVal ID_HANG As Nullable(Of integer),ByVal NGAY_DK As Nullable(Of date),ByVal C_ID As string) As String
              Dim kq As New StringBuilder()
              kq.Append("<MHS_DIEU_CHINH_MA_SO>")
              If M_ID.HasValue then
		      kq.Append(PrepareAuditBase.CreateXMLElement("M_ID",M_ID.Value.ToString()))
		    Else
		      kq.Append(PrepareAuditBase.CreateXMLElement("M_ID",Nothing))
		    EndIf
	  If SO_TK.HasValue then
		      kq.Append(PrepareAuditBase.CreateXMLElement("SO_TK",SO_TK.Value.ToString()))
		    Else
		      kq.Append(PrepareAuditBase.CreateXMLElement("SO_TK",Nothing))
		    EndIf
	    kq.Append(PrepareAuditBase.CreateXMLElement("MA_LH",MA_LH))
	    kq.Append(PrepareAuditBase.CreateXMLElement("MA_HQ",MA_HQ))
	  If NAM_DK.HasValue then
		      kq.Append(PrepareAuditBase.CreateXMLElement("NAM_DK",NAM_DK.Value.ToString()))
		    Else
		      kq.Append(PrepareAuditBase.CreateXMLElement("NAM_DK",Nothing))
		    EndIf
	  If ID_HANG.HasValue then
		      kq.Append(PrepareAuditBase.CreateXMLElement("ID_HANG",ID_HANG.Value.ToString()))
		    Else
		      kq.Append(PrepareAuditBase.CreateXMLElement("ID_HANG",Nothing))
		    EndIf
	  If NGAY_DK.HasValue then
		      kq.Append(PrepareAuditBase.CreateXMLElement("NGAY_DK",NGAY_DK.Value.ToString("dd/MM/yyyy")))
		    Else
		      kq.Append(PrepareAuditBase.CreateXMLElement("NGAY_DK",Nothing))
		    EndIf
	    kq.Append(PrepareAuditBase.CreateXMLElement("C_ID",C_ID))
              kq.Append("</MHS_DIEU_CHINH_MA_SO>")
              Return kq.ToString()
      End Function        
  		
		  'Tạo nội dung XML theo bộ key
      Protected Friend Shared Function ObjectKey(M_ID	As integer) As String
          Dim kq As New StringBuilder()
          kq.Append(XMLObject(M_ID:=M_ID))
          Return kq.ToString()
      End Function        
          
		  'Tạo nội dung XML theo toàn bộ các trường với thẻ Insert
      Protected Friend Shared Function InsertObject(ByVal M_ID As Nullable(Of integer),ByVal SO_TK As Nullable(Of integer),ByVal MA_LH As string,ByVal MA_HQ As string,ByVal NAM_DK As Nullable(Of integer),ByVal ID_HANG As Nullable(Of integer),ByVal NGAY_DK As Nullable(Of date),ByVal C_ID As string) As String
          Dim kq As New StringBuilder()
          kq.Append(AuditTag.BeginInsertTag)
          kq.Append(XMLObject(M_ID:=M_ID,SO_TK:=SO_TK,MA_LH:=MA_LH,MA_HQ:=MA_HQ,NAM_DK:=NAM_DK,ID_HANG:=ID_HANG,NGAY_DK:=NGAY_DK,C_ID:=C_ID))
          kq.Append(AuditTag.EndInsertTag)
          Return kq.ToString()
      End Function        

		  'Tạo nội dung XML theo toàn bộ các trường với thẻ Update
      Protected Friend Shared Function UpdateObject(ByVal M_ID As Nullable(Of integer),ByVal SO_TK As Nullable(Of integer),ByVal MA_LH As string,ByVal MA_HQ As string,ByVal NAM_DK As Nullable(Of integer),ByVal ID_HANG As Nullable(Of integer),ByVal NGAY_DK As Nullable(Of date),ByVal C_ID As string) As String
          Dim kq As New StringBuilder()
          kq.Append(AuditTag.BeginUpdateTag)
          kq.Append(XMLObject(M_ID:=M_ID,SO_TK:=SO_TK,MA_LH:=MA_LH,MA_HQ:=MA_HQ,NAM_DK:=NAM_DK,ID_HANG:=ID_HANG,NGAY_DK:=NGAY_DK,C_ID:=C_ID))
          kq.Append(AuditTag.EndUpdateTag)
          Return kq.ToString()
      End Function    
		
		  'Tạo nội dung XML theo bộ key kèm theo thẻ với thẻ Delete
      Protected Friend Shared Function DeleteObject(M_ID	As integer) As String
          Dim kq As New StringBuilder()
          kq.Append(AuditTag.BeginDeleteTag)
          kq.Append(XMLObject(M_ID:=M_ID))
          kq.Append(AuditTag.EndDeleteTag)
          Return kq.ToString()
      End Function        		
    End Class
End Namespace

