<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
-- =============================================
-- This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
-- a freeware developed by bibi.
-- Template: DBScripts.xslt 17/10/2006
-- Author:	<xsl:value-of select="entity/@author"/>
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE <xsl:value-of select="entity/@tableName"/>_Update<xsl:apply-templates select="entity/columns" mode="Update"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="Update"/>
END

GO

-- =============================================
-- This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
-- a freeware develop by bibi.
-- Template: DBScripts.xslt 17/10/2006
-- Author:	<xsl:value-of select="entity/@author"/>
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE <xsl:value-of select="entity/@tableName"/>_Delete<xsl:apply-templates select="entity/columns" mode="Delete"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="Delete"/>
END

GO

-- =============================================
-- This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
-- a freeware develop by bibi.
-- Template: DBScripts.xslt 17/10/2006
-- Author:	<xsl:value-of select="entity/@author"/>
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE <xsl:value-of select="entity/@tableName"/>_Insert<xsl:apply-templates select="entity/columns" mode="Insert"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="Insert"/>
END

GO

-- =============================================
-- This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
-- a freeware develop by bibi.
-- Template: DBScripts.xslt 17/10/2006
-- Author:	<xsl:value-of select="entity/@author"/>
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE <xsl:value-of select="entity/@tableName"/>_Search<xsl:apply-templates select="entity/columns" mode="Insert"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="SearchItem"/>
END

GO
-- =============================================
-- This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
-- a freeware develop by bibi.
-- Template: DBScripts.xslt 17/10/2006
-- Author:	<xsl:value-of select="entity/@author"/>
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE <xsl:value-of select="entity/@tableName"/>_SelectItem<xsl:apply-templates select="entity/columns" mode="Delete"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="SelectItem"/>
END

GO

-- =============================================
-- This stored procedure is generated by BuildProject <xsl:value-of select="entity/@BuildProject"/>, 
-- a freeware develop by bibi.
-- Template: DBScripts.xslt 17/10/2006
-- Author:	<xsl:value-of select="entity/@author"/>
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE <xsl:value-of select="entity/@tableName"/>_SelectAllItems
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="SelectAllItems"/>
END

GO

	<xsl:apply-templates select="entity" mode="SelectBy"/>

</xsl:template>

<!--danh sach tham so cho delete-->
<xsl:template match="entity/columns" mode="Delete">
	<xsl:for-each select="property[@isPK='True']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
		<xsl:when test="position()>1">,</xsl:when>
		</xsl:choose>@<xsl:value-of select="@columnName"/>
		<xsl:text>	</xsl:text>
		<xsl:value-of select="@dataType"/>
		<xsl:if test="@length!=0">(<xsl:value-of select="@length"/>)</xsl:if>
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho insert-->
<xsl:template match="entity/columns" mode="Insert">
	<xsl:for-each select="property[@isIdentity='False']">
		<xsl:if test="@isIdentity='False'">
			<xsl:text>
			</xsl:text>
			<xsl:choose>
			<xsl:when test="position()>1">,</xsl:when>
			</xsl:choose>@<xsl:value-of select="@columnName"/>
			<xsl:text>	</xsl:text>
			<xsl:value-of select="@dataType"/>
			<xsl:if test="@length!=0">(<xsl:value-of select="@length"/>)</xsl:if>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<!--danh sach tham so cho update-->
<xsl:template match="entity/columns" mode="Update">
	<xsl:for-each select="property[@isIdentity='False' or @isPK='True']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
		<xsl:when test="position()>1">,</xsl:when>
		</xsl:choose>@<xsl:value-of select="@columnName"/>
		<xsl:text>	</xsl:text>
		<xsl:value-of select="@dataType"/>
		<xsl:if test="@length!=0">(<xsl:value-of select="@length"/>)</xsl:if>
	</xsl:for-each>
</xsl:template>

