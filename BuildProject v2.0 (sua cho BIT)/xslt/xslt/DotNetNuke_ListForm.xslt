<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
&lt;%@ Control Language="vb" AutoEventWireup="false" Codebehind="<xsl:value-of select="entity/@tableName"/>_List.ascx.vb" Inherits="<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="entity/@tableName"/>_List" %&gt;
&lt;asp:datagrid id="grdDS" runat="server" AutoGenerateColumns="False"&gt;
	&lt;Columns&gt;
		&lt;asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel" EditText="Edit"&gt;&lt;/asp:EditCommandColumn&gt;
		&lt;asp:TemplateColumn&gt;
			&lt;ItemTemplate&gt;
				&lt;asp:LinkButton id="cmdDelete" runat="server" CommandName="Delete"&gt;Delete&lt;/asp:LinkButton&gt;
			&lt;/ItemTemplate&gt;
		&lt;/asp:TemplateColumn&gt;
		<xsl:apply-templates select="entity/columns" mode="keycolumns"/>
		<xsl:apply-templates select="entity/columns" mode="columns"/>
	&lt;/Columns&gt;
&lt;/asp:datagrid&gt;
&lt;asp:linkbutton id="cmdAddNew" runat="server" resourcekey="cmdAddNew" BorderStyle="None" CausesValidation="False"
		CssClass="CommandButton"&gt;Add New&lt;/asp:linkbutton&gt;
</xsl:template>

<!--Cac cot an chua bo key-->
<xsl:template match="entity/columns" mode="keycolumns">
	<xsl:for-each select="property[@isPK='True']">
		&lt;asp:BoundColumn DataField="<xsl:value-of select="@columnName"/>" HeaderText="<xsl:value-of select="@columnName"/>" Visible=False&gt;&lt;/asp:BoundColumn&gt;
	</xsl:for-each>
</xsl:template>

<!--danh sach cac cot-->
<xsl:template match="entity/columns" mode="columns">
	<xsl:for-each select="property">
		&lt;asp:BoundColumn DataField="<xsl:value-of select="@columnName"/>" HeaderText="<xsl:value-of select="@columnName"/>"&gt;&lt;/asp:BoundColumn&gt;
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
