<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dateTimeObj="urn:xsltExtension-DateTime">
	<xsl:output method="text" encoding="UTF-8" media-type="text" />
	<xsl:template match="/">

'' =============================================
'' Create date:	<xsl:value-of select="dateTimeObj:GetDateTime('dd/MM/yyyy HH:mm')" />
'' Description:	The bussiness methods of <xsl:value-of select="entity/@tableName"/> object
'' Revise History:	
'' =============================================
Imports THUEXNK.COMMON
Imports THUEXNK.MHS.DAO
Imports THUEXNK.MHS.INFO
Imports THUEXNK

Public Class <xsl:value-of select="entity/@tableName"/>_BO
    Inherits Base_BO_MHS
    Private Sub KiemTraDieuKienSua( ByVal objData As <xsl:value-of select="entity/@tableName"/>_INFO)

	End Sub

	Private Sub KiemTraDieuKienHuy(<xsl:apply-templates select="entity/columns" mode="DeleteParams"/>)

    End Sub

    Private Sub KiemTraDieuKienThemMoi( ByVal obj As <xsl:value-of select="entity/@tableName"/>_INFO)
		
	End Sub
	
#Region "Select"
	Public Function SelectItems(ByVal obj As <xsl:value-of select="entity/@tableName"></xsl:value-of>_INFO) As List(Of <xsl:value-of select="entity/@tableName"/>_INFO)
		Dim kq As List(Of <xsl:value-of select="entity/@tableName"/>_INFO) = Nothing
    Dim ds As DataSet = Nothing
    Dim da As New <xsl:value-of select="entity/@tableName"/>_DAO With {.Transaction = Transaction}
    ds = da.SelectItems(obj)
    If (ds IsNot Nothing AndAlso ds.Tables.Count > 0) Then kq =CBO.MapDataTableToList(Of <xsl:value-of select="entity/@tableName"/>_Info)(ds.Tables(0))		
		Return kq
	End Function
	
	Public Function SelectItem( <xsl:apply-templates select="entity/columns" mode="SelectItemParam"/>) As <xsl:value-of select="entity/@tableName"/>_INFO
		Dim kq As <xsl:value-of select="entity/@tableName"/>_INFO = Nothing
    Dim obj As New <xsl:value-of select="entity/@tableName"/>_INFO()
    <xsl:apply-templates select="entity/columns" mode="SelectItemSetObject"/>
    <!--<xsl:apply-templates select="entity/columns" mode="SelectItemCallDA"/>-->
		Dim lst As List(Of <xsl:value-of select="entity/@tableName"/>_INFO) = SelectItems(obj)
		If lst Is Nothing OrElse lst.Count = 0 Then
			kq = Nothing
		ElseIf lst.Count = 1 Then
			kq = lst(0)
		Else
			Throw New Exception("Xem lại bộ key của database (bảng <xsl:value-of select="entity/@tableName"/>)")
		End If
		Return kq
	End Function
#End Region

#Region "Insert"
	Public Sub InsertItem( ByVal obj As <xsl:value-of select="entity/@tableName"/>_INFO)
    Try
		  Dim da As New <xsl:value-of select="entity/@tableName"/>_DAO With {.Transaction = Transaction}
      da.InsertItem(obj)
      Commit()
    Catch ex As Exception
      RollBack()
    End Try
  End Sub
#End Region

#Region "Update"
   Public Sub UpdateItem( ByVal obj As <xsl:value-of select="entity/@tableName"/>_INFO)
    Try
		  Dim da As New <xsl:value-of select="entity/@tableName"/>_DAO With {.Transaction = Transaction}
      da.UpdateItem(obj)
      Commit()
    Catch ex As Exception
      RollBack()
    End Try
   End Sub
#End Region

#Region "Delete"
    Public Sub DeleteItem( <xsl:apply-templates select="entity/columns" mode="DeleteItemParam"/>)
      Try
	      Dim da As New <xsl:value-of select="entity/@tableName"/>_DAO With {.Transaction = Transaction}
		      da.DeleteItems(<xsl:apply-templates select="entity/columns" mode="DeleteItemCallDA"/>)
          Commit()
       Catch ex As Exception
         RollBack()
       End Try
    End Sub

    Public Sub DeleteItems( Byval infos as List(Of <xsl:value-of select="entity/@tableName"/>_INFO))
      Try
	      Dim da As New <xsl:value-of select="entity/@tableName"/>_DAO With {.Transaction = Transaction}
	      For Each obj as <xsl:value-of select="entity/@tableName"/>_INFO In infos
	        da.DeleteItems(<xsl:apply-templates select="entity/columns" mode="DeleteItemsCallDA"/>)
        Next
        Commit()
      Catch ex As Exception
        RollBack()
      End Try
    End Sub
