<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
&lt;%@ Control Language="vb" AutoEventWireup="false" Codebehind="<xsl:value-of select="entity/@tableName"/>_Edit.ascx.vb" Inherits="DotNetNuke.Modules.<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="entity/@tableName"/>_Edit" %&gt;

&lt;table cellSpacing="0" cellPadding="0" width="100%"&gt;
<xsl:apply-templates select="entity/columns" mode="Controls"/>
&lt;/table&gt;

&lt;asp:linkbutton id="cmdUpdate" runat="server" resourcekey="cmdUpdate" BorderStyle="None" CssClass="CommandButton"&gt;Update&lt;/asp:linkbutton&gt;&lt;asp:linkbutton id="cmdCancel" runat="server" resourcekey="cmdCancel" BorderStyle="None" CssClass="CommandButton"
	CausesValidation="False"&gt;Cancel&lt;/asp:linkbutton&gt;&lt;asp:linkbutton id="cmdDelete" runat="server" resourcekey="cmdDelete" BorderStyle="None" CssClass="CommandButton"
	CausesValidation="False" Visible="False"&gt;Delete&lt;/asp:linkbutton&gt;
</xsl:template>

<!--danh sach property-->
<xsl:template match="entity/columns" mode="Controls">
	<xsl:for-each select="property">
	&lt;tr&gt;
		&lt;td class="Normal" align="right"&gt;<xsl:value-of select="@columnName"/>&lt;/td&gt;
		&lt;td align="left"&gt;&lt;<xsl:choose>
										<xsl:when test="@isIdentity='True'">asp:textbox</xsl:when>
										<xsl:when test="@isFK='True'">asp:DropDownList</xsl:when>
										<xsl:when test="@dataType='date' or @dataType='datetime'">asp:textbox</xsl:when>
										<xsl:otherwise>asp:textbox</xsl:otherwise>
									</xsl:choose> id="<xsl:value-of select="@columnName"/>" runat="server"&gt;&lt;/<xsl:choose>
																														<xsl:when test="@isIdentity='True'">asp:textbox</xsl:when>
																														<xsl:when test="@isFK='True'">asp:DropDownList</xsl:when>
																														<xsl:when test="@dataType='date' or @dataType='datetime'">asp:textbox</xsl:when>
																														<xsl:otherwise>asp:textbox</xsl:otherwise>
																													</xsl:choose>&gt;&lt;/td&gt;
	&lt;/tr&gt;
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
