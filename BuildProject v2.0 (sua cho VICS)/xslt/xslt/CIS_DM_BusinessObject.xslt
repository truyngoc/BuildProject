<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
'' =============================================
'' This Class is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
'' a freeware developed by bibi.
'' Template: BusinessObject.xslt 17/10/2006
'' Author:	<xsl:value-of select="entity/@author"/>
'' Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
'' Description:	
'' Revise History:	
'' =============================================

Imports CIS
Imports CIS.Common
Imports CIS.DataClass
Imports CIS.DataAccess

Public Class <xsl:value-of select="entity/@tableName"/>_BO	

    Private Sub KiemTraDieuKienSua(ByVal blCtrInformation As BLControlInformation, ByVal objData As <xsl:value-of select="entity/@tableName"/>_Info)

    End Sub

    Private Sub KiemTraDieuKienHuy(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)

    End Sub

    Private Sub KiemTraDieuKienThemMoi(ByVal blCtrInformation As BLControlInformation, ByVal objData As <xsl:value-of select="entity/@tableName"/>_Info)

    End Sub
    
	Public Sub InsertItem(ByVal blCtrInformation As BLControlInformation, ByVal objData As <xsl:value-of select="entity/@tableName"/>_Info)
		KiemTraDieuKienThemMoi(blCtrInformation,objData)
		Dim bibi As New <xsl:value-of select="entity/@tableName"/>_DAO
		bibi.InsertItem(blCtrInformation,objData)
		bibi = Nothing
	End Sub

	Public Sub UpdateItem(ByVal blCtrInformation As BLControlInformation, ByVal objData As <xsl:value-of select="entity/@tableName"/>_Info)
		KiemTraDieuKienSua(blCtrInformation,objData)
		Dim bibi As New <xsl:value-of select="entity/@tableName"/>_DAO
		bibi.UpdateItem(blCtrInformation,objData)
		bibi = Nothing
	End Sub

	Public Sub DeleteItem(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)
		KiemTraDieuKienHuy(blCtrInformation,<xsl:apply-templates select="entity/columns" mode="CallDeleteParams"/>)
		Dim bibi As New <xsl:value-of select="entity/@tableName"/>_DAO
		bibi.DeleteItem(blCtrInformation,<xsl:apply-templates select="entity/columns" mode="DeleteValues"/>)
		bibi = Nothing
	End Sub
	
	Public Sub DeleteItems(ByVal blCtrInformation As BLControlInformation, ByVal infoKeys As <xsl:value-of select="entity/@tableName"/>_InfoKeys)
            For Each key As <xsl:value-of select="entity/@tableName"/>_InfoKey In infoKeys.Keys
                KiemTraDieuKienHuy(blCtrInformation, key.Ma_HQ)
            Next

            Dim bibi As New <xsl:value-of select="entity/@tableName"/>_DAO
            bibi.DeleteItems(blCtrInformation, infoKeys)
            bibi = Nothing
        End Sub

	Public Function SelectItem(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) as <xsl:value-of select="entity/@tableName"/>_Info
		Dim bibi As New <xsl:value-of select="entity/@tableName"/>_DAO
		Dim ds As DataSet = bibi.SelectItem(blCtrInformation, <xsl:apply-templates select="entity/columns" mode="DeleteValues"/>)
        If ds.Tables(0).Rows.Count > 0 Then
            Return CBO.MapDataRowToObject(Of <xsl:value-of select="entity/@tableName"/>_Info)(ds.Tables(0).Rows(0))
        Else
            Return Nothing
        End If
	End Function

	Public Function SelectAllItems(ByVal blCtrInformation As BLControlInformation) as DataSet
		Return (New <xsl:value-of select="entity/@tableName"/>_DAO).SelectAllItems()
	End Function
	
	Public Function IsExistsItem(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As Boolean
            Return (New <xsl:value-of select="entity/@tableName"/>_DAO).IsExistsItem(blCtrInformation, <xsl:apply-templates select="entity/columns" mode="DeleteValues"/>)
    End Function
        
	<xsl:apply-templates select="entity" mode="SelectBy"/>
End Class

</xsl:template>

<!--Cac function SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
    Public Function SelectItemsBy<xsl:value-of select="@columnName"/>(ByVal blCtrInformation As BLControlInformation, ByVal <xsl:value-of select="@columnName"/> As <xsl:value-of select="@vbDataType"/>) As DataSet
        Return (New <xsl:value-of select="$tablename"/>_DAO).SelectItemsBy<xsl:value-of select="@columnName"/>(<xsl:value-of select="@columnName"/>)
    End Function
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho sub delete-->
<xsl:template match="entity/columns" mode="DeleteParams">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/></xsl:for-each>
</xsl:template>
<xsl:template match="entity/columns" mode="CallDeleteParams">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose><xsl:value-of select="@columnName"/></xsl:for-each>
</xsl:template>


<!--danh sach tham so truyen vao sub delete cua DAO-->
<xsl:template match="entity/columns" mode="DeleteValues">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose><xsl:value-of select="@columnName"/></xsl:for-each>
</xsl:template>

<!--Gan gia tri trong Sub SelectItem-->
<xsl:template match="entity/columns" mode="SelectSetValues">
	<xsl:for-each select="property">
			If not IsDBNull(row.Item("<xsl:value-of select="@columnName"/>")) Then retVal.<xsl:value-of select="@columnName"/> = row.Item("<xsl:value-of select="@columnName"/>")</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
