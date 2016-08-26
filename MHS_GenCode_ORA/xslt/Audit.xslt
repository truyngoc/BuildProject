<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
Imports GTT.Utils
Imports System.Text
Imports System.Reflection

Namespace PrepareAudit
    Friend Class <xsl:value-of select="entity/@tableName"/>
    Inherits PrepareAuditBase

      'Tạo nội dung XML theo bộ key kèm theo thẻ tên bảng
      Protected Friend Shared Function XMLObject(<xsl:apply-templates select="entity/columns" mode="XMLObjectParam1"/>) As String
          Dim kq As New StringBuilder()
          kq.Append("&lt;<xsl:value-of select="entity/@tableName"/>&gt;")
          <xsl:apply-templates select="entity/columns" mode="XMLObjectContent1"/>
          kq.Append("&lt;/<xsl:value-of select="entity/@tableName"/>&gt;")
          Return kq.ToString()
      End Function
		
		  'Tạo nội dung XML theo toàn bộ các trường kèm theo thẻ tên bảng
		  Protected Friend Shared Function XMLObject(<xsl:apply-templates select="entity/columns" mode="XMLObjectParam2"/>) As String
              Dim kq As New StringBuilder()
              kq.Append("&lt;<xsl:value-of select="entity/@tableName"/>&gt;")
              <xsl:apply-templates select="entity/columns" mode="XMLObjectContent2"/>
              kq.Append("&lt;/<xsl:value-of select="entity/@tableName"/>&gt;")
              Return kq.ToString()
      End Function        
  		
		  'Tạo nội dung XML theo bộ key
      Protected Friend Shared Function ObjectKey(<xsl:apply-templates select="entity/columns" mode="ObjectKeyParam"/>) As String
          Dim kq As New StringBuilder()
          <xsl:apply-templates select="entity/columns" mode="ObjectKeyContent"/>
          Return kq.ToString()
      End Function        
          
		  'Tạo nội dung XML theo toàn bộ các trường với thẻ Insert
      Protected Friend Shared Function InsertObject(<xsl:apply-templates select="entity/columns" mode="InsertObjectParam"/>) As String
          Dim kq As New StringBuilder()
          kq.Append(AuditTag.BeginInsertTag)
          <xsl:apply-templates select="entity/columns" mode="InsertObjectContent"/>
          kq.Append(AuditTag.EndInsertTag)
          Return kq.ToString()
      End Function        

		  'Tạo nội dung XML theo toàn bộ các trường với thẻ Update
      Protected Friend Shared Function UpdateObject(<xsl:apply-templates select="entity/columns" mode="UpdateObjectParam"/>) As String
          Dim kq As New StringBuilder()
          kq.Append(AuditTag.BeginUpdateTag)
          <xsl:apply-templates select="entity/columns" mode="UpdateObjectContent"/>
          kq.Append(AuditTag.EndUpdateTag)
          Return kq.ToString()
      End Function    
		
		  'Tạo nội dung XML theo bộ key kèm theo thẻ với thẻ Delete
      Protected Friend Shared Function DeleteObject(<xsl:apply-templates select="entity/columns" mode="DeleteObjectParam"/>) As String
          Dim kq As New StringBuilder()
          kq.Append(AuditTag.BeginDeleteTag)
          <xsl:apply-templates select="entity/columns" mode="DeleteObjectContent"/>
          kq.Append(AuditTag.EndDeleteTag)
          Return kq.ToString()
      End Function        		
    End Class
End Namespace

</xsl:template>

<xsl:template match="entity/columns" mode="XMLObjectParam1">
  <xsl:for-each select="property[@isPK='True']">
    <xsl:choose>
      <xsl:when test="position()>1">,</xsl:when>
    </xsl:choose>
    <xsl:value-of select="@columnName"/>
    <xsl:text>	As </xsl:text>
    <xsl:value-of select="@vbDataType"/>
  </xsl:for-each>
</xsl:template>  
<xsl:template match="entity/columns" mode="XMLObjectContent1">
  <xsl:for-each select="property[@isPK='True']">
    <xsl:choose>
      <xsl:when test="position()>1"><xsl:text>
	  </xsl:text></xsl:when>
    </xsl:choose>    
    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
    <xsl:value-of select="@columnName"/><xsl:text>",</xsl:text>
    <xsl:choose>
      <xsl:when test="@vbDataType='string'"><xsl:value-of select="@columnName"/></xsl:when>
      <xsl:when test="@vbDataType='date'"><xsl:value-of select="@columnName"/>.ToString("dd/MM/yyyy")</xsl:when>      
      <xsl:otherwise><xsl:value-of select="@columnName"/>.ToString()</xsl:otherwise>
    </xsl:choose>
    <xsl:text>))</xsl:text>
  </xsl:for-each>
</xsl:template>  	
	
