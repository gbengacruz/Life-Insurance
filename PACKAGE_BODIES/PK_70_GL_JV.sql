--------------------------------------------------------
--  DDL for Package Body PK_70_GL_JV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_GL_JV" AS

-- Author       : Gbenga Cruz 
-- Description  : Adjustment Voucher
-- Date         : January 18, 2017


	 --- GL Adjustment Journal
     PROCEDURE PC_70_GL_JV (p_gl_jv IN v_70_gl_jv%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
	 
	    v_gl_jv      v_70_gl_jv%ROWTYPE;
		v_err        v_99_ssu_log%ROWTYPE;
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
        v_jv           v_70_gl_jv.r_k%TYPE;
        
         CURSOR c_jv IS SELECT count(r_k) jv FROM v_70_gl_jv WHERE r_k = p_gl_jv.r_k AND apr_sta = 0;

		BEGIN
        
        
        OPEN  c_jv;
        FETCH c_jv INTO v_jv;
        CLOSE c_jv;
           
           
		     v_gl_jv.r_k              := p_gl_jv.r_k;
			 v_gl_jv.bus_dt           := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
		     v_gl_jv.sys_dtt          := SYSDATE;
			 v_gl_jv.apr_sta          := 0;
			 v_gl_jv.vchr_tp          := p_gl_jv.vchr_tp;
			 v_gl_jv.tran_desc        := p_gl_jv.tran_desc;

			 
			 IF v_err.err_msg IS NULL THEN
             
             IF  v_jv = 0 THEN
			 
			     INSERT INTO t_70_gl_jv(r_k,bus_dt,sys_dtt,apr_sta,vchr_tp,tran_desc) VALUES 
										  (v_gl_jv.r_k, v_gl_jv.bus_dt ,v_gl_jv.sys_dtt, v_gl_jv.apr_sta,v_gl_jv.vchr_tp,v_gl_jv.tran_desc  );
                                          
                                          ELSE
                                          
                 UPDATE   t_70_gl_jv SET bus_dt = v_gl_jv.bus_dt ,  tran_desc = v_gl_jv.tran_desc, sys_dtt = v_gl_jv.sys_dtt WHERE r_k = v_gl_jv.r_k;
                                          
                                          END IF;
		  
			 
			 END IF;
			 COMMIT;
             EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
        --  raise_application_error(v_err.err_cd ,p_err_msg);
	END PC_70_GL_JV;
    
    
    

	 --- GL Adjustment Journal transaction
     PROCEDURE PC_70_GL_JV_TRAN (p_gl_jv IN v_70_gl_jv_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
	 
	    v_gl_jv  t_70_gl_jv_tran%ROWTYPE;
		v_err         v_99_ssu_log%ROWTYPE;
        v_bus_dt      v_99_ssu_pmv.v_d%TYPE;
        v_jv           v_70_gl_jv.r_k%TYPE;
        
         CURSOR c_jv IS SELECT count(r_k) jv FROM v_70_gl_jv_tran WHERE r_k = p_gl_jv.r_k AND apr_sta = 0;
        
       

		BEGIN
           
        OPEN  c_jv;
        FETCH c_jv INTO v_jv;
        CLOSE c_jv;
           
           
		     v_gl_jv.r_k              := p_gl_jv.r_k;
			 v_gl_jv.bus_dt           := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
		     v_gl_jv.sys_dtt          := SYSDATE;
			 v_gl_jv.apr_sta          := 0;
			 v_gl_jv.ldgr_key         := p_gl_jv.ldgr_key;
			 v_gl_jv.tran_amt         := p_gl_jv.tran_amt ;
             v_gl_jv.tran_desc        := p_gl_jv.tran_desc;
             v_gl_jv.vchr_tp          := p_gl_jv.vchr_tp;
             v_gl_jv.dr_cr            := p_gl_jv.dr_cr;
             v_gl_jv.batch_no         := p_gl_jv.batch_no;
             v_gl_jv.tran_srce        := 6;

			 
			 IF v_err.err_msg IS NULL THEN
             
                 IF v_jv = 0 THEN
			 
			     INSERT INTO t_70_gl_jv_tran(r_k,ldgr_key,bus_dt,tran_amt,tran_desc,sys_dtt, vchr_tp,dr_cr, batch_no, apr_sta,tran_srce ) VALUES 
										  (v_gl_jv.r_k,v_gl_jv.ldgr_key,v_gl_jv.bus_dt,v_gl_jv.tran_amt,v_gl_jv.tran_desc,v_gl_jv.sys_dtt, v_gl_jv.vchr_tp,v_gl_jv.dr_cr, v_gl_jv.batch_no, v_gl_jv.apr_sta,v_gl_jv.tran_srce );
		         ELSE
                 
                UPDATE t_70_gl_jv_tran SET ldgr_key = v_gl_jv.ldgr_key, bus_dt = v_gl_jv.bus_dt, dr_cr = v_gl_jv.dr_cr, tran_amt = v_gl_jv.tran_amt, tran_desc = v_gl_jv.tran_desc, sys_dtt = v_gl_jv.sys_dtt
                       WHERE r_k = v_gl_jv.r_k;
                       
               END IF;
			 
			 END IF;
			 COMMIT;
             EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
        --  raise_application_error(v_err.err_cd ,p_err_msg);
	END PC_70_GL_JV_TRAN;
    


	 --- Approve Journal voucher
     PROCEDURE PC_70_GL_JV_TRAN_APR (p_jv_tran IN v_70_gl_jv_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
     
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
		v_jv_tran    v_70_gl_jv_tran%ROWTYPE; 
        v_act_tran   v_70_cus_act_tran%ROWTYPE;
        v_err        v_99_ssu_log%ROWTYPE;
        v_gl_tran    v_70_gl_tran%ROWTYPE;
        v_jv_dr      NUMBER;
        v_jv_cr      NUMBER;

        
        CURSOR  c_jv_val IS  SELECT nvl(sum(decode(dr_cr, 'D',tran_amt )),0) dr ,  nvl(sum(decode(dr_cr, 'C',tran_amt )),0) cr FROM v_70_gl_jv_tran WHERE apr_sta = 0 AND batch_no = p_jv_tran.batch_no;
        CURSOR  c_jv_tran IS SELECT  r_k,ldgr_key,tran_srce, tran_amt, tran_desc, vchr_tp, dr_cr  FROM  v_70_gl_jv_tran WHERE apr_sta = 0 AND batch_no = p_jv_tran.batch_no ;
        
           BEGIN

                 OPEN c_jv_val;
                 FETCH c_jv_val INTO v_jv_dr, v_jv_cr;
                 CLOSE c_jv_val;

                     IF v_jv_dr <> v_jv_cr THEN 
                            v_err.err_cd := '-20032';
                            p_err_msg := v_err.err_msg; 
                            raise_application_error(v_err.err_cd ,p_err_msg);
                     END IF;
                     
                     
               
           
           FOR i in c_jv_tran LOOP 

              v_jv_tran.r_k             := i.r_k;
              v_jv_tran.ldgr_key        := i.ldgr_key;
              v_jv_tran.tran_srce       := i.tran_srce;
		      v_jv_tran.tran_amt        := i.tran_amt;
              v_jv_tran.tran_desc       := i.tran_desc;
              v_jv_tran.vchr_tp         := i.vchr_tp;
		      v_jv_tran.sys_dtt         := sysdate;
              v_jv_tran.bus_dt          := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
              v_jv_tran.apr_by          :=  V('APP_USER');
              v_jv_tran.apr_dt          :=  sysdate;
              v_jv_tran.apr_sta         := 1;
              v_jv_tran.dr_cr           := i.dr_cr;



                                  
                v_act_tran.cus_r_k    := PK_70_CUS_ACT.FN_70_CUS_ACT_GET(v_jv_tran.ldgr_key);
    
                 -- Transaction for customer account
		         IF v_act_tran.cus_r_k IS NOT NULL THEN
				 
				     v_act_tran.tran_desc  := v_jv_tran.tran_desc ;
                    -- v_act_tran.cus_r_k    := PK_70_CUS_ACT.FN_70_CUS_ACT_GET(v_jv_tran.ldgr_key;
                     v_act_tran.tran_amt   := v_jv_tran.tran_amt;
                     v_act_tran.tran_srce  := v_jv_tran.tran_srce;
                     v_act_tran.ref_no     :=  p_jv_tran.batch_no;
                     v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                     v_act_tran.dr_cr      := v_jv_tran.dr_cr;
                     v_act_tran.tran_r_k   := v_jv_tran.r_k;
                     v_act_tran.mode_pymt  := v_jv_tran.mode_pymt;
                                         
                        IF v_err.err_msg IS NULL THEN
                            PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                           PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                        END IF;
                        
                       ---Post Journal Voucher amount to GL Account 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := v_jv_tran.dr_cr;
                        v_gl_tran.tran_amt     := v_jv_tran.tran_amt;
                        v_gl_tran.tran_desc    := v_jv_tran.tran_desc;
                        v_gl_tran.ldgr_key     := v_jv_tran.ldgr_key;
                        v_gl_tran.tran_srce    := v_jv_tran.tran_srce;
                        v_gl_tran.tran_no      := v_jv_tran.r_k ;
                        v_gl_tran.TRAN_BTCH_NO  := p_jv_tran.batch_no;
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                   
                        
                            IF v_err.err_msg IS NOT NULL THEN
                             v_err.err_cd := '-20099';
                            p_err_msg := v_err.err_msg; 
                            ROLLBACK;
                            raise_application_error(v_err.err_cd ,p_err_msg);
                            END IF;
                          
               END IF;
               
               
                 ---Transaction Direct Account
				 IF v_act_tran.cus_r_k  IS  NULL THEN
                 
                       ---Post Journal Voucher amount to GL Account
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := v_jv_tran.dr_cr;
                        v_gl_tran.tran_amt     := v_jv_tran.tran_amt;
                        v_gl_tran.tran_desc    := v_jv_tran.tran_desc;
                        v_gl_tran.ldgr_key     := v_jv_tran.ldgr_key;
                        v_gl_tran.tran_srce    := v_jv_tran.tran_srce;
                        v_gl_tran.tran_no      := v_jv_tran.r_k ;
                        v_gl_tran.TRAN_BTCH_NO     := p_jv_tran.batch_no;
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                         
                                           
                END IF;
                 
                            IF v_err.err_msg IS NOT NULL THEN
                             v_err.err_cd := '-20099';
                            p_err_msg := v_err.err_msg; 
                            ROLLBACK;
                            raise_application_error(v_err.err_cd ,p_err_msg);
                            END IF;
                 


                


        END LOOP;
        
                       --- Update Journal Voucher master
                       
                IF v_err.err_msg IS NULL THEN
             
              v_jv_tran.sys_dtt         := sysdate;
              v_jv_tran.bus_dt          := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
              v_jv_tran.apr_by          :=  V('APP_USER');
              v_jv_tran.apr_dt          :=  sysdate;
              v_jv_tran.apr_sta         := 1;

                    UPDATE t_70_gl_jv SET apr_sta = v_jv_tran.apr_sta, apr_dt = v_jv_tran.apr_dt, sys_dtt = v_jv_tran.sys_dtt,bus_dt = v_jv_tran.bus_dt
                                                 , apr_by = v_jv_tran.apr_by WHERE r_k = p_jv_tran.batch_no;
                                                 
                     UPDATE t_70_gl_jv_tran SET apr_sta = v_jv_tran.apr_sta, apr_dt = v_jv_tran.apr_dt, sys_dtt = v_jv_tran.sys_dtt,bus_dt = v_jv_tran.bus_dt
                                                 , apr_by = v_jv_tran.apr_by WHERE batch_no = p_jv_tran.batch_no;
										                   
                 END IF;
    
    
             COMMIT;
                 EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
             
     END PC_70_GL_JV_TRAN_APR;
         
END PK_70_GL_JV;

/
