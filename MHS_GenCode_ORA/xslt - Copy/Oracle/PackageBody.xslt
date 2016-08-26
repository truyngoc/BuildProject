<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
	
/*=============================================
Author:	<xsl:value-of select="entity/@author"/>
Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
Description:	
Revise History:	
============================================ */

CREATE OR REPLACE PACKAGE BODY <xsl:value-of select="entity/@OraclePackage"/> AS

FUNCTION fn_insert_update(p_action VARCHAR, <xsl:apply-templates select="entity/columns" mode="Insert">
																<xsl:with-param name="tableName">
																		<xsl:value-of select="entity/@tableName"/>
																</xsl:with-param>
															</xsl:apply-templates>)
		RETURN VARCHAR
AS
	v_count   NUMBER;
BEGIN 
	IF p_action = 'I' THEN
		<xsl:apply-templates select="entity" mode="Insert"/>
	ELSE 
		IF p_action = 'U' THEN
			<xsl:apply-templates select="entity" mode="Update"/>
		END IF;
	END IF;
	RETURN NULL;
			RETURN NULL;
		EXCEPTION
			WHEN OTHERS
			THEN
			RETURN SQLERRM;
END;

FUNCTION fn_delete(<xsl:apply-templates select="entity/columns" mode="Delete">
																<xsl:with-param name="tableName">
																	<xsl:value-of select="entity/@tableName"/>
																</xsl:with-param>
															</xsl:apply-templates>)
					RETURN VARCHAR
AS
BEGIN

		<xsl:apply-templates select="entity" mode="Delete"/>;
				RETURN NULL;
		EXCEPTION
			WHEN OTHERS
			THEN
			RETURN SQLERRM;
		
END;

FUNCTION fn_get(<xsl:apply-templates select="entity/columns" mode="Delete">
																	<xsl:with-param name="tableName">
																		<xsl:value-of select="entity/@tableName"/>
																	</xsl:with-param>
																</xsl:apply-templates>)
		RETURN TYPES.ref_cursor
AS
	v_cursor TYPES.ref_cursor;
BEGIN
	OPEN v_cursor FOR
		<xsl:apply-templates select="entity" mode="SelectItem"/>
	RETURN v_cursor;
END ;

FUNCTION fn_search (p_rowindex integer 
		, p_pagesize integer  
		, <xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>) 
		RETURN TYPES.ref_cursor
AS
	v_cursor   TYPES.ref_cursor;
BEGIN 
	OPEN v_cursor FOR
		<xsl:apply-templates select="entity" mode="SEARCH"/>
	RETURN v_cursor;
END;
	
END <xsl:value-of select="entity/@OraclePackage"/>;

</xsl:template>
<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
<!--danh sach tham so cho delete-->
<xsl:template match="entity/columns" mode="Delete">
	<xsl:param name="tableName"></xsl:param>
	<xsl:for-each select="property[@isPK='True']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
		<xsl:when test="position()>1">,</xsl:when>
		</xsl:choose>p_<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		<xsl:text>	</xsl:text>
		<xsl:value-of select="$tableName"/>.<xsl:value-of select="@columnName"/><xsl:text>%TYPE</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho insert-->
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
			<xsl:value-of select="$tableName"/>.<xsl:value-of select="@columnName"/><xsl:text>%TYPE</xsl:text>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho update-->
<xsl:template match="entity/columns" mode="Update">
	<xsl:param name="tableName"></xsl:param>
	<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
		<xsl:when test="position()>1">,</xsl:when>
		</xsl:choose>p_<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		<xsl:text>	</xsl:text>
		<xsl:value-of select="$tableName"/>.<xsl:value-of select="@columnName"/><xsl:text>%TYPE</xsl:text>
	</xsl:for-each>
</xsl:template>

