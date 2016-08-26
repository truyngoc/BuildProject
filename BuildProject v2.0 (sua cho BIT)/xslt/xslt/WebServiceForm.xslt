<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
&lt;%@ WebService Language="vb" Codebehind="<xsl:value-of select="entity/@tableName"/>_WS.asmx.vb" Class="<xsl:value-of select="entity/@webservicename"/>.<xsl:value-of select="entity/@tableName"/>_WS" %&gt;
</xsl:template>
</xsl:stylesheet>
