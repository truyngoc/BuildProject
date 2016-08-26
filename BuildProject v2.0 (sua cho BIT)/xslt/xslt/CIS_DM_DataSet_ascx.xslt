<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
	
	
	Public Class <xsl:value-of select="entity/@tableName"/>_Dataset
    Inherits DataSet

 
	<xsl:apply-templates select="entity/columns" mode="constantcolumns"/>

Sub new()
        Dim table As DataTable
        table = New DataTable("TABLE_<xsl:value-of select="entity/@tableName"/>")
        With table.Columns
            <xsl:apply-templates select="entity/columns" mode="tablecolumns"/>
        End With
        Me.Tables.Add(table)
    End Sub

End Class
</xsl:template>


<!--danh sach cac cot-->
<xsl:template match="entity/columns" mode="constantcolumns">
	<xsl:for-each select="property">
		Public Const COLUMN_<xsl:value-of select="@columnName"/> As String = "<xsl:value-of select="@columnName"/>"
	</xsl:for-each>
</xsl:template>
<xsl:template match="entity/columns" mode="tablecolumns">
	<xsl:for-each select="property">
		.Add(COLUMN_<xsl:value-of select="@columnName"/>, GetType(<xsl:value-of select="@vbDataType"/>))
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
