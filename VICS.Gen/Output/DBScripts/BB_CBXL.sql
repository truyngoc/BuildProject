

CREATE OR REPLACE PACKAGE PKG_BB_CBXL AS
  TYPE ref_cursor IS REF CURSOR;

  
  
  PROCEDURE bb_cbxl_insert (
			p_id	BB_CBXL.ID%TYPE
			,p_bienban_id	BB_CBXL.BIENBAN_ID%TYPE
			,p_hoten	BB_CBXL.HOTEN%TYPE
			,p_chucvu	BB_CBXL.CHUCVU%TYPE
			,p_madonvi	BB_CBXL.MADONVI%TYPE
			,p_tendonvi	BB_CBXL.TENDONVI%TYPE
			,p_loai	BB_CBXL.LOAI%TYPE);
  
  PROCEDURE bb_cbxl_update (
			p_id	BB_CBXL.ID%TYPE
			,p_bienban_id	BB_CBXL.BIENBAN_ID%TYPE
			,p_hoten	BB_CBXL.HOTEN%TYPE
			,p_chucvu	BB_CBXL.CHUCVU%TYPE
			,p_madonvi	BB_CBXL.MADONVI%TYPE
			,p_tendonvi	BB_CBXL.TENDONVI%TYPE
			,p_loai	BB_CBXL.LOAI%TYPE);

  PROCEDURE bb_cbxl_delete(
		p_id	BB_CBXL.ID%TYPE);



  PROCEDURE bb_cbxl_getItem (
      p_id  BB_CBXL.ID%TYPE
    ,v_cursor  OUT ref_cursor
  );
      
    
  PROCEDURE bb_cbxl_get (
      p_id  BB_CBXL.ID%TYPE,
      p_bienban_id  BB_CBXL.BIENBAN_ID%TYPE,
      p_hoten  BB_CBXL.HOTEN%TYPE,
      p_chucvu  BB_CBXL.CHUCVU%TYPE,
      p_madonvi  BB_CBXL.MADONVI%TYPE,
      p_tendonvi  BB_CBXL.TENDONVI%TYPE,
      p_loai  BB_CBXL.LOAI%TYPE
    ,v_cursor  OUT ref_cursor
  );
      

  PROCEDURE bb_cbxl_checkExist(
		p_id	BB_CBXL.ID%TYPE, 
  reccount out number);
END PKG_BB_CBXL;

commit;





CREATE OR REPLACE PACKAGE BODY PKG_BB_CBXL AS



PROCEDURE bb_cbxl_insert(
			p_id	BB_CBXL.ID%TYPE
			,p_bienban_id	BB_CBXL.BIENBAN_ID%TYPE
			,p_hoten	BB_CBXL.HOTEN%TYPE
			,p_chucvu	BB_CBXL.CHUCVU%TYPE
			,p_madonvi	BB_CBXL.MADONVI%TYPE
			,p_tendonvi	BB_CBXL.TENDONVI%TYPE
			,p_loai	BB_CBXL.LOAI%TYPE)
AS
BEGIN
  
	INSERT INTO BB_CBXL( ID
				,BIENBAN_ID
				,HOTEN
				,CHUCVU
				,MADONVI
				,TENDONVI
				,LOAI
				)
		
	VALUES	(SEQ_BB_CBXL.Nextval  
		       , p_bienban_id
				,p_hoten
				,p_chucvu
				,p_madonvi
				,p_tendonvi
				,p_loai
				);

  
  EXCEPTION
  WHEN OTHERS
  THEN
  RAISE_APPLICATION_ERROR (-20001, 'PKG_BB_CBXL.sp_insert '
  || '[Code: '
  || TO_CHAR (SQLCODE)
  || '] '
  || '[Description: '
  || SQLERRM
  || ']'
  );
END;

PROCEDURE bb_cbxl_update(
			p_id	BB_CBXL.ID%TYPE
			,p_bienban_id	BB_CBXL.BIENBAN_ID%TYPE
			,p_hoten	BB_CBXL.HOTEN%TYPE
			,p_chucvu	BB_CBXL.CHUCVU%TYPE
			,p_madonvi	BB_CBXL.MADONVI%TYPE
			,p_tendonvi	BB_CBXL.TENDONVI%TYPE
			,p_loai	BB_CBXL.LOAI%TYPE)
