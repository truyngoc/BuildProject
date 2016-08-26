
/*=============================================
Author:	Nguyễn Đăng Tùng
Create date:	12/11/2012 12:50
Description:	
============================================ */

CREATE OR REPLACE PACKAGE PKG_MHS_DIEU_CHINH_MA_SO AS
TYPE ref_cursor IS REF CURSOR;
FUNCTION fn_insert_update (p_action VARCHAR, 
			p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE
			,p_so_tk	MHS_DIEU_CHINH_MA_SO.SO_TK%TYPE
			,p_ma_lh	MHS_DIEU_CHINH_MA_SO.MA_LH%TYPE
			,p_ma_hq	MHS_DIEU_CHINH_MA_SO.MA_HQ%TYPE
			,p_nam_dk	MHS_DIEU_CHINH_MA_SO.NAM_DK%TYPE
			,p_id_hang	MHS_DIEU_CHINH_MA_SO.ID_HANG%TYPE
			,p_ngay_dk	MHS_DIEU_CHINH_MA_SO.NGAY_DK%TYPE
			,p_c_id	MHS_DIEU_CHINH_MA_SO.C_ID%TYPE) RETURN VARCHAR;

FUNCTION fn_delete(
		p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE)
RETURN VARCHAR;

FUNCTION fn_search (p_rowindex integer, 
		p_pagesize integer, 
		p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE) RETURN ref_cursor;

FUNCTION fn_get (
		p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE) RETURN ref_cursor;


END PKG_MHS_DIEU_CHINH_MA_SO;

commit;
/*=============================================
Author:	Nguyễn Đăng Tùng
Create date:	12/11/2012 12:50
Description:	
Revise History:	
============================================ */

CREATE OR REPLACE PACKAGE BODY PKG_MHS_DIEU_CHINH_MA_SO AS

FUNCTION fn_insert_update(p_action VARCHAR, 
			p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE
			,p_so_tk	MHS_DIEU_CHINH_MA_SO.SO_TK%TYPE
			,p_ma_lh	MHS_DIEU_CHINH_MA_SO.MA_LH%TYPE
			,p_ma_hq	MHS_DIEU_CHINH_MA_SO.MA_HQ%TYPE
			,p_nam_dk	MHS_DIEU_CHINH_MA_SO.NAM_DK%TYPE
			,p_id_hang	MHS_DIEU_CHINH_MA_SO.ID_HANG%TYPE
			,p_ngay_dk	MHS_DIEU_CHINH_MA_SO.NGAY_DK%TYPE
			,p_c_id	MHS_DIEU_CHINH_MA_SO.C_ID%TYPE)
		RETURN VARCHAR
AS
	v_count   NUMBER;
BEGIN 
	IF p_action = 'I' THEN
		
	INSERT INTO MHS_DIEU_CHINH_MA_SO( M_ID
				,SO_TK
				,MA_LH
				,MA_HQ
				,NAM_DK
				,ID_HANG
				,NGAY_DK
				,C_ID
				)
		
	VALUES	( p_m_id
				,p_so_tk
				,p_ma_lh
				,p_ma_hq
				,p_nam_dk
				,p_id_hang
				,p_ngay_dk
				,p_c_id
				);

	ELSE 
		IF p_action = 'U' THEN
			
	UPDATE MHS_DIEU_CHINH_MA_SO	SET
		 SO_TK 	= p_so_tk
		,MA_LH 	= p_ma_lh
		,MA_HQ 	= p_ma_hq
		,NAM_DK 	= p_nam_dk
		,ID_HANG 	= p_id_hang
		,NGAY_DK 	= p_ngay_dk
		,C_ID 	= p_c_id
	WHERE 
		M_ID 	= p_m_id;
		
		END IF;
	END IF;
	RETURN NULL;
			RETURN NULL;
		EXCEPTION
			WHEN OTHERS
			THEN
			RETURN SQLERRM;
END;

FUNCTION fn_delete(
		p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE)
					RETURN VARCHAR
AS
BEGIN

		
	DELETE MHS_DIEU_CHINH_MA_SO
	WHERE
		M_ID 	= p_m_id
		;
				RETURN NULL;
		EXCEPTION
			WHEN OTHERS
			THEN
			RETURN SQLERRM;
		
END;

FUNCTION fn_get(
		p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE)
		RETURN ref_cursor
AS
	v_cursor ref_cursor;
BEGIN
	OPEN v_cursor FOR
		
	SELECT 		M_ID
				, SO_TK
				, MA_LH
				, MA_HQ
				, NAM_DK
				, ID_HANG
				, NGAY_DK
				, C_ID
	FROM	MHS_DIEU_CHINH_MA_SO
	WHERE
		M_ID 	= p_m_id;
		
		
	RETURN v_cursor;
END ;

FUNCTION fn_search (p_rowindex integer 
		, p_pagesize integer  
		, 
		p_m_id	MHS_DIEU_CHINH_MA_SO.M_ID%TYPE) 
		RETURN ref_cursor
AS
	v_cursor   ref_cursor;
BEGIN 
	OPEN v_cursor FOR
		
    SELECT *
    FROM (SELECT COUNT (*) OVER () AS ROWCOUNT,
                     ROW_NUMBER () OVER (ORDER BY 	M_ID) AS rnum, 
													M_ID
														, SO_TK
														, MA_LH
														, MA_HQ
														, NAM_DK
														, ID_HANG
														, NGAY_DK
														, C_ID
              FROM MHS_DIEU_CHINH_MA_SO u
			  WHERE 
				(p_m_id IS NULL OR M_ID = p_m_id)
		)
	WHERE rnum BETWEEN p_rowindex + 1 AND p_rowindex + p_pagesize;
		
		
	RETURN v_cursor;
END;
	
END PKG_MHS_DIEU_CHINH_MA_SO;
