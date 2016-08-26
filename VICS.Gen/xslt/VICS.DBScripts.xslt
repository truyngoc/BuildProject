<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="UTF-8"/>
	<xsl:template match="/">

CREATE OR REPLACE PACKAGE PKG_<xsl:value-of select="entity/@tableName"/> AS
  TYPE ref_cursor IS REF CURSOR;

  <!--PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_insert_update (p_action VARCHAR, <xsl:apply-templates select="entity/columns" mode="Insert"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>);-->
  
  PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_insert (<xsl:apply-templates select="entity/columns" mode="Insert"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>);
  
  PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_update (<xsl:apply-templates select="entity/columns" mode="Insert"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>);

  PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_delete(<xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>);

<!--PROCEDURE sp_search (p_rowindex integer, 
		p_pagesize integer, <xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>) RETURN ref_cursor;-->

  PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_getItem (<xsl:apply-templates select="entity/columns" mode="GetItem"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>);
      <xsl:apply-templates select="entity" mode="SelectBy"/>
    
  PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_get (<xsl:apply-templates select="entity/columns" mode="Get"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>);
      <xsl:apply-templates select="entity" mode="SelectBy"/>

  PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_checkExist(<xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>, 
  reccount out number);
END PKG_<xsl:value-of select="entity/@tableName"/>;

commit;





CREATE OR REPLACE PACKAGE BODY PKG_<xsl:value-of select="entity/@tableName"/> AS

<!--PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_insert_update(p_action VARCHAR, <xsl:apply-templates select="entity/columns" mode="Insert">
																<xsl:with-param name="tableName">
																		<xsl:value-of select="entity/@tableName"/>
																</xsl:with-param>
															</xsl:apply-templates>)
AS
BEGIN 
	IF p_action = 'I' THEN
	  <xsl:apply-templates select="entity" mode="Insert"/>
	ELSE 
	IF p_action = 'U' THEN
	  <xsl:apply-templates select="entity" mode="Update"/>
    END IF;
    END IF;

    EXCEPTION
    WHEN OTHERS
    THEN
    RAISE_APPLICATION_ERROR (-20001, 'PKG_<xsl:value-of select="entity/@tableName"/>.sp_insert_update '
    || '[Code: '
    || TO_CHAR (SQLCODE)
    || '] '
    || '[Description: '
    || SQLERRM
    || ']'
    );
    END;-->

PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_insert(<xsl:apply-templates select="entity/columns" mode="Insert">
  <xsl:with-param name="tableName">
    <xsl:value-of select="entity/@tableName"/>
  </xsl:with-param>
</xsl:apply-templates>)
AS
BEGIN
  <xsl:apply-templates select="entity" mode="Insert"/>
  
  EXCEPTION
  WHEN OTHERS
  THEN
  RAISE_APPLICATION_ERROR (-20001, 'PKG_<xsl:value-of select="entity/@tableName"/>.sp_insert '
  || '[Code: '
  || TO_CHAR (SQLCODE)
  || '] '
  || '[Description: '
  || SQLERRM
  || ']'
  );
END;

PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_update(<xsl:apply-templates select="entity/columns" mode="Insert">
  <xsl:with-param name="tableName">
    <xsl:value-of select="entity/@tableName"/>
  </xsl:with-param>
</xsl:apply-templates>)
AS
BEGIN
  <xsl:apply-templates select="entity" mode="Update"/>
  
  EXCEPTION
  WHEN OTHERS
  THEN
  RAISE_APPLICATION_ERROR (-20001, 'PKG_<xsl:value-of select="entity/@tableName"/>.sp_update '
  || '[Code: '
  || TO_CHAR (SQLCODE)
  || '] '
  || '[Description: '
  || SQLERRM
  || ']'
  );
END;
    
    
PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_delete(<xsl:apply-templates select="entity/columns" mode="Delete">
										<xsl:with-param name="tableName">
											<xsl:value-of select="entity/@tableName"/>
										</xsl:with-param>
									</xsl:apply-templates>)
AS
BEGIN
		<xsl:apply-templates select="entity" mode="Delete"/>;
    
    EXCEPTION
    WHEN OTHERS
    THEN
    RAISE_APPLICATION_ERROR (-20001, 'PKG_<xsl:value-of select="entity/@tableName"/>.sp_delete '
    || '[Code: '
    || TO_CHAR (SQLCODE)
    || '] '
    || '[Description: '
    || SQLERRM
    || ']'
    );
END;

PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_getItem(<xsl:apply-templates select="entity/columns" mode="GetItem">
																	<xsl:with-param name="tableName">
																		<xsl:value-of select="entity/@tableName"/>
																	</xsl:with-param>
																</xsl:apply-templates>)
AS
BEGIN
	OPEN v_cursor FOR
		<xsl:apply-templates select="entity" mode="SelectItemByPK"/>;
END ;

PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_get(<xsl:apply-templates select="entity/columns" mode="Get">
																	<xsl:with-param name="tableName">
																		<xsl:value-of select="entity/@tableName"/>
																	</xsl:with-param>
																</xsl:apply-templates>)
AS
BEGIN
	OPEN v_cursor FOR
		<xsl:apply-templates select="entity" mode="SelectItem"/>;
END ;

PROCEDURE <xsl:value-of select="translate(entity/@tableName,$uppercase,$smallcase)"/>_checkExist(<xsl:apply-templates select="entity/columns" mode="Delete">
										<xsl:with-param name="tableName">
											<xsl:value-of select="entity/@tableName"/>
										</xsl:with-param>
									</xsl:apply-templates>
    ,reccount out number)
