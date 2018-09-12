--------------------------------------------------------
--  DDL for Package Body PK_20_CUS_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_20_CUS_INFO" AS

-- Author       : Gbenga Cruz 
-- Description  : Customer Management
-- Date         : January 18, 2017 
 
 --- Customer Management

     PROCEDURE PC_20_CUS_INFO (p_cus IN v_20_cus_info%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
     
     v_cus     v_20_cus_info%ROWTYPE; 
     v_err     v_99_ssu_log%ROWTYPE; 
     v_nxt_dob v_20_cus_info.dob%TYPE;
     v_cus_act   v_70_cus_act%ROWTYPE;
     v_bus_dt    v_99_ssu_pmv.v_d%TYPE;


     
       BEGIN
       
         v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
         
         v_cus.r_k     := p_cus.r_k; --s_20_cus_info.NEXTVAL;
         v_cus.lst_nm  := p_cus.lst_nm;
         v_cus.fst_nm  := p_cus.fst_nm;
         v_cus.mid_nm  := p_cus.mid_nm;
         v_cus.dob     := p_cus.dob;
         v_cus.bth_pc  := p_cus.bth_pc;
         v_cus.nxt_age := p_cus.nxt_age;
         v_cus.occp    := p_cus.occp;
         v_cus.email   := p_cus.email;
         v_cus.phone   := p_cus.phone;
         v_cus.fax     := p_cus.fax;
         v_cus.addr    := p_cus.addr;
         v_cus.cus_tle := p_cus.cus_tle;
         v_cus.cus_tp  := 12;
         v_cus.asr_tp  := p_cus.asr_tp;
         v_cus.cus_nm  := p_cus.cus_nm;
         v_cus.bnk_no  := p_cus.bnk_no;
         v_cus.apr_sta  := 0;

         
         
     IF v_cus.asr_tp = 'I' THEN
         
         v_nxt_dob     := SUBSTR(v_cus.dob, 1, 7) || EXTRACT(YEAR FROM SYSDATE);
         
         IF v_nxt_dob > SYSDATE THEN
         
               v_cus.nxt_age :=  TRUNC((v_nxt_dob - v_cus.dob)/365);
         
                ELSE
         
               v_nxt_dob :=  ADD_MONTHS(v_nxt_dob, 12);
               
               v_cus.nxt_age :=  TRUNC((v_nxt_dob - v_cus.dob)/365);
         
         END IF;
         
       END IF;   
         
         ---Customer Cash Account Creattion
         
             v_cus_act.r_k              :=  s_70_cus_act.NEXTVAL;  
             v_cus_act.cus_r_k          :=  v_cus.r_k;  --p_cus_act.cus_r_k;
             v_cus_act.bus_dt           :=  v_bus_dt;
             v_cus_act.sys_dtt          :=  SYSDATE;
             v_cus_act.apr_sta          := 0;
           --  v_cus_act.dept_r_k         := p_cus_act.dept_r_k;
           --  v_cus_act.loc_r_k          := p_cus_act.loc_r_k;
           --  v_cus_act.comp_r_k         := p_cus_act.comp_r_k;
             v_cus_act.curr_r_k         := 100;
             v_cus_act.tran_bal         := 0;
             v_cus_act.ius_yn           := 1;
         
           IF v_err.err_msg IS NULL THEN 
           
           INSERT INTO t_20_cus_info(r_k,lst_nm,fst_nm,mid_nm,dob,bth_pc,nxt_age,occp,email,phone,fax,addr,cus_tle,cus_tp,asr_tp, cus_nm,bnk_no,apr_sta ) 
                  VALUES
                  (v_cus.r_k,v_cus.lst_nm,v_cus.fst_nm,v_cus.mid_nm,v_cus.dob,v_cus.bth_pc,v_cus.nxt_age,v_cus.occp,v_cus.email,v_cus.phone,v_cus.fax,v_cus.addr,v_cus.cus_tle,v_cus.cus_tp,v_cus.asr_tp, v_cus.cus_nm,v_cus.bnk_no ,v_cus.apr_sta);
                  
                  
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
                                          
                       
           COMMIT;
           
           END IF;
         
      
         
         EXCEPTION WHEN OTHERS THEN 
           ROLLBACK; 
             pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
         
       END PC_20_CUS_INFO;
       
     --- Customer Questions 
     PROCEDURE PC_20_CUS_QUST (p_cus_qust IN v_20_cus_qust%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
     
      v_cus_qust  v_20_cus_qust%ROWTYPE; 
      v_err       v_99_ssu_log%ROWTYPE; 
     
       BEGIN
       
         v_cus_qust.r_k          := p_cus_qust.r_k;
         v_cus_qust.cus_r_k      := p_cus_qust.cus_r_k;
         v_cus_qust.qust_r_k     := p_cus_qust.qust_r_k;
         v_cus_qust.qust_resp    := p_cus_qust.qust_resp;
 
        ---          raise_application_error(-20001,'tetet');     
           IF v_err.err_msg IS NULL THEN 
           
           IF v_cus_qust.r_k IS NULL THEN
           
           DELETE FROM t_20_cus_qust WHERE cus_r_k = v_cus_qust.cus_r_k  AND qust_r_k = v_cus_qust.qust_r_k ;
           INSERT INTO t_20_cus_qust(r_k,cus_r_k,qust_r_k,qust_resp) 
                  VALUES
                  (v_cus_qust.r_k,v_cus_qust.cus_r_k,v_cus_qust.qust_r_k,v_cus_qust.qust_resp);
           ELSE
           
           UPDATE t_20_cus_qust SET  qust_resp =  v_cus_qust.qust_resp 
           WHERE cus_r_k = v_cus_qust.cus_r_k AND qust_r_k = v_cus_qust.qust_r_k;
           END IF;
           
           COMMIT;
           
           END IF;
         

         
         EXCEPTION WHEN OTHERS THEN 
           ROLLBACK; 
             pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
         
       END PC_20_CUS_QUST;
       
       
    --- Customer endorsement      
    PROCEDURE PC_20_CUS_INFO_EDT (p_cus IN v_20_cus_info%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
     
     v_cus     v_20_cus_info%ROWTYPE; 
     v_err     v_99_ssu_log%ROWTYPE; 
     v_bus_dt    v_99_ssu_pmv.v_d%TYPE;


     
       BEGIN
       
         v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
         
         v_cus.r_k     := p_cus.r_k; --s_20_cus_info.NEXTVAL;
         v_cus.lst_nm  := p_cus.lst_nm;
         v_cus.fst_nm  := p_cus.fst_nm;
         v_cus.mid_nm  := p_cus.mid_nm;
         v_cus.bth_pc  := p_cus.bth_pc;
         v_cus.occp    := p_cus.occp;
         v_cus.email   := p_cus.email;
         v_cus.phone   := p_cus.phone;
         v_cus.fax     := p_cus.fax;
         v_cus.addr    := p_cus.addr;
         v_cus.cus_tle := p_cus.cus_tle;
         v_cus.bnk_no  := p_cus.bnk_no;
         v_cus.dob     := p_cus.dob;
         
        
         
           IF v_err.err_msg IS NULL THEN 
               
           UPDATE  t_20_cus_info SET lst_nm = v_cus.lst_nm,  fst_nm = v_cus.fst_nm , mid_nm = v_cus.mid_nm,bth_pc = v_cus.bth_pc
                                    , occp = v_cus.occp, email = v_cus.email, phone = v_cus.phone ,fax = v_cus.fax, addr = v_cus.addr,cus_tle = v_cus.cus_tle,bnk_no = v_cus.bnk_no, dob =  v_cus.dob  
              WHERE r_k = v_cus.r_k;
                       
           COMMIT;
           
           END IF;
         
      
         
         EXCEPTION WHEN OTHERS THEN 
           ROLLBACK; 
             pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
 END PC_20_CUS_INFO_EDT;
	   





     --- Customer document 
     PROCEDURE PC_20_UW_CUS_DOC (p_cus_doc IN v_20_uw_cus_doc%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
     
      v_cus_doc  v_20_uw_cus_doc%ROWTYPE; 
      v_err       v_99_ssu_log%ROWTYPE; 
     
       BEGIN
       
         v_cus_doc.r_k             := p_cus_doc.r_k;
         v_cus_doc.cus_r_k         := p_cus_doc.cus_r_k;
         v_cus_doc.doc_tp          := p_cus_doc.doc_tp;
         v_cus_doc.doc_mimetype    := p_cus_doc.doc_mimetype;
         v_cus_doc.doc_blob        := p_cus_doc.doc_blob;
         v_cus_doc.doc_name        := p_cus_doc.doc_name;

 
                  
           IF v_err.err_msg IS NULL THEN 
           
           IF v_cus_doc.r_k IS NULL THEN
           INSERT INTO t_20_uw_cus_doc(r_k,cus_r_k,doc_tp,doc_mimetype,doc_blob,doc_name) 
                  VALUES
                  (v_cus_doc.r_k,v_cus_doc.cus_r_k,v_cus_doc.doc_tp,v_cus_doc.doc_mimetype,v_cus_doc.doc_blob,v_cus_doc.doc_name);
                  
           ELSE
           
           UPDATE t_20_uw_cus_doc SET  doc_tp =  v_cus_doc.doc_tp, doc_mimetype = v_cus_doc.doc_mimetype,
                                        doc_blob = v_cus_doc.doc_blob , doc_name = v_cus_doc.doc_name
           WHERE r_k = v_cus_doc.r_k AND cus_r_k = v_cus_doc.cus_r_k;
           
           END IF;
           
           COMMIT;
           
           END IF;
         

         
         EXCEPTION WHEN OTHERS THEN 
           ROLLBACK; 
             pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
         
       END PC_20_UW_CUS_DOC;
       
       
       
     --- Customer approval      
    PROCEDURE PC_20_CUS_INFO_APR (p_cus IN v_20_cus_info%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
     
     v_cus     v_20_cus_info%ROWTYPE; 
     v_err     v_99_ssu_log%ROWTYPE; 
     v_bus_dt    v_99_ssu_pmv.v_d%TYPE;


     
       BEGIN
       
         
         v_cus.r_k     := p_cus.r_k; --s_20_cus_info.NEXTVAL;
         v_cus.apr_by  := V('APP_USER');
         v_cus.apr_dt  := SYSDATE;
         v_cus.apr_sta  := 1;
 
        
         
           IF v_err.err_msg IS NULL THEN 
               
           UPDATE  t_20_cus_info SET apr_by = v_cus.apr_by,  apr_dt = v_cus.apr_dt , apr_sta = v_cus.apr_sta
              WHERE r_k = v_cus.r_k;
                       
           COMMIT;
           
           END IF;
         
      
         
         EXCEPTION WHEN OTHERS THEN 
           ROLLBACK; 
             pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
 END PC_20_CUS_INFO_APR;
 
 
 
      --- Delete Customer document 
     PROCEDURE PC_20_UW_CUS_DOC_DEL (p_cus_doc IN v_20_uw_cus_doc%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
     
      v_cus_doc  v_20_uw_cus_doc%ROWTYPE; 
      v_err       v_99_ssu_log%ROWTYPE; 
     
       BEGIN
       
         v_cus_doc.r_k             := p_cus_doc.r_k;


 
                  
           IF v_err.err_msg IS NULL THEN 
                     
           DELETE FROM t_20_uw_cus_doc WHERE r_k = v_cus_doc.r_k;  
		   
           COMMIT;
           
           END IF;
         

         
         EXCEPTION WHEN OTHERS THEN 
           ROLLBACK; 
             pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
         
       END PC_20_UW_CUS_DOC_DEL;
       
 
       
END PK_20_CUS_INFO;

/
