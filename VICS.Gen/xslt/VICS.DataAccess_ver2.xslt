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
      Using dbCommand As DbCommand = defaultDB.GetStoredProcCommand("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_insert")
        ' add parameter
        <xsl:apply-templates select="entity/columns" mode="Insert"/>
        ' execute
        defaultDB.ExecuteNonQuery(dbCommand)    
      End Using        
    End Sub

    Public Sub UpdateItem(ByVal obj As <xsl:value-of select="entity/@tableName"/>_Obj)
    Using dbCommand As DbCommand = defaultDB.GetStoredProcCommand("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_update")
        ' add parameter
        <xsl:apply-templates select="entity/columns" mode="Update"/>
        ' execute
        defaultDB.ExecuteNonQuery(dbCommand)
    End Using
    End Sub

    Public Sub DeleteItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)
        defaultDB.ExecuteNonQuery("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_delete" _
        <xsl:apply-templates select="entity/columns" mode="Delete"/>)
    End Sub

    Public Function SelectItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As <xsl:value-of select="entity/@tableName"/>_Obj
        Return defaultDB.ExecuteSprocAccessor(Of <xsl:value-of select="entity/@tableName"/>_Obj)("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_getItem" _
        <xsl:apply-templates select="entity/columns" mode="Delete"/>, Nothing _
        ).FirstOrDefault
    End Function

    Public Function Search(ByVal obj As <xsl:value-of select="entity/@tableName"/>_Obj) As IEnumerable(Of <xsl:value-of select="entity/@tableName"/>_Obj)
        Return defaultDB.ExecuteSprocAccessor(Of <xsl:value-of select="entity/@tableName"/>_Obj)("PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_get" _
        <xsl:apply-templates select="entity/columns" mode="Search"/>, Nothing _
    )
    End Function

    Public Function CheckExist(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As Boolean
        Dim sqlCommand As String = "PKG_<xsl:value-of select="entity/@tableName"/>.<xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_checkExist"
        Dim ret As Object
        
        Using dbCommand As DbCommand = defaultDB.GetStoredProcCommand(sqlCommand)
          <xsl:apply-templates select="entity/columns" mode="CheckExist"/>defaultDB.AddOutParameter(dbCommand, "reccount", DbType.Int32, 0)

          defaultDB.ExecuteNonQuery(dbCommand)

          ret = defaultDB.GetParameterValue(dbCommand, "reccount")
        End Using

        If ret > 0 Then
          Return True
        Else
          Return False
        End If
    End Function
    <xsl:apply-templates select="entity" mode="SelectBy"/>
End Class

</xsl:template>

<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<!--danh sach tham so cho insert-->
<xsl:template match="entity/columns" mode="Insert">
		<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">defaultDB.AddInParameter(dbCommand,"p_<xsl:value-of select="@columnName"/>", DbType.<xsl:value-of select="@oracle2DBType"/>, GetDBNull(obj.<xsl:value-of select="@columnName"/>))
		</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho Update-->
<xsl:template match="entity/columns" mode="Update">
		<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">defaultDB.AddInParameter(dbCommand,"p_<xsl:value-of select="@columnName"/>", DbType.<xsl:value-of select="@oracle2DBType"/>, GetDBNull(obj.<xsl:value-of select="@columnName"/>))
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

<!--danh sach tham so cho check exist -->
<xsl:template match="entity/columns" mode="CheckExist">
		<xsl:for-each select="property[@isPK='True']">defaultDB.AddInParameter(dbCommand,"p_<xsl:value-of select="@columnName"/>", DbType.<xsl:value-of select="@oracle2DBType"/>, <xsl:value-of select="@columnName"/>)
    </xsl:for-each>
</xsl:template>
  
<!--danh sach tham so cho Search-->
<xsl:template match="entity/columns" mode="Search">
  <xsl:for-each select="property[@isIdentity='False' or @isPK='True']">, GetDBNull(obj.<xsl:value-of select="@columnName"/>) _
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