AS
BEGIN
		<xsl:apply-templates select="entity" mode="CheckExist"/>;
    
    EXCEPTION
    WHEN OTHERS
    THEN
    RAISE_APPLICATION_ERROR (-20001, 'PKG_<xsl:value-of select="entity/@tableName"/>.checkExist '
    || '[Code: '
    || TO_CHAR (SQLCODE)
    || '] '
    || '[Description: '
    || SQLERRM
    || ']'
    );
    END;
    <!--PROCEDURE sp_search (p_rowindex integer 
		, p_pagesize integer  
		, <xsl:apply-templates select="entity/columns" mode="Delete"><xsl:with-param name="tableName"><xsl:value-of select="entity/@tableName"/></xsl:with-param></xsl:apply-templates>) 
		RETURN ref_cursor
AS
	v_cursor   ref_cursor;
BEGIN 
	OPEN v_cursor FOR
		<xsl:apply-templates select="entity" mode="SEARCH"/>
	RETURN v_cursor;
END;-->
	
END PKG_<xsl:value-of select="entity/@tableName"/>;
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
	<xsl:for-each select="property[@isPK='False']">
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
<!--<xsl:template match="entity/columns" mode="SEARCH">
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
</xsl:template>-->

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
<!--danh sách tham số cho Get-->
  <xsl:template match="entity/columns" mode="Get">
    <xsl:param name="tableName"></xsl:param>
    <xsl:for-each select="property">
      <xsl:text></xsl:text>
      <xsl:choose>
        <xsl:when test="position()>1">,</xsl:when>
      </xsl:choose>
      p_<xsl:value-of select="translate(@columnName,$uppercase,$smallcase)"/>
      <xsl:text>  </xsl:text>
      <xsl:value-of select="$tableName"/>.<xsl:value-of select="@columnName"/><xsl:text>%TYPE</xsl:text>
    </xsl:for-each>
    ,v_cursor  OUT ref_cursor
  </xsl:template>

  <!--danh sách tham số cho Get Item-->
  <xsl:template match="entity/columns" mode="GetItem">
    <xsl:param name="tableName"></xsl:param>
    <xsl:for-each select="property[@isPK='True']">
      <xsl:text></xsl:text>
      <xsl:choose>
        <xsl:when test="position()>1">,</xsl:when>
      </xsl:choose>
      p_<xsl:value-of select="translate(@columnName,$uppercase,$smallcase)"/>
      <xsl:text>  </xsl:text>
      <xsl:value-of select="$tableName"/>.<xsl:value-of select="@columnName"/><xsl:text>%TYPE</xsl:text>
    </xsl:for-each>
    ,v_cursor  OUT ref_cursor
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
	VALUES	(SEQ_</xsl:text><xsl:value-of select="@tableName"/>.Nextval  
		       ,<xsl:for-each select="./columns/property[@isPK='False']">
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
  <xsl:text>
	FROM </xsl:text>
  <xsl:if test="@schema!=''">
    <xsl:value-of select="@schema"/>
    <xsl:text>.</xsl:text>
  </xsl:if>
  <xsl:value-of select="@tableName"/>
  <xsl:text>
	WHERE </xsl:text>
  <xsl:for-each select="./columns/property">
    <xsl:text>
		</xsl:text>
    <xsl:if test="position()>1">AND </xsl:if>
    <xsl:choose>
      <xsl:when test="@vbDataType='date'">
        <xsl:text>(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text> is NULL or </xsl:text>
        <xsl:text></xsl:text>
        <xsl:value-of select="@columnName"/>
        <xsl:text> &gt;= p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:when test="@vbDataType='string'">
        <xsl:text>(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text> is NULL or </xsl:text>
        <xsl:text>upper(</xsl:text>
        <xsl:value-of select="@columnName"/>
        <xsl:text>)</xsl:text>
        <xsl:text> like '%' || upper(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text>) || '%')</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text> is NULL or </xsl:text>
        <xsl:text></xsl:text>
        <xsl:value-of select="@columnName"/>
        <xsl:text> = p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text>)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
  <xsl:text>
		</xsl:text>
</xsl:template>

<!--Cau lenh Select By PK-->  
<xsl:template match="entity" mode="SelectItemByPK">
	SELECT 		<xsl:for-each select="./columns/property">
				<xsl:if test="position()>1">
				, </xsl:if>
				<xsl:text></xsl:text>
				<xsl:value-of select="@columnName"/>
				<xsl:text></xsl:text>
		</xsl:for-each>
  <xsl:text>
	FROM </xsl:text>
  <xsl:if test="@schema!=''">
    <xsl:value-of select="@schema"/>
    <xsl:text>.</xsl:text>
  </xsl:if>
  <xsl:value-of select="@tableName"/>
  <xsl:text>
	WHERE </xsl:text>
  <xsl:for-each select="./columns/property[@isPK='True']">
    <xsl:text>
		</xsl:text>
    <xsl:if test="position()>1">AND </xsl:if>
    <xsl:choose>
      <xsl:when test="@vbDataType='date'">
        <xsl:text>(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text> is NULL or </xsl:text>
        <xsl:text></xsl:text>
        <xsl:value-of select="@columnName"/>
        <xsl:text> &gt;= p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:when test="@vbDataType='string'">
        <xsl:text>(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text> is NULL or </xsl:text>
        <xsl:text></xsl:text>
        <xsl:value-of select="@columnName"/>
        <xsl:text> like p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>(p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text> is NULL or </xsl:text>
        <xsl:text></xsl:text>
        <xsl:value-of select="@columnName"/>
        <xsl:text> = p_</xsl:text>
        <xsl:value-of select="translate(@columnName, $uppercase, $smallcase)"/>
        <xsl:text>)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
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

  
<!--Cau lenh select for check exist -->
<xsl:template match="entity" mode="CheckExist">
	SELECT COUNT(*) INTO reccount FROM <xsl:if test="@schema!=''">
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
  
</xsl:stylesheet>

