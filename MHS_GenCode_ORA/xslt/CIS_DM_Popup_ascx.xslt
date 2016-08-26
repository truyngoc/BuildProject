<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
&lt;%@ Control Language="vb" AutoEventWireup="false" CodeBehind="<xsl:value-of select="entity/@tableName"/>_Detail.ascx.vb" Inherits="CIS.WebParts.<xsl:value-of select="entity/@tableName"/>_Detail" %&gt;
&lt;%@ Register Assembly="CIS.WebControlLibrary" Namespace="CIS.WebControlLibrary" TagPrefix="cc1" %&gt;
&lt;table width ="800px" border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#E1E1E1" style="border-collapse: collapse"&gt;
    &lt;tr valign ="top" &gt;
        &lt;td align ="center"&gt;
            &lt;asp:Label ID="lblPageTitle" CssClass="PageTitle" runat="server" Text=""  /&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td align ="center"&gt;
            &lt;table border="0" align="center" cellpadding="2" cellspacing="2" bordercolor="#E1E1E1" style="border-collapse: collapse"&gt;
                <xsl:apply-templates select="entity/columns" mode="Controls"/>
            &lt;/table&gt; 
        &lt;/td&gt;
    &lt;/tr&gt;    
    &lt;tr&gt;
        &lt;td&gt;
            &lt;div style="white-space: nowrap; text-align: center;"&gt;                
		&lt;asp:Button ID="cmdSave" runat="server" Text="&lt;%$ Resources:CIS, cmdSave %&gt;" CausesValidation="true" CssClass="commonButton" /&gt;
		&lt;asp:Button ID="cmdExit" runat="server" CausesValidation="false" Text="&lt;%$ Resources:CIS, cmdExit %&gt;"
                    CssClass="commonButton" /&gt;
		
            &lt;/div&gt;
        &lt;/td&gt;
    &lt;/tr&gt;  
&lt;/table&gt;  
 
</xsl:template>

<!--danh sach property-->
<xsl:template match="entity/columns" mode="Controls">
	<xsl:for-each select="property[@isPK='True']">
	&lt;tr&gt;
		&lt;td class="promptText" &gt;&lt;asp:Label ID="Label1" CssClass ="Label" runat="server" Text="&lt;%$ Resources:CIS, <xsl:value-of select="@columnName"/> %&gt;"  /&gt;&lt;/td&gt;
		&lt;td class="promptText" &gt;<xsl:choose>
										<xsl:when test="@dataType='date' or @dataType='datetime'">
										
										</xsl:when>
										<xsl:otherwise>
												&lt;asp:textbox id="txt<xsl:value-of select="@columnName"/>" CssClass ="fieldText" runat="server"&gt;&lt;/asp:textbox&gt;
												&lt;asp:Label id="lbl<xsl:value-of select="@columnName"/>" CssClass ="Text" runat="server"&gt;&lt;/asp:Label&gt;										
										</xsl:otherwise>
									</xsl:choose> &lt;/td&gt;
	&lt;/tr&gt;
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='False']">
	&lt;tr&gt;
		&lt;td class="promptText" &gt;&lt;asp:Label ID="Label1" CssClass ="Label" runat="server" Text="&lt;%$ Resources:CIS, <xsl:value-of select="@columnName"/>%&gt;"  /&gt;&lt;/td&gt;
		&lt;td class="promptText" &gt;<xsl:choose>
										<xsl:when test="@dataType='date' or @dataType='datetime'">
										
										</xsl:when>
										<xsl:otherwise>
												&lt;asp:textbox id="txt<xsl:value-of select="@columnName"/>" CssClass ="fieldText" runat="server"&gt;&lt;/asp:textbox&gt;
										</xsl:otherwise>
									</xsl:choose> &lt;/td&gt;
	&lt;/tr&gt;
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
