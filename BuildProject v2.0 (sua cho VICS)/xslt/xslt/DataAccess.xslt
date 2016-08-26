<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
'' =============================================
'' This Class is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
'' a freeware developed by bibi.
'' Template: DataAccess.xslt 17/10/2006
'' Author:	<xsl:value-of select="entity/@author"/>
'' Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
'' Description:	
'' Revise History:	
'' =============================================
Imports CIS.DataClass
Imports CIS.Common
Public Class <xsl:value-of select="entity/@tableName"/>_DAO
	Public Sub InsertItem(ByVal blCtrInformation As BLControlInformation, ByVal bibi As <xsl:value-of select="entity/@tableName"/>_Info)
        SqlHelper.ExecuteNonQuery(blCtrInformation, CommandType.StoredProcedure, "<xsl:value-of select="entity/@tableName"/>_Insert" _
         <xsl:apply-templates select="entity/columns" mode="Insert"/>)
    End Sub

    Public Sub UpdateItem(ByVal blCtrInformation As BLControlInformation, ByVal bibi As <xsl:value-of select="entity/@tableName"/>_Info)
        SqlHelper.ExecuteNonQuery(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="entity/@tableName"/>_Update" _
         <xsl:apply-templates select="entity/columns" mode="Update"/>)
    End Sub

    Public Sub DeleteItem(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)
        SqlHelper.ExecuteNonQuery(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="entity/@tableName"/>_Delete" _
         <xsl:apply-templates select="entity/columns" mode="Delete"/>)
    End Sub

    Public Function SelectItem(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As DataSet
        Return SqlHelper.ExecuteDataSet(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="entity/@tableName"/>_SelectItem" _
         <xsl:apply-templates select="entity/columns" mode="Delete"/>)
    End Function

    Public Function SelectAllItems(ByVal blCtrInformation As BLControlInformation) As DataSet
        Return SqlHelper.ExecuteDataSet(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="entity/@tableName"/>_SelectAllItems")
    End Function

    Public Function IsExistsItem(ByVal blCtrInformation As BLControlInformation, <xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As Boolean
        Dim dr As SqlClient.SqlDataReader = SqlHelper.ExecuteReader(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="entity/@tableName"/>_SelectItem" _
         <xsl:apply-templates select="entity/columns" mode="Delete"/>)
         Dim bol As Boolean = dr.Read
        dr.Close()
        Return bol
    End Function

    Public Sub DeleteItems(ByVal blCtrInformation As BLControlInformation, ByVal infoKeys As <xsl:value-of select="entity/@tableName"/>_InfoKeys)
        For Each info As SHAIQUAN_InfoKey In infoKeys.Keys
            SqlHelper.ExecuteNonQuery(blCtrInformation, CommandType.StoredProcedure, _
             "<xsl:value-of select="entity/@tableName"/>_Delete" _
         <xsl:apply-templates select="entity/columns" mode="Delete"/>)
        Next
    End Sub
    
    Public Function Search(ByVal blCtrInformation As BLControlInformation, ByVal info As <xsl:value-of select="entity/@tableName"/>_Info) As DataSet
        Return SqlHelper.ExecuteDataSet(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="entity/@tableName"/>_Search" _
         <xsl:apply-templates select="entity/columns" mode="Update"/>)
    End Function
   	<xsl:apply-templates select="entity" mode="SelectBy"/>
End Class

</xsl:template>

<!--danh sach tham so cho insert-->
<xsl:template match="entity/columns" mode="Insert">
		<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">, SqlHelper.CreateParameter("@<xsl:value-of select="@columnName"/>", SqlDbType.<xsl:value-of select="@dataType"/>, bibi.<xsl:value-of select="@columnName"/>) _
		</xsl:for-each>
		<xsl:for-each select="property[@isIdentity='False' or @isPK='False']">, SqlHelper.CreateParameter("@<xsl:value-of select="@columnName"/>", SqlDbType.<xsl:value-of select="@dataType"/>,IIf(<xsl:choose><xsl:when test="@dataType='datetime' or @dataType='int' or @dataType='bit' or @dataType='float' or @dataType='double' or @dataType='decimal'"></xsl:when></xsl:choose>bibi.<xsl:value-of select="@columnName"/><xsl:choose><xsl:when test="@dataType='datetime'"> = Date.MinValue</xsl:when><xsl:when test="@dataType='int'"> = 0</xsl:when><xsl:when test="@dataType='float'"> = 0</xsl:when><xsl:when test="@dataType='double'"> = 0</xsl:when><xsl:when test="@dataType='decimal'"> = 0</xsl:when><xsl:otherwise>)</xsl:otherwise></xsl:choose>, DBNull.Value, bibi.<xsl:value-of select="@columnName"/>)) _
		</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho Update-->
<xsl:template match="entity/columns" mode="Update">
		<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">, SqlHelper.CreateParameter("@<xsl:value-of select="@columnName"/>", SqlDbType.<xsl:value-of select="@dataType"/>, IIf(<xsl:choose><xsl:when test="@dataType='datetime' or @dataType='int' or @dataType='bit' or @dataType='float' or @dataType='double' or @dataType='decimal'"></xsl:when><xsl:otherwise>String.IsNullOrEmpty(</xsl:otherwise></xsl:choose>bibi.<xsl:value-of select="@columnName"/><xsl:choose><xsl:when test="@dataType='datetime'"> = Date.MinValue</xsl:when><xsl:when test="@dataType='int'"> = 0</xsl:when><xsl:otherwise>)</xsl:otherwise></xsl:choose>, DBNull.Value, bibi.<xsl:value-of select="@columnName"/>)) _
		</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho sub delete-->
<xsl:template match="entity/columns" mode="DeleteParams">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/></xsl:for-each>
</xsl:template>

<!--danh sach tham so cho delete-->
<xsl:template match="entity/columns" mode="Delete">
		<xsl:for-each select="property[@isPK='True']">,SqlHelper.CreateParameter("@<xsl:value-of select="@columnName"/>", SqlDbType.<xsl:value-of select="@dataType"/>, <xsl:value-of select="@columnName"/>) _
		</xsl:for-each>
</xsl:template>

<!--Cac function SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
    Public Function SelectItemsBy<xsl:value-of select="@columnName"/>(ByVal blCtrInformation As BLControlInformation,ByVal <xsl:value-of select="@columnName"/> As <xsl:value-of select="@vbDataType"/>) As DataSet
        Return SqlHelper.ExecuteDataSet(blCtrInformation, CommandType.StoredProcedure, _
         "<xsl:value-of select="$tablename"/>_SelectBy<xsl:value-of select="@columnName"/>" _
		, SqlHelper.CreateParameter("@<xsl:value-of select="@columnName"/>", SqlDbType.<xsl:value-of select="@dataType"/>, IIf(<xsl:choose><xsl:when test="@dataType='datetime' or @dataType='int'"></xsl:when><xsl:otherwise>String.IsNullOrEmpty(</xsl:otherwise></xsl:choose><xsl:value-of select="@columnName"/><xsl:choose><xsl:when test="@dataType='datetime'"> = Date.MinValue</xsl:when><xsl:when test="@dataType='int'"> = 0</xsl:when><xsl:otherwise>)</xsl:otherwise></xsl:choose>, DBNull.Value, <xsl:value-of select="@columnName"/>)) _
		)
    End Function
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
