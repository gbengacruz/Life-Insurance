--------------------------------------------------------
--  DDL for Package Body PK_99_SSU_AUTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_99_SSU_AUTH" AS 
 
   	 -- Author       : Gbenga Cruz 
     -- Description  : Cloud Application User Authentication 
     -- Date         : January 18, 2017 
 
    ---Cloud User Check 
     
    PROCEDURE PC_SSU_99_CHK (p_usr IN varchar2, p_cnt IN INT) AS 
		  
		 v_userName v_99_ssu_usr.usr_id%TYPE; 
         v_cnt INT; 
         v_ius_yn   v_99_ssu_usr.ius_yn%TYPE := 1; 


		     BEGIN 

			      v_cnt := p_cnt; 

		           IF v_cnt <> 1 THEN 

                     UPDATE T_99_SSU_USR SET lgn_ctn = nvl(lgn_ctn,0) + 1 WHERE UPPER(usr_id) = UPPER(p_usr); 

                     UPDATE T_99_SSU_USR SET ius_yn = 0 WHERE UPPER(usr_id) = UPPER(p_usr) AND lgn_ctn > 5; 

                   END IF; 

                 IF v_cnt = 1 THEN 

                     UPDATE T_99_SSU_USR SET lst_log = systimestamp,lgn_ctn = 0  WHERE UPPER(usr_id) = UPPER(p_usr); 
                 END IF; 

		     COMMIT; 


	  END PC_SSU_99_CHK; 




     ---Cloud Admin and App User Authentication 

     FUNCTION FN_99_SSU_AUTH (p_username IN varchar2, p_password IN varchar2) RETURN BOOLEAN 

         IS 

         v_userName v_99_ssu_usr.usr_id%TYPE; 
         v_userCount INT; 
         v_comp_key v_99_ssu_usr.comp_key%TYPE; 
         v_valuesToHash apex_t_varchar2; 
         v_ius_yn   v_99_ssu_usr.ius_yn%TYPE := 1; 


         BEGIN 


             v_userName := UPPER(p_username); 

             v_valuesToHash  := apex_t_varchar2(v_username, p_password); 

             SELECT COUNT(*) INTO v_userCount 
             FROM v_99_ssu_usr 
             WHERE UPPER(usr_id) = UPPER(v_userName) AND ius_yn = v_ius_yn 
             AND usr_pwd = apex_util.get_hash(v_valuesToHash,null); 

			 PC_SSU_99_CHK (v_username,v_userCount) ; 

         RETURN v_userCount = 1; 

     END FN_99_SSU_AUTH; 

    -- Cloud user Authorization for pages 

        FUNCTION FN_99_SSU_PRIV RETURN BOOLEAN 

         IS 

         v_cnt INT; 
         v_comp_key v_99_ssu_usr.comp_key%TYPE; 
         v_valuesToHash apex_t_varchar2; 
         v_ius_yn   v_99_ssu_usr.ius_yn%TYPE := 1; 

		     v_usr_rle    v_99_ssu_priv.usr_rle%TYPE; 

         CURSOR c_priv IS SELECT usr_rle FROM v_99_ssu_priv WHERE app_id = V('APP_ID') and pg_id = V('APP_PAGE_ID'); 

         BEGIN 

			 OPEN  c_priv; 
			 FETCH c_priv INTO v_usr_rle; 
			 CLOSE c_priv; 


             SELECT COUNT(*) INTO v_cnt 
             FROM v_99_ssu_usr_rle 
             WHERE UPPER(usr_cd) = UPPER(V('APP_USER')) AND role_cd = v_usr_rle; 

         RETURN v_cnt = 1; 

     END FN_99_SSU_PRIV; 


         -- Cloud user Authorization for page MENU 

        FUNCTION FN_99_SSU_PRIV_MNU(P_APP_PAGE_ID IN VARCHAR2) RETURN BOOLEAN 

         IS 

         v_cnt INT; 
         v_comp_key v_99_ssu_usr.comp_key%TYPE; 
         v_valuesToHash apex_t_varchar2; 
         v_ius_yn   v_99_ssu_usr.ius_yn%TYPE := 1; 

		     v_usr_rle    v_99_ssu_priv.usr_rle%TYPE; 

         CURSOR c_priv IS SELECT usr_rle FROM v_99_ssu_priv WHERE app_id = V('APP_ID') and pg_id = P_APP_PAGE_ID; 

         BEGIN 

			 OPEN  c_priv; 
			 FETCH c_priv INTO v_usr_rle; 
			 CLOSE c_priv; 


             SELECT COUNT(*) INTO v_cnt 
             FROM v_99_ssu_usr_rle 
             WHERE UPPER(usr_cd) = UPPER(V('APP_USER')) AND role_cd = v_usr_rle; 

         RETURN v_cnt = 1; 

     END FN_99_SSU_PRIV_MNU; 

END PK_99_SSU_AUTH;

/
