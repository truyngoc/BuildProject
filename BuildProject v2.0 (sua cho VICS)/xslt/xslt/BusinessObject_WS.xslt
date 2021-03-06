<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
'' =============================================
'' This Class is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
'' a freeware developed by bibi.
'' Template: BusinessObject.xslt 17/10/2006
'' Author:	<xsl:value-of select="entity/@author"/>
'' Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
'' Description:	
'' Revise History:	
'' =============================================
Public Class <xsl:value-of select="entity/@tableName"/>_BOWS	
    Private _ws As <xsl:value-of select="entity/@tableName"/>_WS.<xsl:value-of select="entity/@tableName"/>_WS
    Public Sub New(ByVal wsUrl As String)
        _ws = New <xsl:value-of select="entity/@tableName"/>_WS.<xsl:value-of select="entity/@tableName"/>_WS
        _ws.Url = wsUrl
        _ws.Credentials() = System.Net.CredentialCache.DefaultCredentials
    End Sub

    Public Sub New()
        _ws = New <xsl:value-of select="entity/@tableName"/>_WS.<xsl:value-of select="entity/@tableName"/>_WS
        _ws.Url = "http://localhost/<xsl:value-of select="entity/@webservicename"/>/<xsl:value-of select="entity/@tableName"/>_WS.asmx"
        _ws.Credentials() = System.Net.CredentialCache.DefaultCredentials
    End Sub

	Public Sub InsertItem(ByVal objData As <xsl:value-of select="entity/@tableName"/>_Info)
        Dim bibi As ReturnMessage
        bibi = InfoBase.ToObject(_ws.InsertItem(objData.ToXML), GetType(ReturnMessage))
        If bibi.RetCode = ReturnCode.Failed Then
            Throw New Exception(bibi.Description)
        End If
        bibi = Nothing
  	End Sub

	Public Sub UpdateItem(ByVal objData As <xsl:value-of select="entity/@tableName"/>_Info)
        Dim bibi As ReturnMessage
        bibi = InfoBase.ToObject(_ws.UpdateItem(objData.ToXML), GetType(ReturnMessage))
        If bibi.RetCode = ReturnCode.Failed Then
            Throw New Exception(bibi.Description)
        End If
        bibi = Nothing
	End Sub

	Public Sub DeleteItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)
        Dim bibi As ReturnMessage
        bibi = InfoBase.ToObject(_ws.DeleteItem(<xsl:apply-templates select="entity/columns" mode="DeleteValues"/>), GetType(ReturnMessage))
        If bibi.RetCode = ReturnCode.Failed Then
            Throw New Exception(bibi.Description)
        End If
        bibi = Nothing
	End Sub

	Public Function SelectItem(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>) As <xsl:value-of select="entity/@tableName"/>_Info
        Dim bibi As ReturnMessage
        bibi = InfoBase.ToObject(_ws.SelectItem(<xsl:apply-templates select="entity/columns" mode="DeleteValues"/>), GetType(ReturnMessage))
        If bibi.RetCode = ReturnCode.Failed Then
            Throw New Exception(bibi.Description)
        ElseIf bibi.RetCode = ReturnCode.Success Then
            Dim retVal As <xsl:value-of select="entity/@tableName"/>_Info
            retVal = InfoBase.ToObject(bibi.Data, GetType(<xsl:value-of select="entity/@tableName"/>_Info))
            Return retVal
        End If
	End Function

	Public Function SelectAllItems() As DataSet
        Dim bibi As ReturnMessage
        bibi = InfoBase.ToObject(_ws.SelectAllItems(), GetType(ReturnMessage))
        If bibi.RetCode = ReturnCode.Failed Then
            Throw New Exception(bibi.Description)
        ElseIf bibi.RetCode = ReturnCode.Success Then
            Dim retVal As New DataSet
            Dim rd As System.IO.StringReader
            rd = New System.IO.StringReader(bibi.DataSchema)
            retVal.ReadXmlSchema(rd)
            rd = New System.IO.StringReader(bibi.Data)
            retVal.ReadXml(rd)
            Return retVal
        End If
	End Function
	<xsl:apply-templates select="entity" mode="SelectBy"/>
End Class

</xsl:template>

<!--Cac function SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
    Public Function SelectItemsBy<xsl:value-of select="@columnName"/>(ByVal <xsl:value-of select="@columnName"/> As <xsl:value-of select="@vbDataType"/>) As DataSet
        Dim bibi As ReturnMessage
        bibi = InfoBase.ToObject(_ws.SelectItemsBy<xsl:value-of select="@columnName"/>(<xsl:value-of select="@columnName"/>), GetType(ReturnMessage))
        If bibi.RetCode = ReturnCode.Failed Then
            Throw New Exception(bibi.Description)
        ElseIf bibi.RetCode = ReturnCode.Success Then
            Dim retVal As New DataSet
            Dim rd As System.IO.StringReader
            rd = New System.IO.StringReader(bibi.DataSchema)
            retVal.ReadXmlSchema(rd)
            rd = New System.IO.StringReader(bibi.Data)
            retVal.ReadXml(rd)
            Return retVal
        End If
    End Function
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho sub delete-->
<xsl:template match="entity/columns" mode="DeleteParams">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/></xsl:for-each>
</xsl:template>

<!--danh sach tham so truyen vao sub delete cua DAO-->
<xsl:template match="entity/columns" mode="DeleteValues">
	<xsl:for-each select="property[@isPK='True']"><xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose><xsl:value-of select="@columnName"/></xsl:for-each>
</xsl:template>

<!--Gan gia tri trong Sub SelectItem-->
<xsl:template match="entity/columns" mode="SelectSetValues">
	<xsl:for-each select="property">
			If not IsDBNull(row.Item("<xsl:value-of select="@columnName"/>")) Then retVal.<xsl:value-of select="@columnName"/> = row.Item("<xsl:value-of select="@columnName"/>")</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
