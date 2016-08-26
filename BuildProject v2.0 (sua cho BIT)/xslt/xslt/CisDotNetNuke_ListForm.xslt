<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
	
	&lt;%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wucDanhMuc_<xsl:value-of select="entity/@tableName"/>.ascx.vb" Inherits="wucDanhMuc_<xsl:value-of select="entity/@tableName"/>" %&gt;
&lt;asp:ScriptManager ID="ScriptManager1" runat="server"&gt;&lt;/asp:ScriptManager&gt;
&lt;asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional"&gt;
    &lt;Triggers&gt;
        &lt;asp:AsyncPostBackTrigger ControlID="pnlChiTiet" /&gt; 
    &lt;/Triggers&gt;
    &lt;ContentTemplate&gt;
        &lt;asp:GridView ID="grdDanhMuc" runat="server" Width="100%" ShowFooter="True"&gt;
		    &lt;Columns&gt;
			    &lt;asp:TemplateField ShowHeader="False"&gt;
				    &lt;ItemTemplate&gt;
					    &lt;asp:ImageButton ID="btnEdit" runat="server"   SkinID="GridEditButton"  OnClick="btnEdit_Click"
                            CausesValidation="false" /&gt;
					    &lt;asp:ImageButton ID="btnDelete" runat="server" SkinID="GridDeleteButton"  OnClick="btnDelete_Click"
                            OnClientClick="javascript:return confirm('Are you sure you want to delete this row?');"  
                            CausesValidation="false" /&gt;
				    &lt;/ItemTemplate&gt;
				    &lt;FooterTemplate&gt;
				        &lt;asp:ImageButton ID="btnInsert" runat="server"   SkinID="GridInsertButton" OnClick="btnInsert_Click"
                            CausesValidation="false" /&gt;
				    &lt;/FooterTemplate&gt;
			        &lt;FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" /&gt;
			        &lt;ItemStyle Width="6%" /&gt;					    
			    &lt;/asp:TemplateField&gt;
			    <xsl:apply-templates select="entity/columns" mode="keycolumns"/>
				<xsl:apply-templates select="entity/columns" mode="columns"/>
		    &lt;/Columns&gt;
	    &lt;/asp:GridView&gt;
        &lt;div style="width: 100%; text-align: center" &gt;
            &lt;asp:Button ID="btnRefresh" runat="server" Text="Cập nhật lại danh sách" /&gt;
        &lt;/div&gt;	
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
