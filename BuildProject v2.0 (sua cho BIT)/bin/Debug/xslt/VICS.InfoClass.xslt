<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">

Public class <xsl:value-of select="entity/@tableName"/>_Obj	
	<xsl:apply-templates select="entity/columns" mode="Property"/>
End Class

</xsl:template>

<!--danh sach property-->
<xsl:template match="entity/columns" mode="Property">
	<xsl:for-each select="property">
	Public Property <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/><!--<xsl:if test="@allowNull='True'">?</xsl:if>-->
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
