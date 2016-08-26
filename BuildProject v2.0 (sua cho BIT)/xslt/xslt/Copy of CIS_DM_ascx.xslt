<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">


&lt;%@ Control Language="vb" AutoEventWireup="false" CodeBehind="<xsl:value-of select="entity/@tableName"/>_List.ascx.vb"
    Inherits="CIS.WebParts.<xsl:value-of select="entity/@tableName"/>_List" %&gt;
&lt;%@ Register Src="<xsl:value-of select="entity/@tableName"/>_Popup.ascx" TagName="<xsl:value-of select="entity/@tableName"/>_Popup" TagPrefix="uc1" %&gt;
&lt;asp:UpdatePanel ID="updMain" runat="server" &gt;
    &lt;ContentTemplate&gt;
        &lt;asp:UpdatePanel ID="updList" runat="server"&gt;
            &lt;Triggers&gt;
                &lt;asp:AsyncPostBackTrigger ControlID="popup<xsl:value-of select="entity/@tableName"/>" EventName="Saved" /&gt;
                &lt;asp:AsyncPostBackTrigger ControlID="popup<xsl:value-of select="entity/@tableName"/>" EventName="Canceled" /&gt;                          
            &lt;/Triggers&gt;
            &lt;ContentTemplate&gt;                 
                &lt;table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#999999" style="border-collapse:collapse"&gt;
                  &lt;tr&gt;
                    &lt;td height="24" class="title"&gt;&lt;asp:Label ID="lblCondition" runat="server" Text="điều kiện tìm kiếm"&gt;&lt;/asp:Label&gt;&lt;/td&gt;
                  &lt;/tr&gt;
                  &lt;tr&gt;
                    &lt;td&gt;&lt;br /&gt;
                        &lt;table width="98%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#E1E1E1" style="border-collapse:collapse"&gt;
                        <xsl:apply-templates select="entity/columns" mode="Controls"/>
                                         
                        &lt;/table&gt;
                        &lt;br /&gt;  
                    &lt;/td&gt;
                  &lt;/tr&gt;
                  &lt;tr&gt;
	                &lt;td&gt;
	                    &lt;div style="width: 100%; text-align: center"&gt;
	                        &lt;asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CausesValidation="false" CssClass="commonButon"/&gt;
                            &lt;asp:Button ID="btnInsert" runat="server" Text="Thêm mới" CausesValidation="false" CssClass="commonButon"/&gt;
                            &lt;asp:Button ID="btnDelete" runat="server" Text="Xóa" CausesValidation="false" CssClass="commonButon"/&gt;                            
                        &lt;/div&gt;
	                &lt;/td&gt;
	              &lt;/tr&gt; 
	              &lt;tr&gt;
	                &lt;td height="24" class="title"&gt;&lt;asp:Label ID="lblList" runat="server" Text="Danh sách <xsl:value-of select="entity/@tableName"/> "&gt;&lt;/asp:Label&gt;&lt;/td&gt;
	              &lt;/tr&gt;
	              &lt;tr&gt;
	                &lt;td&gt;
	                    &lt;asp:GridView ID="grdDanhMuc" runat="server" 
                            AutoGenerateColumns="False"  Width="100%" AllowPaging="True"&gt;
                            &lt;FooterStyle CssClass="grd_FooterStyle" /&gt;
                            &lt;RowStyle CssClass="grd_RowStyle" /&gt;
                            &lt;EmptyDataRowStyle CssClass="grd_EmptyDataRowStyle" /&gt;
                            &lt;Columns&gt;
                                &lt;asp:TemplateField&gt;
                                    &lt;HeaderTemplate&gt;
                                        &lt;asp:CheckBox ID="chkCheckAll" runat="server" CssClass="checkBox" AutoPostBack="true" OnCheckedChanged="CheckBox_CheckedChanged" /&gt;
                                    &lt;/HeaderTemplate&gt;
                                    &lt;ItemTemplate&gt;
                                        &lt;asp:CheckBox ID="chkItem" runat="server" CssClass="checkBox" AutoPostBack="true" OnCheckedChanged="CheckBox_CheckedChanged" /&gt;
                                    &lt;/ItemTemplate&gt;
                                    &lt;HeaderStyle CssClass="grd_header_check" /&gt;
                                    &lt;ItemStyle CssClass="grd_check"/&gt;
                                &lt;/asp:TemplateField&gt;
                                
                                
                             <xsl:apply-templates select="entity/columns" mode="columns"/>
                                
                                
                                
                                &lt;asp:CommandField HeaderStyle-CssClass="grd_header" 
                                    ItemStyle-CssClass="grd_command" SelectText="Sửa" ShowSelectButton="True" CausesValidation="False" &gt;
                                    &lt;HeaderStyle CssClass="grd_header" /&gt;
                                    &lt;ItemStyle CssClass="grd_command"/&gt;
                                &lt;/asp:CommandField&gt;
                                
                            &lt;/Columns&gt;
                            &lt;PagerStyle CssClass="grd_PagerStyle"/&gt;
                            &lt;SelectedRowStyle CssClass="grd_SelectedRowStyle" /&gt;
                            &lt;HeaderStyle CssClass="grd_HeaderStyle" /&gt;
                            &lt;EditRowStyle CssClass="grd_EditRowStyle" /&gt;
                            &lt;AlternatingRowStyle CssClass="grd_AlternatingRowStyle" /&gt;
                        &lt;/asp:GridView&gt;
	                &lt;/td&gt;
	              &lt;/tr&gt;
	              
	            &lt;/table&gt;
            &lt;/ContentTemplate&gt; 
        &lt;/asp:UpdatePanel&gt;          
        &lt;asp:UpdatePanel ID="updDetail" runat="server" Visible ="false" &gt;
            &lt;ContentTemplate&gt;                
                &lt;uc1:<xsl:value-of select="entity/@tableName"/>_Popup ID="popup<xsl:value-of select="entity/@tableName"/>" runat="server" /&gt;                
            &lt;/ContentTemplate&gt; 
        &lt;/asp:UpdatePanel&gt;
    &lt;/ContentTemplate&gt; 
