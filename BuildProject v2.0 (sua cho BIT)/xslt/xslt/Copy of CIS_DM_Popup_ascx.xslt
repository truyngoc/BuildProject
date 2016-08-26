<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
&lt;%@ Control Language="vb" AutoEventWireup="false" CodeBehind="<xsl:value-of select="entity/@tableName"/>_Popup.ascx.vb"
    Inherits="CIS.WebParts.<xsl:value-of select="entity/@tableName"/>_Popup" %&gt;
    &lt;asp:HiddenField ID="hidAction" Value="" runat="server" /&gt;
    &lt;table class="tblPopup"&gt;        
        &lt;tr&gt;
            &lt;td colspan ="2"&gt;
                &lt;asp:Label ID="lblDanhMuc" runat="server" Text="Sửa danh mục" CssClass ="caption" /&gt;
            &lt;/td&gt;
        &lt;/tr&gt; 
           
        <xsl:apply-templates select="entity/columns" mode="Controls"/>
        &lt;tr&gt;
            &lt;td colspan ="2"&gt;
                &lt;div style="white-space: nowrap; text-align: center;"&gt;
                    &lt;asp:Button ID="btnSave" runat="server" Text="Save" CausesValidation="true" CssClass ="commonButton"/&gt;
                    &lt;asp:Button ID="btnCancel" runat="server" CausesValidation="false" Text="Cancel" CssClass ="commonButton"/&gt;
                &lt;/div&gt;
            &lt;/td&gt;
        &lt;/tr&gt;
    &lt;/table&gt;
 
</xsl:template>

<!--danh sach property-->
<xsl:template match="entity/columns" mode="Controls">
	<xsl:for-each select="property[@isPK='True']">
	&lt;tr&gt;
		&lt;td class="promptText" &gt;<xsl:value-of select="@columnName"/>&lt;/td&gt;
		&lt;td class="promptText" &gt;<xsl:choose>
										<xsl:when test="@dataType='date' or @dataType='datetime'">
										
										</xsl:when>
										<xsl:otherwise>
												&lt;asp:textbox id="txt<xsl:value-of select="@columnName"/>" runat="server"&gt;&lt;/asp:textbox&gt;
												&lt;asp:Label id="lbl<xsl:value-of select="@columnName"/>" runat="server"&gt;&lt;/asp:Label&gt;										
										</xsl:otherwise>
									</xsl:choose> &lt;/td&gt;
	&lt;/tr&gt;
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='False']">
	&lt;tr&gt;
		&lt;td class="promptText" &gt;<xsl:value-of select="@columnName"/>&lt;/td&gt;
		&lt;td class="promptText" &gt;<xsl:choose>
										<xsl:when test="@dataType='date' or @dataType='datetime'">
										
										</xsl:when>
										<xsl:otherwise>
												&lt;asp:textbox id="txt<xsl:value-of select="@columnName"/>" runat="server"&gt;&lt;/asp:textbox&gt;
										</xsl:otherwise>
									</xsl:choose> &lt;/td&gt;
	&lt;/tr&gt;
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
