<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
/*=============================================
Author:	<xsl:value-of select="entity/@author"/>
Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
Description:	
============================================ */

CREATE OR REPLACE PACKAGE <xsl:value-of select="entity/@OraclePackage"/> AS
FUNCTION fn_insert_update (p_action VARCHAR, <xsl:apply-templates select="entity/columns" mode="Insert"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>) RETURN VARCHAR;

FUNCTION fn_delete(<xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>)
RETURN VARCHAR;

FUNCTION fn_search (p_rowindex integer, 
		p_pagesize integer, <xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>) RETURN TYPES.ref_cursor;

FUNCTION fn_get (<xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>) RETURN types.ref_cursor;
<xsl:apply-templates select="entity" mode="SelectBy"/>

END <xsl:value-of select="entity/@OraclePackage"/>;

</xsl:template>
<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
<!--danh sach tham so cho DELETE-->
<xsl:template match="entity/columns" mode="Delete">
	<xsl:param name="tableName"></xsl:param>
	<xsl:for-each select="property[@isPK='True']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
		<xsl:when test="position()>1">,</xsl:when>
		</xsl:choose>p_<xsl:value-of select="@columnName"/>
		<xsl:text>	</xsl:text>
		<xsl:value-of select="$tableName"/>.<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/><xsl:text>%TYPE</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho INSERT, UPDATE-->
<xsl:template match="entity/columns" mode="Insert">
	<xsl:param name="tableName"></xsl:param>
	<xsl:for-each select="property[@isIdentity='False']">
		<xsl:if test="@isIdentity='False'">
			<xsl:text>
			</xsl:text>
			<xsl:choose>
			<xsl:when test="position()>1">,</xsl:when>
			</xsl:choose>p_<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
			<xsl:text>	</xsl:text>
			<xsl:value-of select="$tableName"/>.<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/><xsl:text>%TYPE</xsl:text>
		</xsl:if>
	</xsl:for-each>
</xsl:template>
<!--danh sach tham so cho SEARCH-->
<xsl:template match="entity/columns" mode="SEARCH">
	<xsl:param name="tableName"></xsl:param>
	<xsl:for-each select="property[@isPK='True']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
		<xsl:when test="position()>1">,</xsl:when>
		</xsl:choose>p_<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		<xsl:text>	</xsl:text>
		<xsl:value-of select="$tableName"/>.<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/><xsl:text>%TYPE</xsl:text>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>

