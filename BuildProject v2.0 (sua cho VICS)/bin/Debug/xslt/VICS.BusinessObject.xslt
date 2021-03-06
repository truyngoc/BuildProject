<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
Imports VICS.DataHelper
Imports VICS.Object

Public Class <xsl:value-of select="entity/@tableName"/>_BC
	Public Sub InsertItem(ByVal objData As <xsl:value-of select="entity/@tableName"/>_Obj)
		Dim ctl As New <xsl:value-of select="entity/@tableName"/>_DH
		ctl.InsertItem(objData)
		ctl = Nothing
	End Sub

	Public Sub UpdateItem(ByVal objData As <xsl:value-of select="entity/@tableName"/>_Obj)
		Dim ctl As New <xsl:value-of select="entity/@tableName"/>_DH
		ctl.UpdateItem(objData)
		ctl = Nothing
	End Sub

	Public Sub DeleteItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)
		Dim ctl As New <xsl:value-of select="entity/@tableName"/>_DH
		ctl.DeleteItem(<xsl:apply-templates select="entity/columns" mode="DeleteValues"/>)
		ctl = Nothing
	End Sub

	Public Function SelectItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) as <xsl:value-of select="entity/@tableName"/>_Obj				
		Return (New <xsl:value-of select="entity/@tableName"/>_DH()).SelectItem(<xsl:apply-templates select="entity/columns" mode="DeleteValues"/>)
	End Function

	Public Function Search(ByVal objData As <xsl:value-of select="entity/@tableName"/>_Obj) as List(Of <xsl:value-of select="entity/@tableName"/>_Obj)	
		Return (New <xsl:value-of select="entity/@tableName"/>_DH()).Search(objData).ToList()
	End Function
	
	<xsl:apply-templates select="entity" mode="SelectBy"/>
End Class

</xsl:template>

<!--Cac function SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
    Public Function SelectItemsBy<xsl:value-of select="@columnName"/>(ByVal <xsl:value-of select="@columnName"/> As <xsl:value-of select="@vbDataType"/>) As DataSet
        Return (New <xsl:value-of select="$tablename"/>_DH).SelectItemsBy<xsl:value-of select="@columnName"/>(<xsl:value-of select="@columnName"/>)
    End Function
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho sub delete-->
<xsl:template match="entity/columns" mode="DeleteParams">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/></xsl:for-each>
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
