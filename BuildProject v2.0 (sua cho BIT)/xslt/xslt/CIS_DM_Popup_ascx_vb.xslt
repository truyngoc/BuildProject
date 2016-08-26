<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">

Imports CIS.Common
Imports CIS.ClassInfo
Partial Public Class <xsl:value-of select="entity/@tableName"/>_Detail
    Inherits CIS.Common.UserWebpart
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub cmdSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdSave.Click
        
    End Sub

    Protected Sub cmdExit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdExit.Click

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
