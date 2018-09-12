--------------------------------------------------------
--  DDL for Package Body PK_99_SSU_ERR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_99_SSU_ERR" AS 
 
-- Author       : Gbenga Cruz 
-- Description  : Error Handling 
-- Date         : January 18, 2017 
 
 
  --- Error Handling  
  PROCEDURE PC_99_SSU_ERR (p_err IN OUT v_99_ssu_log%ROWTYPE) AS 
 
         v_err     v_99_ssu_log%ROWTYPE; 
         v_err_msg hm_error_lookup.message%TYPE;        

         CURSOR c_err IS SELECT message from hm_error_lookup where language_code = p_err.err_cd;

           BEGIN 

           OPEN c_err;
           FETCH c_err INTO v_err_msg;
           CLOSE c_err;

			    IF p_err.err_cd IS NOT NULL AND p_err.err_msg IS NOT NULL THEN
                 v_err.err_cd   :=  p_err.err_cd; 
                 v_err.err_msg  :=   p_err.err_msg;
                 
                ELSIF p_err.err_cd IS NOT NULL THEN 
                v_err.err_cd   :=  p_err.err_cd; 
                v_err.err_msg  := v_err_msg;
                 
                ELSE
			          v_err.err_cd   := sqlcode;
                      v_err.err_msg  := sqlerrm; 
                END IF; 



                v_err.err_stk  := dbms_utility.format_error_backtrace;  

			    HM_FW.add_error_log(p_error => v_err.err_msg, p_apex_error_code=> v_err.err_cd,
                                    p_ora_sqlcode => v_err.err_cd, p_ora_sqlerrm =>sqlerrm, p_error_backtrace => v_err.err_stk);
               p_err.err_msg  := v_err.err_msg; 

  END PC_99_SSU_ERR; 

END PK_99_SSU_ERR;

/
