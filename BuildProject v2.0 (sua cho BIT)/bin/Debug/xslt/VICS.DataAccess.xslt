<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports VICS.Object
Imports VICS.Common

Public Class <xsl:value-of select="entity/@tableName"/>_DH
	Inherits DataAccessBase
	  Public Sub InsertItem(ByVal obj As <xsl:value-of select="entity/@tableName"/>_Obj)
        defaultDB.ExecuteNonQuery("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_insert" _
        <xsl:apply-templates select="entity/columns" mode="Insert"/>)
    End Sub

    Public Sub UpdateItem(ByVal obj As <xsl:value-of select="entity/@tableName"/>_Obj)
        defaultDB.ExecuteNonQuery("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_update" _
        <xsl:apply-templates select="entity/columns" mode="Update"/>)
    End Sub

    Public Sub DeleteItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)
        defaultDB.ExecuteNonQuery("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_delete" _
        <xsl:apply-templates select="entity/columns" mode="Delete"/>)
    End Sub

    Public Function SelectItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As <xsl:value-of select="entity/@tableName"/>_Obj
        Return defaultDB.ExecuteSprocAccessor(Of <xsl:value-of select="entity/@tableName"/>_Obj)("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_getItem" _
        <xsl:apply-templates select="entity/columns" mode="Delete"/>).FirstOrDefault
    End Function
    
    Public Function Search(ByVal obj As <xsl:value-of select="entity/@tableName"/>_Obj) As IEnumerable(Of <xsl:value-of select="entity/@tableName"/>_Obj)
        Return defaultDB.ExecuteSprocAccessor(Of <xsl:value-of select="entity/@tableName"/>_Obj)("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_get" _
         <xsl:apply-templates select="entity/columns" mode="Insert"/>)
    End Function
   	<xsl:apply-templates select="entity" mode="SelectBy"/>
End Class

</xsl:template>

<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<!--danh sach tham so cho insert-->
<xsl:template match="entity/columns" mode="Insert">
		<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">, GetDBNull(obj.<xsl:value-of select="@columnName"/>) _
		</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho Update-->
<xsl:template match="entity/columns" mode="Update">
		<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">, GetDBNull(obj.<xsl:value-of select="@columnName"/>) _
		</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho sub delete-->
<xsl:template match="entity/columns" mode="DeleteParams">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/></xsl:for-each>
</xsl:template>

<!--danh sach tham so cho delete-->
<xsl:template match="entity/columns" mode="Delete">
		<xsl:for-each select="property[@isPK='True']">, <xsl:value-of select="@columnName"/> _
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