AS
BEGIN
  
	UPDATE BB_CBXL	SET
		 BIENBAN_ID 	= p_bienban_id
		,HOTEN 	= p_hoten
		,CHUCVU 	= p_chucvu
		,MADONVI 	= p_madonvi
		,TENDONVI 	= p_tendonvi
		,LOAI 	= p_loai
	WHERE 
		ID 	= p_id;
		
  
  EXCEPTION
  WHEN OTHERS
  THEN
  RAISE_APPLICATION_ERROR (-20001, 'PKG_BB_CBXL.sp_update '
  || '[Code: '
  || TO_CHAR (SQLCODE)
  || '] '
  || '[Description: '
  || SQLERRM
  || ']'
  );
END;
    
    
PROCEDURE bb_cbxl_delete(
		p_id	BB_CBXL.ID%TYPE)
AS
BEGIN
		
	DELETE BB_CBXL
	WHERE
		ID 	= p_id
		;
    
    EXCEPTION
    WHEN OTHERS
    THEN
    RAISE_APPLICATION_ERROR (-20001, 'PKG_BB_CBXL.sp_delete '
    || '[Code: '
    || TO_CHAR (SQLCODE)
    || '] '
    || '[Description: '
    || SQLERRM
    || ']'
    );
END;

PROCEDURE bb_cbxl_getItem(
      p_id  BB_CBXL.ID%TYPE
    ,v_cursor  OUT ref_cursor
  )
AS
BEGIN
	OPEN v_cursor FOR
		
	SELECT 		ID
				, BIENBAN_ID
				, HOTEN
				, CHUCVU
				, MADONVI
				, TENDONVI
				, LOAI
	FROM BB_CBXL
	WHERE 
		(p_id is NULL or ID = p_id)
		;
END ;

PROCEDURE bb_cbxl_get(
      p_id  BB_CBXL.ID%TYPE,
      p_bienban_id  BB_CBXL.BIENBAN_ID%TYPE,
      p_hoten  BB_CBXL.HOTEN%TYPE,
      p_chucvu  BB_CBXL.CHUCVU%TYPE,
      p_madonvi  BB_CBXL.MADONVI%TYPE,
      p_tendonvi  BB_CBXL.TENDONVI%TYPE,
      p_loai  BB_CBXL.LOAI%TYPE
    ,v_cursor  OUT ref_cursor
  )
AS
BEGIN
	OPEN v_cursor FOR
		
	SELECT 		ID
				, BIENBAN_ID
				, HOTEN
				, CHUCVU
				, MADONVI
				, TENDONVI
				, LOAI
	FROM BB_CBXL
	WHERE 
		(p_id is NULL or ID = p_id)
		AND (p_bienban_id is NULL or BIENBAN_ID = p_bienban_id)
		AND (p_hoten is NULL or upper(HOTEN) like '%' || upper(p_hoten) || '%')
		AND (p_chucvu is NULL or upper(CHUCVU) like '%' || upper(p_chucvu) || '%')
		AND (p_madonvi is NULL or upper(MADONVI) like '%' || upper(p_madonvi) || '%')
		AND (p_tendonvi is NULL or upper(TENDONVI) like '%' || upper(p_tendonvi) || '%')
		AND (p_loai is NULL or LOAI = p_loai)
		;
END ;

PROCEDURE bb_cbxl_checkExist(
		p_id	BB_CBXL.ID%TYPE
    ,reccount out number)
AS
BEGIN
		
	SELECT COUNT(*) INTO reccount FROM BB_CBXL
	WHERE
		ID 	= p_id
		;
    
    EXCEPTION
    WHEN OTHERS
    THEN
    RAISE_APPLICATION_ERROR (-20001, 'PKG_BB_CBXL.checkExist '
    || '[Code: '
    || TO_CHAR (SQLCODE)
    || '] '
    || '[Description: '
    || SQLERRM
    || ']'
    );
    END;
    
	
END PKG_BB_CBXL;
