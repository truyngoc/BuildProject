<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">

Imports CIS.Common
Imports CIS.ClassInfo
Partial Public Class <xsl:value-of select="entity/@tableName"/>_List
    Inherits CIS.Common.UserWebpart
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub cmdSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdSearch.Click

    End Sub

    Protected Sub cmdAdd_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdAdd.Click

    End Sub

    Protected Sub cmdDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdDelete.Click

    End Sub

    Protected Sub cmdExit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdExit.Click

    End Sub

    Protected Sub CheckBox_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs)

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
                    
                    udpDetail.Visible = True
                    udpList.Visible = False

                Catch ex As Exception
                    Me.SetError(ex)
                End Try
        End Select
    End Sub    
		
    Public Sub BindData(Optional ByVal para As String = "")
        
    End Sub

    Private Function GetClassInfo(ByVal RowIndex As Integer) As <xsl:value-of select="entity/@tableName"/>_Info
        Dim info As New <xsl:value-of select="entity/@tableName"/>_Info
		
        Return info
    End Function
    
    Private Function GetCondition() As <xsl:value-of select="entity/@tableName"/>_Info
        Dim info As New <xsl:value-of select="entity/@tableName"/>_Info
		
        Return info
    End Function
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
