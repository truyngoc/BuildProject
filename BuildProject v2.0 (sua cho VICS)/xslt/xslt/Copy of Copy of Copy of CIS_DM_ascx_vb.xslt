<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">

Imports CIS.Common
Imports CIS.ClassInfo
Partial Public Class <xsl:value-of select="entity/@tableName"/>_List
    Inherits CIS.Common.UserWebpart
    
		<xsl:apply-templates select="entity/columns" mode="GetColumnNumber"/>

    Public Sub BindData(Optional ByVal para As String = "")
        Dim ds As New DataSet

        ''service
        Dim service As New CISBzService.WebService_CIS_Process
        Dim req As New CISBzService.ComRequest
        Dim resp As New CISBzService.ComResponse

        Try

            ''Paramater Request
            req.groupType = Constant.DanhMuc.<xsl:value-of select="entity/@tableName"/>
            req.parameter = para

            If String.IsNullOrEmpty(para) Then
                req.type = Constant.FormActions.SelectAllItem
            Else
                req.type = Constant.FormActions.Search
            End If

            ''Call service of Biztalk
            resp = service.Process(req)

            ''Success
            If resp.returnCode > 0 Then
                If Not String.IsNullOrEmpty(resp.returnExt) Then
                    ds = Common.CBO.XML2Dataset(Common.CompressionHelper.DecodeString(resp.returnExt))
                End If

                If ds Is Nothing OrElse ds.Tables(0) Is Nothing OrElse ds.Tables(0).Rows.Count = 0 Then
                    ''If ds is nothing->Show header
                    Dim list As New List(Of <xsl:value-of select="entity/@tableName"/>_Info)
                    list.Add(New <xsl:value-of select="entity/@tableName"/>_Info)
                    grdDanhMuc.DataSource = list
                    grdDanhMuc.DataBind()
                    grdDanhMuc.Rows(0).Visible = False
                Else
                    grdDanhMuc.DataSource = ds
                    grdDanhMuc.DataBind()
                End If
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

    Private Function GetClassInfo(ByVal RowIndex As Integer) As <xsl:value-of select="entity/@tableName"/>_Info
        Dim info As New <xsl:value-of select="entity/@tableName"/>_Info

