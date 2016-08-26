<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">
'' =============================================
'' Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
'' Description:	The methods working with database of  <xsl:value-of select="entity/@tableName"/> object
'' Revise History:
'' =============================================

Imports THUEXNK.COMMON
Imports THUEXNK.MHS.INFO
Imports THUEXNK.MHS.DAO
Imports THUEXNK.COMMON.TableExtender
Imports Oracle.DataAccess.Client

Public Class <xsl:value-of select="entity/@tableName"/>_DAO
    Inherits DataBaseMHS
#Region "Insert"
    Public Sub InsertItem( ByVal obj As <xsl:value-of select="entity/@tableName"/>_INFO)
		  Try <xsl:apply-templates select="entity/columns" mode="InsertItemOutPutDeclare"/>
      OracleHelper.ExecuteNonQueryFunction(Me.Transaction _
          ,"PKG_<xsl:value-of select="entity/@tableName"/>.fn_insert_update" _
        <xsl:apply-templates select="entity/columns" mode="InsertItemSql"/>)
			  <xsl:apply-templates select="entity/columns" mode="InsertItemOutPutSet"/>
		  Catch ex As Exception
			  Throw New Common.AppException(ex)
		  End Try
	End Sub
#End Region

#Region "Select"
    Public Function SelectItems(ByVal obj As <xsl:value-of select="entity/@tableName"/>_INFO) As DataSet
		Try
			Return OracleHelper.ExecuteDataSet(Me.Connection, CommandType.StoredProcedure _
					, "PKG_<xsl:value-of select="entity/@tableName"/>.fn_get" _
					 <xsl:apply-templates select="entity/columns" mode="SelectItemsSql"/>)
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Function
#End Region

#Region "Delete"	
    Public Sub DeleteItems( <xsl:apply-templates select="entity/columns" mode="DeleteItemsParam"/>)
    Try
        OracleHelper.ExecuteNonQueryFunction(Me.Transaction _
            ,"PKG_<xsl:value-of select="entity/@tableName"/>.fn_delete" _
					 <xsl:apply-templates select="entity/columns" mode="DeleteItemsSql"/>)
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Sub	
#End Region	

#Region "Update"
	Public Sub UpdateItem( ByVal obj As <xsl:value-of select="entity/@tableName"/>_INFO)
    Try
    OracleHelper.ExecuteNonQueryFunction(Me.Transaction _
      ,"PKG_<xsl:value-of select="entity/@tableName"/>.fn_insert_update" _
    <xsl:apply-templates select="entity/columns" mode="UpdateItemSql"/>)
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try
	End Sub
#End Region	
	
End Class

