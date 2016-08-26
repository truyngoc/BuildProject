<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">

Imports CIS.Common
Imports CIS.ClassInfo
Partial Public Class <xsl:value-of select="entity/@tableName"/>_Popup
    Inherits CIS.Common.UserWebpart
    Public Event Saved(ByVal sender As Object, ByVal e As EventArgs)
    Public Event Canceled(ByVal sender As Object, ByVal e As EventArgs)

    Public Sub BindData(Optional ByVal info As <xsl:value-of select="entity/@tableName"/>_Info = Nothing, Optional ByVal Action As Constant.FormActions = Constant.FormActions.Insert)
        hidAction.Value = Action
        Select Case Action
            Case Constant.FormActions.Insert
                lblDanhMuc.Text = Constant.FormCaption.FORM_CAPTION_DANHM_MUC_ADD
				<xsl:apply-templates select="entity/columns" mode="Insert"/>

            Case Constant.FormActions.Update
                lblDanhMuc.Text = Constant.FormCaption.FORM_CAPTION_DANHM_MUC_EDIT
				<xsl:apply-templates select="entity/columns" mode="Edit"/>

            Case Else
                Throw New ApplicationException(String.Format("Không tồn tại mã thao tác {0}", Action))
        End Select
    End Sub

    Private Function GetClassInfo() As <xsl:value-of select="entity/@tableName"/>_Info
        Dim info As New <xsl:value-of select="entity/@tableName"/>_Info
		<xsl:apply-templates select="entity/columns" mode="GetClassInfo"/>
		Return info
    End Function

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        ''Goi service
        Dim service As New CISBzService.WebService_CIS_Process
        Dim req As New CISBzService.ComRequest
        Dim resp As New CISBzService.ComResponse

        Try
            Dim info As New <xsl:value-of select="entity/@tableName"/>_Info
            ''Get data from Control
            info = GetClassInfo()

            ''Set Action
            Select Case hidAction.Value
                Case Constant.FormActions.Update
                    req.type = Constant.FormActions.Update
                Case Constant.FormActions.Insert
                    req.type = Constant.FormActions.Insert
                Case Else
                    Throw New Exception(String.Format(Constant.FormErrorMessage.FORM_ERROR_NOT_EXITS_ACTION, hidAction.Value))
            End Select

            ''Set group
            req.groupType = Constant.DanhMuc.<xsl:value-of select="entity/@tableName"/>
            ''Set parameter
            req.parameter = CompressionHelper.EncodeString(info.ToXML)

            ''Call service
            resp = service.Process(req)

            ''Success
            If resp.returnCode > 0 Then
                RaiseEvent Saved(sender, e)
            Else
                Throw New Exception(CompressionHelper.DecodeString(resp.returnExt))
            End If

        Catch ex As Exception
            Me.SetError(ex)
        Finally
            service.Dispose()
            req = Nothing
            resp = Nothing
        End Try
        
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click
        RaiseEvent Canceled(sender, e)
    End Sub

End Class

</xsl:template>

<xsl:template match="entity/columns" mode="GetClassInfo">
	<xsl:for-each select="property">
		info.<xsl:value-of select="@columnName"/>=txt<xsl:value-of select="@columnName"/>.Text
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="Edit">
	<xsl:for-each select="property[@isPK='False']">
		txt<xsl:value-of select="@columnName"/>.Text=info.<xsl:value-of select="@columnName"/>
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='True']">
		txt<xsl:value-of select="@columnName"/>.Text=info.<xsl:value-of select="@columnName"/>
		lbl<xsl:value-of select="@columnName"/>.Text=info.<xsl:value-of select="@columnName"/>
		txt<xsl:value-of select="@columnName"/>.Visible = False
		lbl<xsl:value-of select="@columnName"/>.Visible = True
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="Insert">
	<xsl:for-each select="property[@isPK='False']">
		txt<xsl:value-of select="@columnName"/>.Text=""
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='True']">
		txt<xsl:value-of select="@columnName"/>.Text=""
		txt<xsl:value-of select="@columnName"/>.Visible = True
		lbl<xsl:value-of select="@columnName"/>.Visible = False
	</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