<xsl:apply-templates select="entity/columns" mode="GetClassInfo"/>

        Return info
    End Function
    
    Private Function GetCondition() As <xsl:value-of select="entity/@tableName"/>_Info
        Dim info As New <xsl:value-of select="entity/@tableName"/>_Info


		<xsl:apply-templates select="entity/columns" mode="GetCondition"/>

        Return info
    End Function

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSearch.Click
        Try
        	Dim sCondition As String
            Dim info As New <xsl:value-of select="entity/@tableName"/>_Info

            info = GetCondition()
            sCondition = info.ToXML

            BindData(CompressionHelper.EncodeString(sCondition))

        Catch ex As Exception
            Me.SetError(ex)
        End Try
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnDelete.Click
        Dim service As New CISBzService.WebService_CIS_Process
        Dim req As New CISBzService.ComRequest
        Dim resp As New CISBzService.ComResponse

        Try
            Dim infoKeys As New <xsl:value-of select="entity/@tableName"/>_InfoKeys
            Dim chkItem As CheckBox

            For Each r As GridViewRow In grdDanhMuc.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    chkItem = CType(r.Cells(0).Controls(1), CheckBox)
                    If Not chkItem Is Nothing Then
                        If chkItem.Checked Then
			   				infoKeys.AddKey(New <xsl:value-of select="entity/@tableName"/>_InfoKey(grdDanhMuc.Rows(r.RowIndex).Cells(<xsl:apply-templates select="entity/columns" mode="Delete"/>)
                        End If
                    End If
                End If
            Next

            ''Check parameter
            If infoKeys Is Nothing OrElse infoKeys.Keys Is Nothing OrElse infoKeys.Keys.Count = 0 Then
                Throw New Exception(Constant.FormErrorMessage.FORM_ERROR_NOTENOUGH)
            End If

            ''Set action
            req.groupType = Constant.DanhMuc.<xsl:value-of select="entity/@tableName"/>
            req.type = Constant.FormActions.Delete
            req.parameter = CompressionHelper.EncodeString(infoKeys.ToXML)

            ''Call service
            resp = service.Process(req)

            ''Success
            If resp.returnCode > 0 Then
                ''Update Grid
                BindData()
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

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnInsert.Click
        Try
            updList.Visible = False
            updDetail.Visible = True

            popup<xsl:value-of select="entity/@tableName"/>.BindData()
        Catch ex As Exception
            Me.SetError(ex)
        End Try
    End Sub

    Private Sub Popup<xsl:value-of select="entity/@tableName"/>_Canceled(ByVal sender As Object, ByVal e As System.EventArgs) Handles popup<xsl:value-of select="entity/@tableName"/>.Canceled
        Try
            updList.Visible = True
            updDetail.Visible = False
            BindData()
        Catch ex As Exception
            Me.SetError(ex)
        End Try
    End Sub

    Private Sub Popup<xsl:value-of select="entity/@tableName"/>_Saved(ByVal sender As Object, ByVal e As System.EventArgs) Handles popup<xsl:value-of select="entity/@tableName"/>.Saved
        Try
            updList.Visible = True
            updDetail.Visible = False
            BindData()
        Catch ex As Exception
            Me.SetError(ex)
        End Try
    End Sub

    Protected Sub CheckBox_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim chkCheckAll As CheckBox
        Dim chkItem As CheckBox
        Try
            Dim chkCheck As CheckBox = CType(sender, CheckBox)
            Dim row As GridViewRow = CType(chkCheck.NamingContainer, GridViewRow)
            Select Case row.RowType
                Case DataControlRowType.Header
                    
                    For i As Integer = 0 To grdDanhMuc.Rows.Count - 1
                        chkItem = CType(grdDanhMuc.Rows(i).Cells(0).Controls(1), CheckBox)
                        chkItem.Checked = chkCheck.Checked
                    Next
                Case DataControlRowType.DataRow
                    Dim all As Boolean = False
                    chkCheckAll = CType(grdDanhMuc.HeaderRow.Cells(0).Controls(1), CheckBox)
                    For i As Integer = 0 To grdDanhMuc.Rows.Count - 1
                        chkItem = CType(grdDanhMuc.Rows(i).Cells(0).Controls(1), CheckBox)
                        If (Not chkItem.Checked) Then
                            all = False
                            Exit For
                        End If
                        all = True
                    Next
                    chkCheckAll.Checked = all
            End Select
        Catch ex As Exception
            Me.SetError(ex)
        End Try
    End Sub

    Protected Sub grdDanhMuc_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grdDanhMuc.PageIndexChanging
        grdDanhMuc.PageIndex = e.NewPageIndex
        BindData()
    End Sub

    Protected Sub grdDanhMuc_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdDanhMuc.RowCommand
        Select Case e.CommandName
            Case "Select"
                Try
                    Dim obj As New <xsl:value-of select="entity/@tableName"/>_Info
                    obj = GetClassInfo(Convert.ToInt32(e.CommandArgument))

                    ''Bind data control Edit
                    popup<xsl:value-of select="entity/@tableName"/>.BindData(obj, Constant.FormActions.Update)

                    updDetail.Visible = True
                    updList.Visible = False

                Catch ex As Exception
                    Me.SetError(ex)
                End Try
        End Select
    End Sub
End Class
</xsl:template>

<xsl:template match="entity/columns" mode="GetColumnNumber">
	<xsl:for-each select="property">
		Private Const <xsl:value-of select="@columnName"/>_Column As Int32 = 1
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="GetClassInfo">
	<xsl:for-each select="property">
		info.<xsl:value-of select="@columnName"/>=grdDanhMuc.Rows(RowIndex).Cells(<xsl:value-of select="@columnName"/>_Column).Text
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="GetCondition">
	<xsl:for-each select="property">
		info.<xsl:value-of select="@columnName"/> = txt<xsl:value-of select="@columnName"/>.Text
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="Delete">
	<xsl:for-each select="property[@isPK='True']">
		<xsl:choose>
			<xsl:when test="position()>1">, </xsl:when>
		</xsl:choose>
                <xsl:value-of select="@columnName"/>_Column).Text) _
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="Edit">
	<xsl:for-each select="property[@isPK='False']">
		txt<xsl:value-of select="@columnName"/>.Text=row.Cells(<xsl:value-of select="@columnName"/>_Column).Text
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='True']">
		txt<xsl:value-of select="@columnName"/>.Text=row.Cells(<xsl:value-of select="@columnName"/>_Column).Text
		lbl<xsl:value-of select="@columnName"/>.Text=row.Cells(<xsl:value-of select="@columnName"/>_Column).Text
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
