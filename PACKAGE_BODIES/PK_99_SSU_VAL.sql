--------------------------------------------------------
--  DDL for Package Body PK_99_SSU_VAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_99_SSU_VAL" AS 
 
-- Author       : Gbenga Cruz 
-- Description  : Validation Management  
-- Date         : January 18, 2017 
    
   ---- Validate Password
   FUNCTION FN_99_SSU_PWD_VAL  (p_prf_cd IN v_99_ssu_pwd_prf.prf_cd%type, p_usr_pwd IN v_99_ssu_usr.usr_pwd%type)  RETURN BOOLEAN  AS

     v_sta BOOLEAN;

	 v_prf_key v_99_ssu_pwd_prf.prf_key%TYPE;
	 v_usr_pwd v_99_ssu_usr.usr_pwd%TYPE;


	 CURSOR c_pwd_prf IS SELECT prf_key FROM v_99_ssu_pwd_prf WHERE prf_cd = p_prf_cd and ius_yn = '1';


                 BEGIN

		         OPEN  c_pwd_prf;
		         FETCH c_pwd_prf INTO v_prf_key;
		         CLOSE c_pwd_prf;

		         v_usr_pwd := p_usr_pwd;

                        IF p_prf_cd IN ('-20002','-20006','-20007','-20008')  THEN 

                        IF regexp_like(v_usr_pwd ,v_prf_key) THEN
                        v_sta := true;
                        ELSE
                        v_sta := false;
                        END IF;
                        END IF;

                       IF p_prf_cd IN ('-20004') THEN

                       IF LENGTH (v_usr_pwd) >=  to_number(v_prf_key) THEN

                        v_sta := true;
                        ELSE
                        v_sta := false;
                        END IF;
                        END IF;
                 RETURN v_sta;

    END FN_99_SSU_PWD_VAL;



  --- Validate User ID
   FUNCTION FN_99_SSU_USR_VAL (p_usr_id IN v_99_ssu_usr.usr_id%type)  RETURN BOOLEAN  AS

     v_sta BOOLEAN;
     v_usr_id  v_99_ssu_usr.usr_id%type;
         CURSOR c_usr_id IS SELECT count(usr_id) usr_id from v_99_ssu_usr where UPPER(usr_id) = UPPER(p_usr_id);

                 BEGIN

                         OPEN  c_usr_id;
                         FETCH c_usr_id INTO v_usr_id;
			             CLOSE c_usr_id;



                         IF v_usr_id = 0 THEN

                                 v_sta := true;
                         ELSE
                                 v_sta := false;
                         END IF;

                RETURN v_sta;

    END FN_99_SSU_USR_VAL;

   END PK_99_SSU_VAL;

/
