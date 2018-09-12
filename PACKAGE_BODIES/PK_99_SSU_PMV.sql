--------------------------------------------------------
--  DDL for Package Body PK_99_SSU_PMV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_99_SSU_PMV" AS
-- Author       : Gbenga Cruz 
-- Description  : Parameter Setup
-- Date         : January 18, 2017 


    --- Get Money format 9,999.99
     FUNCTION FN_99_SS_PMV_CUR_CF   RETURN VARCHAR2 AS
        v_c_f v_99_ssu_pmv.v_c_f%TYPE;
        
        CURSOR c_pmv IS SELECT v_c_f FROM v_99_ssu_pmv WHERE r_k = 70;
          BEGIN
            
            OPEN  c_pmv;
            FETCH c_pmv INTO v_c_f;
            CLOSE c_pmv;
            
         RETURN v_c_f;
     
     END FN_99_SS_PMV_CUR_CF;
     
     
       --- Get Money format 9999.99
     FUNCTION FN_99_SS_PMV_CUR_NF   RETURN NUMBER AS
        v_n_f v_99_ssu_pmv.v_n_f%TYPE;
        
        CURSOR c_pmv IS SELECT v_n_f FROM v_99_ssu_pmv WHERE r_k = 70;
          BEGIN
           
                       
            OPEN  c_pmv;
            FETCH c_pmv INTO v_n_f;
            CLOSE c_pmv;
            
         RETURN v_n_f;
     
     END FN_99_SS_PMV_CUR_NF;
     
     
     
     --- Get Money decimal place 
     FUNCTION FN_99_SS_PMV_CUR_DP  RETURN NUMBER AS
        v_v_v v_99_ssu_pmv.v_v%TYPE;
        
        CURSOR c_pmv IS SELECT v_v FROM v_99_ssu_pmv WHERE r_k = 70;
          BEGIN
           
                       
            OPEN  c_pmv;
            FETCH c_pmv INTO v_v_v;
            CLOSE c_pmv;
            
         RETURN v_v_v;
     
     END FN_99_SS_PMV_CUR_DP;
     
      --- Get Business date 
     FUNCTION FN_99_SS_PMV_BUS_DT RETURN DATE AS
        v_v_v v_99_ssu_pmv.v_d%TYPE;
        
        CURSOR c_pmv IS SELECT v_d FROM v_99_ssu_pmv WHERE r_k = 99;
          BEGIN
           
                       
            OPEN  c_pmv;
            FETCH c_pmv INTO v_v_v;
            CLOSE c_pmv;
            
         RETURN v_v_v;
     
     END FN_99_SS_PMV_BUS_DT;
     
     
      --- Get Default Company
     FUNCTION FN_99_SS_PMV_COMP RETURN NUMBER AS
        v_v_v v_99_ssu_pmv.v_c%TYPE;
        
        CURSOR c_pmv IS SELECT v_c FROM v_99_ssu_pmv WHERE r_k = 10;
          BEGIN
           
                       
            OPEN  c_pmv;
            FETCH c_pmv INTO v_v_v;
            CLOSE c_pmv;
            
         RETURN v_v_v;
     
     END FN_99_SS_PMV_COMP;
     
     --- Get Default Currency
     FUNCTION FN_99_SS_PMV_CURR RETURN NUMBER AS
        v_v_v v_99_ssu_pmv.v_c%TYPE;
        
        CURSOR c_pmv IS SELECT v_c FROM v_99_ssu_pmv WHERE r_k = 70;
          BEGIN
           
                       
            OPEN  c_pmv;
            FETCH c_pmv INTO v_v_v;
            CLOSE c_pmv;
            
         RETURN v_v_v;
     
     END FN_99_SS_PMV_CURR;
     
     --- Audit Trail
     PROCEDURE PC_99_SSU_AUD (p_aud IN v_99_ssu_aud%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_aud   v_99_ssu_aud%ROWTYPE;
         v_err   v_99_ssu_log%ROWTYPE;

         CURSOR c_aud IS SELECT r_k, nvl(bt_id,pg_id) aud_code, nvl(bt_dsc, pg_dsc) aud_desc, app_mdl FROM v_99_ssu_priv WHERE nvl(bt_id,pg_id) = p_aud.aud_code;
    

         BEGIN
		 
		     FOR i IN c_aud LOOP
			 
			     v_aud.aud_code := i.aud_code;
			     v_aud.aud_desc := i.aud_desc;
                 v_aud.app_mdl  := i.app_mdl;
			 
			 END LOOP;
			    
                v_aud.tran_r_k := p_aud.tran_r_k;
               
                    IF v_err.err_msg IS NULL THEN

                   INSERT INTO t_99_ssu_aud(r_k, aud_code, aud_desc,app_mdl,tran_r_k)
                                   VALUES
                     (v_aud.r_k, v_aud.aud_code, v_aud.aud_desc,v_aud.app_mdl,v_aud.tran_r_k);
                   
                 END IF;
		            
        COMMIT;
       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_99_SSU_AUD;
    
    
END PK_99_SSU_PMV;

/