&lt;/asp:UpdatePanel&gt;






</xsl:template>

<!--danh sach cac cot-->
<xsl:template match="entity/columns" mode="columns">
	<xsl:for-each select="property[@isPK='True']">
		&lt;asp:BoundField DataField="<xsl:value-of select="@columnName"/>" HeaderText="<xsl:value-of select="@columnName"/>"&gt;
            &lt;HeaderStyle CssClass="grd_header" /&gt;
            &lt;ItemStyle CssClass="grd_code" /&gt;
        &lt;/asp:BoundField&gt;
	</xsl:for-each>
	<xsl:for-each select="property[@isPK='False']">
		&lt;asp:BoundField DataField="<xsl:value-of select="@columnName"/>" HeaderText="<xsl:value-of select="@columnName"/>"&gt;
            &lt;HeaderStyle CssClass="grd_header" /&gt;
            <xsl:choose>
            	<xsl:when test="@dataType='varchar' or @dataType='nvarchar' or @dataType='char' or @dataType='nchar'" >
					&lt;ItemStyle CssClass="grd_text" /&gt;
				</xsl:when>
				<xsl:when test="@dataType='date' or @dataType='datetime'">
					&lt;ItemStyle CssClass="grd_date" /&gt;
				</xsl:when>
            	<xsl:otherwise>
            		&lt;ItemStyle CssClass="grd_number" /&gt;
				</xsl:otherwise>
			</xsl:choose>
        &lt;/asp:BoundField&gt;
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="Controls">
	<xsl:for-each select="property">
		&lt;tr&gt;
			&lt;td class="promptText"&gt;
				&lt;asp:Label ID="lbl<xsl:value-of select="@columnName"/>" runat="server" Text="<xsl:value-of select="@columnName"/>" &gt;&lt;/asp:Label&gt;&lt;/td&gt;
			&lt;td&gt;
				&lt;asp:TextBox ID="txt<xsl:value-of select="@columnName"/>" runat="server" CssClass ="fieldText"&gt;&lt;/asp:TextBox&gt;
			&lt;/td&gt;
			&lt;td class="promptText"&gt;
				&lt;/td&gt;
			&lt;td&gt;
				
			&lt;/td&gt;
		&lt;/tr&gt;           
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