#End Region

    End Class

  </xsl:template>
	<!--danh sach tham so cho sub SelectItems-->
	<!--<xsl:template match="entity/columns" mode="SelectItemsParam">
		<xsl:for-each select="property[@dataType!='image']">
			<xsl:choose>
				<xsl:when test="position()>1">, </xsl:when>
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
	<!--<xsl:template match="entity/columns" mode="SelectItemsCallDA">
		<xsl:for-each select="property[@dataType!='image']">
			<xsl:choose><xsl:when test="position()>1">, </xsl:when></xsl:choose>
			<xsl:choose>
				<xsl:when test="@vbDataType='date'"><xsl:value-of select="@columnName"/>_FROM:=<xsl:value-of select="@columnName"/>_FROM, <xsl:value-of select="@columnName"/>_TO:=<xsl:value-of select="@columnName"/>_TO</xsl:when>
				<xsl:otherwise><xsl:value-of select="@columnName"/>:=<xsl:value-of select="@columnName"/></xsl:otherwise>
			</xsl:choose>								
		</xsl:for-each>
	</xsl:template>-->	

<!--danh sach tham so cho sub SelectItem-->
	<xsl:template match="entity/columns" mode="SelectItemParam">
		<xsl:for-each select="property[@isPK='True']">
			<xsl:choose>
				<xsl:when test="position()>1">, </xsl:when>
			</xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/> _			
		</xsl:for-each>
	</xsl:template>
	<!--<xsl:template match="entity/columns" mode="SelectItemCallDA">
		--><!--<xsl:for-each select="property">
			<xsl:choose>
				<xsl:when test="position()>1">, </xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="@isPK='True'"><xsl:value-of select="@columnName"/> := <xsl:value-of select="@columnName"/></xsl:when>
				<xsl:when test="@vbDataType='date'"><xsl:value-of select="@columnName"/>_FROM:=Nothing, <xsl:value-of select="@columnName"/>_TO:=Nothing</xsl:when>
				<xsl:otherwise><xsl:value-of select="@columnName"/>:=Nothing</xsl:otherwise>
			</xsl:choose>
						
		</xsl:for-each>--><!--
   
	</xsl:template>-->	
	<!--Set data cho obj Info-->
  <xsl:template match="entity/columns" mode="SelectItemSetObject">
    <xsl:for-each select="property">
      <xsl:choose>
        <xsl:when test="@isPK='True'">obj.<xsl:value-of select="@columnName"/>=<xsl:value-of select="@columnName"/>
          <xsl:text>
          </xsl:text>
        </xsl:when>
        <xsl:when test="@dataType='DATE'">obj.<xsl:value-of select="@columnName"/>_From=Nothing
         obj.<xsl:value-of select="@columnName"/>_To=Nothing
         obj.<xsl:value-of select="@columnName"/>=Nothing
        </xsl:when>
        <xsl:otherwise>obj.<xsl:value-of select="@columnName"/>=Nothing
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
<!--danh sach tham so cho sub DeleteItem-->
<xsl:template match="entity/columns" mode="DeleteItemParam">
	<xsl:for-each select="property[@isPK='True']">
		<xsl:choose>
			<xsl:when test="position()>1">, </xsl:when>
		</xsl:choose>ByVal <xsl:value-of select="@columnName"/> as <xsl:value-of select="@vbDataType"/> _
	</xsl:for-each>
</xsl:template>
<xsl:template match="entity/columns" mode="DeleteItemCallDA">
	<xsl:for-each select="property[@isPK='True']">
		<xsl:choose>
			<xsl:when test="position()>1">, </xsl:when>
		</xsl:choose><xsl:value-of select="@columnName"/>:=<xsl:value-of select="@columnName"/> _
	</xsl:for-each>
</xsl:template>	
	
<!--danh sach tham so cho sub DeleteItems-->
<xsl:template match="entity/columns" mode="DeleteItemsCallDA">
	<xsl:for-each select="property[@isPK='True']">
		<xsl:choose><xsl:when test="position()>1">, </xsl:when>
		</xsl:choose><xsl:value-of select="@columnName"/>:=obj.<xsl:value-of select="@columnName"/> _
	</xsl:for-each>
</xsl:template>
	
	

<!--Cac function SelectItemsBy-->
<xsl:template match="entity" mode="SelectBy">
	<xsl:variable name="tablename" select="@tableName"/>
	<xsl:for-each select="./columns/property[@refColumn!='']">
    Private Function SelectItemsBy<xsl:value-of select="@columnName"/>(ByVal <xsl:value-of select="@columnName"/> As <xsl:value-of select="@vbDataType"/>) As DataSet
		Try
			Using da As New DataAccess.<xsl:value-of select="$tablename"/>_DAO
				Return da.SelectItemsBy<xsl:value-of select="@columnName"/>(<xsl:value-of select="@columnName"/>)
			End Using
		Catch ex As Exception
			Throw New Common.AppException(ex)
		End Try				
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
