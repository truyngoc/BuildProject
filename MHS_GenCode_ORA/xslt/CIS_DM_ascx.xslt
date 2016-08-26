<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
   &lt;%@ Control Language="vb" AutoEventWireup="false" CodeBehind="<xsl:value-of select="entity/@tableName"/>_List.ascx.vb"
        Inherits="CIS.WebParts.<xsl:value-of select="entity/@tableName"/>_List" %&gt;
      &lt;%@ Register Assembly="CIS.WebControlLibrary" Namespace="CIS.WebControlLibrary" TagPrefix="cc1" %&gt;
        &lt;%@ Register Src="<xsl:value-of select="entity/@tableName"/>_Detail.ascx" TagName="<xsl:value-of select="entity/@tableName"/>_Detail" TagPrefix="uc1" %&gt;
          &lt;asp:UpdatePanel ID="udpMain" runat="server"&gt;
            &lt;ContentTemplate&gt;
              &lt;asp:UpdatePanel ID="udpList" runat="server"&gt;
                &lt;ContentTemplate&gt;
                  &lt;table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#999999"
                      style="border-collapse: collapse"&gt;
                    &lt;tr&gt;
                      &lt;td height="24" class="title"&gt;
                        &lt;asp:Label ID="lblTitleSearchCondition" runat="server" Text="
                          &lt;%$ Resources:CIS, SearchCondition %&gt;"&gt;&lt;/asp:Label&gt;
                      &lt;/td&gt;
                    &lt;/tr&gt;
                    &lt;tr&gt;
                      &lt;td&gt;
                        &lt;br /&gt;
                        &lt;table width="98%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#E1E1E1"
                            style="border-collapse: collapse"&gt;
                            
                            <xsl:apply-templates select="entity/columns" mode="Controls"/>
                            
                        &lt;/table&gt;
                       
                        &lt;br /&gt;
                      &lt;/td&gt;
                    &lt;/tr&gt;
                    &lt;tr&gt;
                      &lt;td&gt;
                        &lt;div style="width: 100%; text-align: center"&gt;
                          &lt;asp:Button ID="cmdSearch" runat="server" Text="
                          &lt;%$ Resources:CIS, cmdSearch %&gt;"
                                    CausesValidation="false" CssClass="commonButon" /&gt;
                          &lt;asp:Button ID="cmdAdd" runat="server" Text="
                          &lt;%$ Resources:CIS, cmdAdd %&gt;" CausesValidation="false"
                                    CssClass="commonButon" Visible="False" /&gt;
                          &lt;asp:Button ID="cmdDelete" runat="server" Text="
                          &lt;%$ Resources:CIS, cmdDelete %&gt;"
                                    CausesValidation="false" CssClass="commonButon" /&gt;
                          &lt;asp:Button ID="cmdExit" runat="server" Text="
                          &lt;%$ Resources:CIS, cmdExit %&gt;" CausesValidation="false"
                                    CssClass="commonButon" /&gt;
                        &lt;/div&gt;
                      &lt;/td&gt;
                    &lt;/tr&gt;
                    &lt;tr&gt;
                      &lt;td height="24" class="title"&gt;
                        &lt;asp:Label ID="lblTitleList" runat="server" Text="
                          &lt;%$ Resources:CIS, <xsl:value-of select="entity/@tableName"/> %&gt;"&gt;&lt;/asp:Label&gt;
                      &lt;/td&gt;
                    &lt;/tr&gt;
                    &lt;tr&gt;
                      &lt;td&gt;
                        &lt;asp:GridView ID="grdDanhMuc" runat="server" AutoGenerateColumns="False" Width="100%"
                            AllowPaging="True" EmptyDataText="
                          &lt;%$ Resources:CIS, grdEmptyDataText %&gt;" CssClass="GridLayout"&gt;
                          &lt;FooterStyle CssClass="GridFooter"&gt;&lt;/FooterStyle&gt;
                          &lt;AlternatingRowStyle CssClass="GridAlternatingItem" /&gt;
                          &lt;RowStyle CssClass="GridItem" /&gt;
                          &lt;HeaderStyle CssClass="GridHeader"&gt;&lt;/HeaderStyle&gt;
                          &lt;Columns&gt;
                            &lt;asp:TemplateField&gt;
                              &lt;HeaderTemplate&gt;
                                &lt;asp:CheckBox ID="chkCheckAll" runat="server" CssClass="checkBox" AutoPostBack="true"
                                    OnCheckedChanged="CheckBox_CheckedChanged" /&gt;
                              &lt;/HeaderTemplate&gt;
                              &lt;ItemTemplate&gt;
                                &lt;asp:CheckBox ID="chkItem" runat="server" CssClass="checkBox" AutoPostBack="true"
                                    OnCheckedChanged="CheckBox_CheckedChanged" /&gt;
                              &lt;/ItemTemplate&gt;
                              &lt;HeaderStyle CssClass="GridHeader" /&gt;
                              &lt;ItemStyle CssClass="GridItemCheckBox" Width="5%" /&gt;
                            &lt;/asp:TemplateField&gt;
                            
                            <xsl:apply-templates select="entity/columns" mode="columns"/>

                            &lt;asp:CommandField SelectText="
                              &lt;%$ Resources:CIS, cmdEdit %&gt;" ShowSelectButton="True"
                                        CausesValidation="False"&gt;
                              &lt;ItemStyle CssClass="GridItemLink" Width="5%" /&gt;
                            &lt;/asp:CommandField&gt;
                          &lt;/Columns&gt;
                          &lt;PagerStyle HorizontalAlign="Center" CssClass="GridPager"&gt;&lt;/PagerStyle&gt;
                        &lt;/asp:GridView&gt;
                      &lt;/td&gt;
                    &lt;/tr&gt;
                  &lt;/table&gt;
                &lt;/ContentTemplate&gt;
              &lt;/asp:UpdatePanel&gt;
              &lt;asp:UpdatePanel ID="udpDetail" runat="server"&gt;
                &lt;ContentTemplate&gt;
                  &lt;uc1:<xsl:value-of select="entity/@tableName"/>_Detail ID="<xsl:value-of select="entity/@tableName"/>_Detail1" runat="server" /&gt;
                &lt;/ContentTemplate&gt;
              &lt;/asp:UpdatePanel&gt;
            &lt;/ContentTemplate&gt;
          &lt;/asp:UpdatePanel&gt;