<!--Cau lenh update-->
<xsl:template match="entity" mode="Update">
	<xsl:if test="count(./columns/property[@isPK='False'])!=0">
		<xsl:text>
	UPDATE [</xsl:text>
		<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>
			<xsl:text>].[</xsl:text>
		</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]	SET</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='False' and @isIdentity='False']">
				<xsl:text>
		</xsl:text>
				<xsl:choose>
					<xsl:when test="position()>1">,</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>] 	= @</xsl:text>
				<xsl:value-of select="@columnName"/>
		</xsl:for-each>
		<xsl:text>
	WHERE </xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
				<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>] 	= @</xsl:text>
				<xsl:value-of select="@columnName"/>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
	</xsl:if>
</xsl:template>

<!--Cau lenh Insert-->
<xsl:template match="entity" mode="Insert">
	Insert Into [<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>](</xsl:text>
		<xsl:for-each select="./columns/property[@isIdentity='False']">
				<xsl:choose>
			<xsl:when test="position()>1">,</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>]</xsl:text>
				<xsl:text>
				</xsl:text>
		</xsl:for-each>)
		<xsl:text>
	Values	(</xsl:text>
		<xsl:for-each select="./columns/property[@isIdentity='False']">
				<xsl:choose>
				<xsl:when test="position()>1">,</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			<xsl:text>@</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>
				</xsl:text>
		</xsl:for-each>)
</xsl:template>

<!--Cau lenh Delete-->
<xsl:template match="entity" mode="Delete">
	Delete [<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]
	Where</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
			<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>] 	= @</xsl:text>
				<xsl:value-of select="@columnName"/>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>

<!--Cau lenh Search-->
<xsl:template match="entity" mode="SearchItem">
	Select 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>]</xsl:text>
		</xsl:for-each>
	From	[<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]
	Where</xsl:text>
		<xsl:for-each select="./columns/property[@isIdentity='False']">
			<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text>(@</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text> is null or [</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>] 	</xsl:text>
				<xsl:choose>
				<xsl:when test="@dataType='int'">= @</xsl:when>
				<xsl:when test="@dataType='decimal'">= @</xsl:when>
				<xsl:when test="@dataType='datetime'">= @</xsl:when>
				<xsl:when test="@dataType='numeric'">= @</xsl:when>
					<xsl:otherwise>
						<xsl:text>like '%' + @</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="@columnName"/>
				<xsl:choose>
				<xsl:when test="@dataType='int'">)</xsl:when>
				<xsl:when test="@dataType='decimal'">)</xsl:when>
				<xsl:when test="@dataType='datetime'">)</xsl:when>
				<xsl:when test="@dataType='numeric'">)</xsl:when>
					<xsl:otherwise>
						<xsl:text>+ '%')</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>
<!--Cau lenh Select-->
<xsl:template match="entity" mode="SelectItem">
	Select 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>]</xsl:text>
		</xsl:for-each>
	From	[<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]
	Where</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
			<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>] 	= @</xsl:text>
				<xsl:value-of select="@columnName"/>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>

<!--Cau lenh SelectAllItems-->
<xsl:template match="entity" mode="SelectAllItems">
	Select 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>]</xsl:text>
		</xsl:for-each>
	From	[<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]
	Order by </xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']"><xsl:if test="position()>1">, </xsl:if>[<xsl:value-of select="@columnName"/>]</xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>

<!--Cac sp SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:variable name="spprefix" select="@spprefix"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
CREATE PROCEDURE <xsl:value-of select="$tablename"/>_SelectBy<xsl:value-of select="@columnName"/>
		@<xsl:value-of select="@columnName"/><xsl:text>	</xsl:text><xsl:value-of select="@dataType"/>
AS
BEGIN
	SET NOCOUNT ON;
<xsl:apply-templates select="/entity" mode="SelectClause"/>	Where	<xsl:value-of select="@columnName"/>	= @<xsl:value-of select="@columnName"/>
END

GO
	</xsl:for-each>
</xsl:template>

<!--Menh de Select-->
<xsl:template match="entity" mode="SelectClause">
	Select 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>]</xsl:text>
		</xsl:for-each>
	From	[<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>]
</xsl:template>

</xsl:stylesheet>