</xsl:template>

	<!--danh sach tham so cho SelectItems-->
	<!--<xsl:template match="entity/columns" mode="SelectItemsParam">
		<xsl:for-each select="property[@dataType!='image']">
			<xsl:choose>
				<xsl:when test="position()>1">,</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="@vbDataType='string'">ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/> _
				</xsl:when>
				<xsl:when test="@vbDataType='date'">ByVal <xsl:value-of select="@columnName"/>_FROM as Nullable(Of <xsl:value-of select="@vbDataType"/>) _
					, ByVal <xsl:value-of select="@columnName"/>_TO as Nullable(Of <xsl:value-of select="@vbDataType"/>) _
				</xsl:when>
				<xsl:otherwise>ByVal <xsl:value-of select="@columnName"/> as Nullable(Of <xsl:value-of select="@vbDataType"/>) _
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>-->
<xsl:template match="entity/columns" mode="SelectItemsSql">,New OracleParameter("v_result", OracleDbType.RefCursor, ParameterDirection.ReturnValue) _
    <xsl:for-each select="property[@dataType!='image']">
			<xsl:choose>
				<xsl:when test="@vbDataType='string'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>", OracleDbType.<xsl:value-of select="@dataType"/>, IIf(String.IsNullOrEmpty(obj.<xsl:value-of select="@columnName"/>), DBNull.Value, obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
        </xsl:when>				
				<xsl:when test="@dataType='DATE'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>_FROM", OracleDbType.<xsl:value-of select="@dataType"/>, IIf(obj.<xsl:value-of select="@columnName"/>_FROM Is Nothing, DBNull.Value, obj.<xsl:value-of select="@columnName"/>_FROM),ParameterDirection.Input) _
          ,New OracleParameter("p_<xsl:value-of select="@columnName"/>_TO", OracleDbType.<xsl:value-of select="@dataType"/>, IIf(obj.<xsl:value-of select="@columnName"/>_TO Is Nothing, DBNull.Value, obj.<xsl:value-of select="@columnName"/>_TO),ParameterDirection.Input) _
        </xsl:when>
        <xsl:when test="@dataType='NUMBER'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.Int32,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
      </xsl:when>
				<xsl:otherwise>,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.<xsl:value-of select="@dataType"/>, IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing, DBNull.Value, obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
        </xsl:otherwise>				
			</xsl:choose>			
		</xsl:for-each>
	</xsl:template>

	<!--danh sach tham so cho UpdateItem-->
	<xsl:template match="entity/columns" mode="UpdateItemSql">  ,New OracleParameter("p_action", OracleDbType.Varchar2, "I", ParameterDirection.Input) _
    <xsl:for-each select="property[@dataType!='image']">
			<xsl:choose>
        <xsl:when test="@dataType='NUMBER'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.Int32,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
        </xsl:when>
        <xsl:when test="@vbDataType='string'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.<xsl:value-of select="@dataType"/>,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
        </xsl:when>
       <!--<xsl:when test="@allowNull='False' and @isIdentity='False'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.<xsl:value-of select="@dataType"/>,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
       </xsl:when>-->
			<xsl:otherwise>,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.<xsl:value-of select="@dataType"/>,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
        <!--<xsl:choose>-->
          <!--<xsl:when test="@allowNull='False' and @isIdentity='False'">-->
       <!--</xsl:when>-->
					<!--<xsl:otherwise>,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing</xsl:otherwise>-->
				<!--</xsl:choose>-->
          <!--, DBNull.Value, obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _-->
       </xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--danh sach tham so cho DeleteItems-->
	<xsl:template match="entity/columns" mode="DeleteItemsParam">
		<xsl:for-each select="property[@isPK='True']">
			<xsl:choose>
				<xsl:when test="position()>1">, </xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="@vbDataType='string'">ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/> _
				</xsl:when>
				<xsl:otherwise>ByVal <xsl:value-of select="@columnName"/> as Nullable(Of <xsl:value-of select="@vbDataType"/>) _
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="entity/columns" mode="DeleteItemsSql">
		<xsl:for-each select="property[@isPK='True']">
      <xsl:choose>
      <xsl:when test="@dataType='NUMBER'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.Int32,IIf(<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
      </xsl:when>
      <xsl:otherwise>,New OracleParameter("p_<xsl:value-of select="@columnName"/>", OracleDbType.<xsl:value-of select="@dataType"/>,IIf(<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
      </xsl:otherwise>
      </xsl:choose>
      <!--<xsl:choose>
				<xsl:when test="@vbDataType='string'">,IIf(String.IsNullOrEmpty(<xsl:value-of select="@columnName"/>)</xsl:when>
				<xsl:otherwise>,IIf(<xsl:value-of select="@columnName"/> Is Nothing</xsl:otherwise>
			</xsl:choose>, DBNull.Value, <xsl:value-of select="@columnName"/>)) _-->
		</xsl:for-each>
	</xsl:template>
	
	<!--danh sach tham so cho insert-->
	<xsl:template match="entity/columns" mode="InsertItemOutPutDeclare">
		<xsl:for-each select="property">
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="entity/columns" mode="InsertItemSql"> ,New OracleParameter("p_action", OracleDbType.Varchar2, "I", ParameterDirection.Input) _
      <!--,New OracleParameter("p_id",OracleDbType.Int32,"<xsl:value-of select="@tableName"/>_SQL.Nextval",ParameterDirection.Input) _-->
    <xsl:for-each select="property[@isPK='True']">,New OracleParameter("p_id",OracleDbType.Int32,DBNull.Value,ParameterDirection.Input) _
    </xsl:for-each>
    <xsl:for-each select="property[@isPK='False']">
				<xsl:choose>
					<!--<xsl:when test="@allowNull='False' and @isIdentity='False'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>", OracleDbType.<xsl:value-of select="@dataType"/>,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
          </xsl:when>-->
          <xsl:when test="@dataType='NUMBER'">,New OracleParameter("p_<xsl:value-of select="@columnName"/>",OracleDbType.Int32,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing,DBNull.Value,obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
          </xsl:when>
					<xsl:otherwise>,New OracleParameter("p_<xsl:value-of select="@columnName"/>", OracleDbType.<xsl:value-of select="@dataType"/>
						<xsl:choose>
							<xsl:when test="@dataType='nvarchar' or @dataType='varchar' or @dataType='char' or @dataType='nchar' or @data='ntext' or @data='xml'">,IIf(String.IsNullOrEmpty(obj.<xsl:value-of select="@columnName"/>)</xsl:when>
							<xsl:otherwise>,IIf(obj.<xsl:value-of select="@columnName"/> Is Nothing</xsl:otherwise>
						</xsl:choose>, DBNull.Value, obj.<xsl:value-of select="@columnName"/>),ParameterDirection.Input) _
          </xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
	</xsl:template>
	<xsl:template match="entity/columns" mode="InsertItemOutPutSet">
		<xsl:for-each select="property">
			<xsl:choose>
				<xsl:when test="@isIdentity='True'">					
					obj.<xsl:value-of select="@columnName"/> = outPut_<xsl:value-of select="@columnName"/>.Value
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>



</xsl:stylesheet>
