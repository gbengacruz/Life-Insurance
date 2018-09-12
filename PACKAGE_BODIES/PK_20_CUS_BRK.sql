--------------------------------------------------------
--  DDL for Package Body PK_20_CUS_BRK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_20_CUS_BRK" AS


-- Author       : Gbenga Cruz 
-- Description  : Customer  Management
-- Date         : January 18, 2017 
 
    --- Customer Creation
     PROCEDURE PC_20_CUS_BRK (p_cus_brk IN v_20_cus_brk%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_cus_brk   v_20_cus_brk%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;
         v_cus_act   v_70_cus_act%ROWTYPE;
         v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
     

         BEGIN
                
             v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;                                                                                                   
             v_cus_brk.r_k              := p_cus_brk.r_k;
             v_cus_brk.cus_desc         := p_cus_brk.cus_desc;
             v_cus_brk.cus_tp           := p_cus_brk.cus_tp;
             v_cus_brk.ius_yn           := p_cus_brk.ius_yn;
             v_cus_brk.phn_no           := p_cus_brk.phn_no;
             v_cus_brk.cus_eml          := p_cus_brk.cus_eml;
             v_cus_brk.naic_id          := p_cus_brk.naic_id;
             v_cus_brk.apr_sta          := 1;  
             v_cus_brk.apr_by           := V('APP_USER');
             v_cus_brk.apr_dt           := SYSDATE;
             
             IF  v_cus_brk.naic_id IS NULL AND v_cus_brk.cus_tp = 10 THEN
                 v_cus_brk.apr_sta     := 0;
                 v_cus_brk.apr_by      := NULL;
                 v_cus_brk.apr_dt      := NULL;
             END IF;
            

                            
           IF v_err.err_msg IS NULL THEN
              
               IF v_cus_brk.r_k IS NULL THEN
               
                  v_cus_brk.r_k              := s_20_cus_brk.NEXTVAL; ---p_cus_brk.r_k;
                
               ---Customer Cash Account Creattion
         
                   v_cus_act.r_k              :=  s_70_cus_act.NEXTVAL;  
                   v_cus_act.cus_r_k          :=  v_cus_brk.r_k;  --p_cus_act.cus_r_k;
                   v_cus_act.bus_dt           :=  v_bus_dt;
                   v_cus_act.sys_dtt          :=  SYSDATE;
                   v_cus_act.apr_sta          := 0;
                   --  v_cus_act.dept_r_k         := p_cus_act.dept_r_k;
                   --  v_cus_act.loc_r_k          := p_cus_act.loc_r_k;
                   --  v_cus_act.comp_r_k         := p_cus_act.comp_r_k;
                   v_cus_act.curr_r_k         := 100;
                   v_cus_act.tran_bal         := 0;
                
                  INSERT INTO t_20_cus_brk(r_k ,cus_desc ,cus_tp ,ius_yn ,phn_no ,cus_eml,naic_id,apr_sta,apr_by, apr_dt)
                         VALUES
                       (v_cus_brk.r_k,v_cus_brk.cus_desc ,v_cus_brk.cus_tp ,v_cus_brk.ius_yn, v_cus_brk.phn_no, v_cus_brk.cus_eml,v_cus_brk.naic_id,v_cus_brk.apr_sta,v_cus_brk.apr_by,v_cus_brk.apr_dt);
                       
                       
                   ---Customer Cash Account Creattion                   
                    IF v_err.err_msg IS NULL THEN
                        PK_70_CUS_ACT.PC_70_CUS_ACT (v_cus_act, v_err.err_msg);
                    END IF;
                        
                    IF v_err.err_msg IS NULL THEN
                        PK_70_CUS_ACT.PC_70_CUS_ACT_APR (v_cus_act, v_err.err_msg);
                    END IF;
                        
                         IF v_err.err_msg IS NOT NULL THEN
                          
                                 v_err.err_cd := '-20099';
                                 p_err_msg := v_err.err_msg; 
                                 ROLLBACK;
                                 raise_application_error(v_err.err_cd ,p_err_msg);
                         END IF;         
                         
               ELSE 
                   UPDATE t_20_cus_brk SET cus_desc = v_cus_brk.cus_desc,cus_tp = v_cus_brk.cus_tp, ius_yn = v_cus_brk.ius_yn,
                                       phn_no = v_cus_brk.phn_no,cus_eml = v_cus_brk.cus_eml, naic_id = v_cus_brk.naic_id WHERE r_k = v_cus_brk.r_k;
               END IF;
 
                     
                COMMIT;

           END IF;

       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_CUS_BRK;
    
    
    
        --- Customer Approval
     PROCEDURE PC_20_CUS_BRK_APR (p_cus_brk IN v_20_cus_brk%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_cus_brk   v_20_cus_brk%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;
         v_cus_act   v_70_cus_act%ROWTYPE;
         v_bus_dt    v_99_ssu_pmv.v_d%TYPE;
     

         BEGIN
                
             v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;                                                                                                   
             v_cus_brk.r_k              := p_cus_brk.r_k;
             v_cus_brk.apr_sta          := 1;  
             v_cus_brk.apr_by           := nvl(wwv_flow.g_user,user); 
             v_cus_brk.apr_dt           := SYSDATE;
             

               IF v_err.err_msg IS NULL THEN 

                          UPDATE t_20_cus_brk SET apr_sta = v_cus_brk.apr_sta,apr_by = v_cus_brk.apr_by, apr_dt = v_cus_brk.apr_dt WHERE r_k = v_cus_brk.r_k;

               END IF;
 
                     
                COMMIT;


       EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_20_CUS_BRK_APR;
    
    
END PK_20_CUS_BRK;

/