<!--Cau lenh update-->
<xsl:template match="entity" mode="Update">
	<xsl:if test="count(./columns/property[@isPK='False'])!=0">
		<xsl:text>
	UPDATE </xsl:text>
		<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>
			<xsl:text>.</xsl:text>
		</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>	SET</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='False' and @isIdentity='False']">
				<xsl:text>
		</xsl:text>
				<xsl:choose>
					<xsl:when test="position()>1">,</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text> 	= p_</xsl:text>
				<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		</xsl:for-each>
		<xsl:text>
	WHERE </xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
				<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text> 	= p_</xsl:text>
				<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		</xsl:for-each>
		<xsl:text>;
		</xsl:text>
	</xsl:if>
</xsl:template>

<!--Cau lenh Insert-->
<xsl:template match="entity" mode="Insert">
	INSERT INTO <xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>.</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>(</xsl:text>
		<xsl:for-each select="./columns/property[@isIdentity='False']">
				<xsl:choose>
			<xsl:when test="position()>1">,</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text></xsl:text>
				<xsl:text>
				</xsl:text>
		</xsl:for-each>)
		<xsl:text>
	VALUES	(</xsl:text>
		<xsl:for-each select="./columns/property[@isIdentity='False']">
				<xsl:choose>
				<xsl:when test="position()>1">,</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			<xsl:text>p_</xsl:text>
				<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
				<xsl:text>
				</xsl:text>
		</xsl:for-each>);
</xsl:template>

<!--Cau lenh Delete-->
<xsl:template match="entity" mode="Delete">
	DELETE <xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>.</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>
	WHERE</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
			<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text> 	= p_</xsl:text>
				<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>

<!--Cau lenh Select-->
<xsl:template match="entity" mode="SEARCH">
    SELECT *
    FROM (SELECT COUNT (*) OVER () AS ROWCOUNT,
                     ROW_NUMBER () OVER (ORDER BY 	<xsl:for-each select="./columns/property[@isPK='True']">
														<xsl:if test="position()>1">, </xsl:if>
														<xsl:value-of select="@columnName"/>
													</xsl:for-each>) AS rnum, 
													<xsl:for-each select="./columns/property">
														<xsl:if test="position()>1">
														, </xsl:if>
														<xsl:text></xsl:text>
														<xsl:value-of select="@columnName"/>
														<xsl:text></xsl:text>
													</xsl:for-each>
              FROM <xsl:value-of select="@tableName"/> u
			  WHERE <xsl:for-each select="./columns/property[@isPK='True']">
				<xsl:if test="position()>1">AND </xsl:if>
				(<xsl:text>p_</xsl:text><xsl:value-of select="translate(@columnName, $uppercase, $smallcase)" />
				<xsl:text> IS NULL OR </xsl:text>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text> = p_</xsl:text><xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>)
		</xsl:for-each>)
	WHERE rnum BETWEEN p_rowindex + 1 AND p_rowindex + p_pagesize;
		<xsl:text>
		</xsl:text>
</xsl:template>
<xsl:template match="entity" mode="SelectItem">
	SELECT 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text></xsl:text>
		</xsl:for-each>
	FROM	<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>.</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>
	WHERE</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
			<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text> 	= p_</xsl:text>
				<xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
		</xsl:for-each>;
		<xsl:text>
		</xsl:text>
</xsl:template>

<!--Cau lenh SelectAllItems-->
<xsl:template match="entity" mode="SelectAllItems">
	SELECT 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text></xsl:text>
		</xsl:for-each>
	FROM	<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>.</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>
	ORDER BY </xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']"><xsl:if test="position()>1">, </xsl:if><xsl:value-of select="@columnName"/></xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>

<!--Cac sp SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:variable name="spprefix" select="@spprefix"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
PROCEDURE <xsl:value-of select="$tablename"/>_SelectBy<xsl:value-of select="@columnName"/>(
		p<xsl:value-of select="@columnName"/><xsl:text>	</xsl:text><xsl:value-of select="@dataType"/>,
		cur OUT curRS)
AS
BEGIN
	OPEN cur FOR
	<xsl:apply-templates select="/entity" mode="SelectClause"/>	Where	<xsl:value-of select="@columnName"/>	= p<xsl:value-of select="@columnName"/>;
END <xsl:value-of select="$tablename"/>_SelectBy<xsl:value-of select="@columnName"/>;

	</xsl:for-each>
	
</xsl:template>

</xsl:stylesheet>
