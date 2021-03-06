﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
'' =============================================
'' This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
'' a freeware developed by bibi.
'' Template: DotNetNuke module EditForm.xslt 17/10/2006
'' Author:	<xsl:value-of select="entity/@author"/>
'' Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
'' Description:	
'' Revise History:	
'' =============================================
Option Strict On
Option Explicit On



Partial Public Class <xsl:value-of select="entity/@tableName"/>_Popup

    Protected WithEvents hidAction As Global.System.Web.UI.WebControls.HiddenField
    Protected WithEvents lblDanhMuc As Global.System.Web.UI.WebControls.Label
    Protected WithEvents btnSave As Global.System.Web.UI.WebControls.Button
    Protected WithEvents btnCancel As Global.System.Web.UI.WebControls.Button
    <xsl:apply-templates select="entity/columns" mode="ProtectedWithEvents"/>


End Class

</xsl:template>

<!--danh sach property-->
<xsl:template match="entity/columns" mode="ProtectedWithEvents">
	<xsl:for-each select="property[@isPK='True']">
		<xsl:choose>
			<xsl:when test="@dataType='date' or @dataType='datetime'">
				Protected WithEvents lbl<xsl:value-of select="@columnName"/> As Global.System.Web.UI.WebControls.Label
			</xsl:when>
			<xsl:otherwise>
				Protected WithEvents txt<xsl:value-of select="@columnName"/> As Global.System.Web.UI.WebControls.TextBox
				Protected WithEvents lbl<xsl:value-of select="@columnName"/> As Global.System.Web.UI.WebControls.Label
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='False']">
		<xsl:choose>
			<xsl:when test="@dataType='date' or @dataType='datetime'">
				Protected WithEvents lbl<xsl:value-of select="@columnName"/> As Global.System.Web.UI.WebControls.Label
			</xsl:when>
			<xsl:otherwise>
				Protected WithEvents txt<xsl:value-of select="@columnName"/> As Global.System.Web.UI.WebControls.TextBox
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
