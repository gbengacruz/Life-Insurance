--------------------------------------------------------
--  DDL for Package Body PK_20_CUS_STP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_20_CUS_STP" AS
-- Author       : Gbenga Cruz 
-- Description  : Customer Account Setup
-- Date         : January 18, 2017 


        --- Validate customer type
    FUNCTION FN_20_CUS_TP (p_cus_tp IN v_20_cus_tp%ROWTYPE) RETURN BOOLEAN AS 
       v_err       v_99_ssu_log%ROWTYPE;
	   v_cus_cnt    NUMBER;
       
         CURSOR c_cus IS SELECT COUNT(r_k) R_K FROM v_20_cus_brk where cus_tp = p_cus_tp.r_k;
        
            BEGIN
			     
			     OPEN  c_cus;
				 FETCH c_cus INTO v_cus_cnt;
				 CLOSE c_cus;
                         
            
                 IF  v_cus_cnt  > 0 THEN 
			  
                     RETURN FALSE; 
                   ELSE 
 				     RETURN TRUE; 
                 END IF;
               
     END FN_20_CUS_TP;

    --- Customer Type Creation AND Update
     PROCEDURE PC_20_CUS_TP (p_cus_tp IN v_20_cus_tp%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_cus_tp    v_20_cus_tp%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;

         

         BEGIN
         
             v_cus_tp.r_k              := p_cus_tp.r_k;
             v_cus_tp.cus_tp           := p_cus_tp.cus_tp;
             v_cus_tp.sht_nm           := p_cus_tp.sht_nm;
             v_cus_tp.ius_yn           := p_cus_tp.ius_yn;
             
             IF  v_cus_tp.r_k IS NULL THEN  
			 
                     
           
              
                 IF v_err.err_msg IS NULL THEN

                   INSERT INTO t_20_cus_tp(r_k, cus_tp, sht_nm, ius_yn)
                                   VALUES
                     (v_cus_tp.r_k, v_cus_tp.cus_tp, v_cus_tp.sht_nm, v_cus_tp.ius_yn);
                   
                 END IF;
		    
		   ELSE 
           
                IF v_err.err_msg IS NULL THEN
               
                   UPDATE t_20_cus_tp SET cus_tp = v_cus_tp.cus_tp, sht_nm =  v_cus_tp.sht_nm, ius_yn = v_cus_tp.ius_yn
                   WHERE r_k = v_cus_tp.r_k;
                
               END IF;
               
		   END IF;
           
        COMMIT;
       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_CUS_TP;
    
    			  
	 --- Customer Type deletion
     PROCEDURE PC_20_CUS_TP_DEL (p_cus_tp IN v_20_cus_tp%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_cus_tp    v_20_cus_tp%ROWTYPE;
       v_err       v_99_ssu_log%ROWTYPE;
       v_val       BOOLEAN;
         

         BEGIN
         
             v_cus_tp.r_k              := p_cus_tp.r_k;
         
             	 
	  
	         v_val := PK_20_CUS_STP.FN_20_CUS_TP(v_cus_tp);
             
                 IF  v_val = FALSE THEN 
                            v_err.err_cd := '-20025';
                            p_err_msg := v_err.err_msg; 
                           raise_application_error(v_err.err_cd ,p_err_msg);
                END IF;
             
         	           
              
                 IF v_err.err_msg IS NULL THEN

                     DELETE FROM  t_20_cus_tp WHERE r_k = v_cus_tp.r_k;
                   
		         END IF;
           
        COMMIT;
        
       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_CUS_TP_DEL;
    
END PK_20_CUS_STP;

/
