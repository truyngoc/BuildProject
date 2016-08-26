<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">
	
-- ============================================= 
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE GTT_<xsl:value-of select="entity/@tableName"/>_Insert
		<xsl:apply-templates select="entity/columns" mode="InsertParam"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="InsertContent"/>
END

GO

-- =============================================
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE GTT_<xsl:value-of select="entity/@tableName"/>_Update
		<xsl:apply-templates select="entity/columns" mode="UpdateParam"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="UpdateContent"/>
END

GO

-- =============================================
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE GTT_<xsl:value-of select="entity/@tableName"/>_Delete
		<xsl:apply-templates select="entity/columns" mode="DeleteParam"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="DeleteContent"/>
END

GO

-- =============================================
-- Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
-- Description:	
-- Revise History:	
-- =============================================
CREATE PROCEDURE GTT_<xsl:value-of select="entity/@tableName"/>_Search
		<xsl:apply-templates select="entity/columns" mode="SearchParam"/>
AS
BEGIN
	SET NOCOUNT ON;
		<xsl:apply-templates select="entity" mode="SearchContent"/>
END

GO

</xsl:template>

<!--danh sach tham so cho delete-->
<xsl:template match="entity/columns" mode="DeleteParam">
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
<xsl:template match="entity" mode="DeleteContent">
	Delete [<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>].[</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]
	Where</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='True']">
			<xsl:text>
		</xsl:text>
				<xsl:if test="position()>1">AND </xsl:if>
				<xsl:text>(@</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>is NULL or </xsl:text>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>] = @</xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text>)</xsl:text>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
</xsl:template>
	
	
<!--danh sach tham so cho insert-->
<xsl:template match="entity/columns" mode="InsertParam">
	<xsl:for-each select="property">
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
		<xsl:if test="@isIdentity='True'">
			<xsl:text>
			</xsl:text>
			<xsl:choose>
				<xsl:when test="position()>1">,</xsl:when>
			</xsl:choose>@<xsl:value-of select="@columnName"/>
			<xsl:text>	</xsl:text>
			<xsl:value-of select="@dataType"/>
			<xsl:text>	output</xsl:text>
		</xsl:if>
	</xsl:for-each>
</xsl:template>
	
<xsl:template match="entity" mode="InsertContent">
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
	<xsl:for-each select="./columns/property[@isIdentity='True']">
		select @<xsl:value-of select="@columnName"/>=SCOPE_IDENTITY()
	</xsl:for-each>
	
</xsl:template>
	
<!--danh sach tham so cho update-->
<xsl:template match="entity/columns" mode="UpdateParam">
	<xsl:for-each select="property[@dataType!='image']">
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

<xsl:template match="entity" mode="UpdateContent">
	<xsl:if test="count(./columns/property[@isPK='False'])!=0">
		<xsl:text>
	UPDATE [</xsl:text>
		<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>
			<xsl:text>].[</xsl:text>
		</xsl:if>
		<xsl:value-of select="@tableName"/>
		<xsl:text>]	
	SET</xsl:text>
		<xsl:for-each select="./columns/property[@isPK='False' and @isIdentity='False' and @dataType!='image']">
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
			<xsl:text>] = @</xsl:text>
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
			<xsl:text>] = @</xsl:text>
			<xsl:value-of select="@columnName"/>
		</xsl:for-each>
		<xsl:text>
		</xsl:text>
	</xsl:if>
</xsl:template>

<!--danh sach tham so cho Search-->
<xsl:template match="entity/columns" mode="SearchParam">
	<xsl:for-each select="property[@dataType!='image']">
		<xsl:text>
		</xsl:text>
		<xsl:choose>
			<xsl:when test="position()>1">, </xsl:when>			
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@vbDataType='date'">@<xsl:value-of select="@columnName"/>_FROM<xsl:text> </xsl:text><xsl:value-of select="@dataType"/><xsl:if test="@length!=0">(<xsl:value-of select="@length"/>)</xsl:if>
				, @<xsl:value-of select="@columnName"/>_TO<xsl:text> </xsl:text><xsl:value-of select="@dataType"/><xsl:if test="@length!=0">(<xsl:value-of select="@length"/>)</xsl:if>
			</xsl:when>
			<xsl:otherwise>@<xsl:value-of select="@columnName"/><xsl:text> </xsl:text><xsl:value-of select="@dataType"/><xsl:if test="@length!=0">(<xsl:value-of select="@length"/>)</xsl:if>				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
</xsl:template>

<xsl:template match="entity/columns" mode="SearchContent">	
		<xsl:text>
	SELECT	</xsl:text>
		<xsl:for-each select="property">
			<xsl:choose>
				<xsl:when test="position()>1">
					, </xsl:when>
			</xsl:choose>
			<xsl:value-of select="@columnName"/>
		</xsl:for-each>			
		<xsl:text>
	FROM [</xsl:text>
		<xsl:if test="@schema!=''">
			<xsl:value-of select="@schema"/>
			<xsl:text>].[</xsl:text>
		</xsl:if>
		<xsl:value-of select="entity/@tableName"/>
		<xsl:text>]
	WHERE </xsl:text>
	<xsl:for-each select="property">
		<xsl:text>
		</xsl:text>
		<xsl:if test="position()>1">AND </xsl:if>
		<xsl:text>(@</xsl:text>
		<xsl:value-of select="@columnName"/>
		<xsl:text> is NULL or </xsl:text>
		<xsl:text>[</xsl:text>
		<xsl:value-of select="@columnName"/>
		<xsl:text>] = @</xsl:text>
		<xsl:value-of select="@columnName"/>
		<xsl:text>)</xsl:text>
	</xsl:for-each>
	<xsl:text>
		</xsl:text>
</xsl:template>	
</xsl:stylesheet>