</xsl:template>

                          
<xsl:template match="entity/columns" mode="Controls">
	<xsl:for-each select="property">
		&lt;tr&gt;
			&lt;td class="promptText"&gt;
				&lt;asp:Label ID="lbl<xsl:value-of select="@columnName"/>" runat="server" Text="&lt;%$ Resources:CIS, <xsl:value-of select="@columnName"/>%&gt;" &gt;&lt;/asp:Label&gt;&lt;/td&gt;
			&lt;td class="promptText"&gt;
				&lt;asp:TextBox ID="txt<xsl:value-of select="@columnName"/>" runat="server" CssClass ="fieldText"&gt;&lt;/asp:TextBox&gt;
			&lt;/td&gt;
			&lt;td class="promptText"&gt;
				&lt;/td&gt;
			&lt;td class="promptText"&gt;
				
			&lt;/td&gt;
		&lt;/tr&gt;           
	</xsl:for-each>
</xsl:template>
                              
                              
<xsl:template match="entity/columns" mode="columns">
	<xsl:for-each select="property[@isPK='True']">
		&lt;asp:BoundField DataField="<xsl:value-of select="@columnName"/>" HeaderText="&lt;%$ Resources:CIS, <xsl:value-of select="@columnName"/>%&gt;"&gt;
            &lt;ItemStyle CssClass="GridItemCode" /&gt;
        &lt;/asp:BoundField&gt;
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='False']">
		&lt;asp:BoundField DataField="<xsl:value-of select="@columnName"/>" HeaderText="&lt;%$ Resources:CIS, <xsl:value-of select="@columnName"/>%&gt;"&gt;
            &lt;HeaderStyle CssClass="GridHeader" /&gt;
            <xsl:choose>
            	<xsl:when test="@dataType='varchar' or @dataType='nvarchar' or @dataType='char' or @dataType='nchar'" >
					&lt;ItemStyle CssClass="GridItemText" /&gt;
				</xsl:when>
				<xsl:when test="@dataType='date' or @dataType='datetime'">
					&lt;ItemStyle CssClass="GridItemDate" /&gt;
				</xsl:when>
            	<xsl:otherwise>
            		&lt;ItemStyle CssClass="GridItemNumber" /&gt;
				</xsl:otherwise>
			</xsl:choose>
        &lt;/asp:BoundField&gt;
	</xsl:for-each>
</xsl:template>
                              

</xsl:stylesheet>