<xsl:template match="entity/columns" mode="XMLObjectParam2">
  <xsl:for-each select="property">
    <xsl:choose>
      <xsl:when test="position()>1">,</xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@vbDataType!='string'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Nullable(Of </xsl:text><xsl:value-of select="@vbDataType"/><xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:when test="@DataType='image'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Byte()</xsl:text>
      </xsl:when>
      <xsl:when test="@DataType='Bigint'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Nullable(Of Long)</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As </xsl:text><xsl:value-of select="@vbDataType"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>  
<xsl:template match="entity/columns" mode="XMLObjectContent2">
  <xsl:for-each select="property">
    <xsl:choose>
      <xsl:when test="position()>1"><xsl:text>
	  </xsl:text></xsl:when>
    </xsl:choose>    
    <xsl:choose>
      <xsl:when test="@vbDataType='string'">
		    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>",</xsl:text><xsl:value-of select="@columnName"/>
		    <xsl:text>))</xsl:text>
	    </xsl:when>      
      <xsl:when test="@DataType='image'">
		    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>",Convert.ToBase64String(</xsl:text><xsl:value-of select="@columnName"/>
		    <xsl:text>)))</xsl:text>
	    </xsl:when>
      <xsl:when test="@vbDataType='date'">
		    <xsl:text>If </xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>.HasValue then
		    </xsl:text>
		    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>",</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>.Value.ToString("dd/MM/yyyy")))</xsl:text>
		    <xsl:text>
		    Else
		    </xsl:text>
		    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>",Nothing))</xsl:text>
		    <xsl:text>
		    EndIf</xsl:text>
	    </xsl:when>		
      <xsl:otherwise>
		    <xsl:text>If </xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>.HasValue then
		    </xsl:text>
		    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>",</xsl:text>
		    <xsl:value-of select="@columnName"/><xsl:text>.Value.ToString()))</xsl:text>
        <xsl:text>
		    Else
		    </xsl:text>
		    <xsl:text>  kq.Append(PrepareAuditBase.CreateXMLElement("</xsl:text>
		    <xsl:value-of select="@columnName"/>
		    <xsl:text>",Nothing))</xsl:text>
		    <xsl:text>
		    EndIf</xsl:text>		      
	  </xsl:otherwise>
    </xsl:choose>    
  </xsl:for-each>
</xsl:template>  
	
	
<xsl:template match="entity/columns" mode="ObjectKeyParam">
  <xsl:for-each select="property[@isPK='True']">
    <xsl:choose>
      <xsl:when test="position()>1">,</xsl:when>
    </xsl:choose>
    <xsl:value-of select="@columnName"/>
    <xsl:text>	As </xsl:text>
    <xsl:value-of select="@vbDataType"/>
  </xsl:for-each>
</xsl:template>  
<xsl:template match="entity/columns" mode="ObjectKeyContent">
  <xsl:text>kq.Append(XMLObject(</xsl:text>
  <xsl:for-each select="property[@isPK='True']">	  
	  <xsl:choose>
		  <xsl:when test="position()>1"><xsl:text>,</xsl:text></xsl:when>
	  </xsl:choose>
	  <xsl:value-of select="@columnName"/><xsl:text>:=</xsl:text><xsl:value-of select="@columnName"/>
  </xsl:for-each>
  <xsl:text>))</xsl:text>	
</xsl:template>  


<xsl:template match="entity/columns" mode="InsertObjectParam">
  <xsl:for-each select="property">
    <xsl:choose>
      <xsl:when test="position()>1">,</xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@vbDataType!='string'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Nullable(Of </xsl:text><xsl:value-of select="@vbDataType"/><xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:when test="@DataType='image'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Byte()</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As </xsl:text><xsl:value-of select="@vbDataType"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>  
<xsl:template match="entity/columns" mode="InsertObjectContent">
  <xsl:text>kq.Append(XMLObject(</xsl:text>
  <xsl:for-each select="property">	  
	  <xsl:choose>
		  <xsl:when test="position()>1"><xsl:text>,</xsl:text></xsl:when>
	  </xsl:choose>
	  <xsl:value-of select="@columnName"/><xsl:text>:=</xsl:text><xsl:value-of select="@columnName"/>
  </xsl:for-each>
  <xsl:text>))</xsl:text>
</xsl:template>  
  
<xsl:template match="entity/columns" mode="UpdateObjectParam">
  <xsl:for-each select="property">
    <xsl:choose>
      <xsl:when test="position()>1">,</xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@vbDataType!='string'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Nullable(Of </xsl:text><xsl:value-of select="@vbDataType"/><xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:when test="@DataType='image'">
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As Byte()</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>ByVal </xsl:text><xsl:value-of select="@columnName"/><xsl:text> As </xsl:text><xsl:value-of select="@vbDataType"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>  
<xsl:template match="entity/columns" mode="UpdateObjectContent">
  <xsl:text>kq.Append(XMLObject(</xsl:text>
  <xsl:for-each select="property">	  
	  <xsl:choose>
		  <xsl:when test="position()>1"><xsl:text>,</xsl:text></xsl:when>
	  </xsl:choose>
	  <xsl:value-of select="@columnName"/><xsl:text>:=</xsl:text><xsl:value-of select="@columnName"/>
  </xsl:for-each>
  <xsl:text>))</xsl:text>
</xsl:template>  

<xsl:template match="entity/columns" mode="DeleteObjectParam">
  <xsl:for-each select="property[@isPK='True']">
    <xsl:choose>
      <xsl:when test="position()>1">,</xsl:when>
    </xsl:choose>
    <xsl:value-of select="@columnName"/>
    <xsl:text>	As </xsl:text>
    <xsl:value-of select="@vbDataType"/>
  </xsl:for-each>
</xsl:template>  
<xsl:template match="entity/columns" mode="DeleteObjectContent">
  <xsl:text>kq.Append(XMLObject(</xsl:text>
  <xsl:for-each select="property[@isPK='True']">	  
	  <xsl:choose>
		  <xsl:when test="position()>1"><xsl:text>,</xsl:text></xsl:when>
	  </xsl:choose>
	  <xsl:value-of select="@columnName"/><xsl:text>:=</xsl:text><xsl:value-of select="@columnName"/>
  </xsl:for-each>
  <xsl:text>))</xsl:text>	
</xsl:template>	
</xsl:stylesheet>
