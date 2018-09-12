--------------------------------------------------------
--  DDL for Package Body PK_70_BRK_PYMT_TRAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_BRK_PYMT_TRAN" AS
-- Author       : Gbenga Cruz 
-- Description  : Bank Payment Process
-- Date         : January 18, 2018




	 --- Post Bank Payment 
     PROCEDURE PC_70_BRK_PYMT_TRAN (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
	 
	    v_gl_tran    v_70_gl_tran%ROWTYPE;
		v_err        v_99_ssu_log%ROWTYPE;
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
		v_brk_pymt   v_70_brk_pymt_tran%ROWTYPE; 
		
		CURSOR c_cus_act IS SELECT  r_k FROM v_70_cus_act WHERE cus_r_k = p_brk_pymt.cus_r_k;
		BEGIN
        
        v_brk_pymt.cus_acc_r_k := p_brk_pymt.cus_acc_r_k;
        
         IF p_brk_pymt.cus_acc_r_k IS NULL THEN
           OPEN c_cus_act;
           FETCH c_cus_act INTO v_brk_pymt.cus_acc_r_k;
           CLOSE c_cus_act;
         END IF;
         
		     v_brk_pymt.r_k            := p_brk_pymt.r_k;
			 v_brk_pymt.bus_dt         := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
		     v_brk_pymt.sys_dtt        := SYSDATE;
			 v_brk_pymt.apr_sta        := 0;
			 v_brk_pymt.pymt_r_k       := p_brk_pymt.pymt_r_k;
             v_brk_pymt.cus_r_k        := p_brk_pymt.cus_r_k;
             v_brk_pymt.ldgr_key_cr    := p_brk_pymt.ldgr_key_cr;
             v_brk_pymt.pymt_ref        := p_brk_pymt.pymt_ref;
             v_brk_pymt.mode_pymt       := p_brk_pymt.mode_pymt;
             v_brk_pymt.vchr_tp         := p_brk_pymt.vchr_tp;
             
             IF p_brk_pymt.cus_acc_r_k IS NOT NULL THEN 
             v_brk_pymt.cus_acc_r_k    := p_brk_pymt.cus_acc_r_k;
             END IF;
			 v_brk_pymt.drcr           := p_brk_pymt.drcr;
			 v_brk_pymt.tran_srce      := p_brk_pymt.tran_srce;
			 v_brk_pymt.pol_r_k        := p_brk_pymt.pol_r_k;
			 v_brk_pymt.clm_r_k        := p_brk_pymt.clm_r_k;
			 v_brk_pymt.pymt_amt       := p_brk_pymt.pymt_amt;
			 v_brk_pymt.tran_desc      := p_brk_pymt.tran_desc;
             v_brk_pymt.due_dt         := p_brk_pymt.due_dt;
			 
			 
			     IF v_err.err_msg IS NULL THEN
			 
			          INSERT INTO t_70_brk_pymt_tran(r_k,bus_dt,sys_dtt,apr_sta,pymt_r_k,cus_acc_r_k,cus_r_k,drcr,tran_srce,pol_r_k,clm_r_k,pymt_amt,tran_desc,due_dt,ldgr_key_cr,pymt_ref,mode_pymt,vchr_tp)
                                				     VALUES 
										            (v_brk_pymt.r_k,v_brk_pymt.bus_dt,v_brk_pymt.sys_dtt,v_brk_pymt.apr_sta,v_brk_pymt.pymt_r_k,v_brk_pymt.cus_acc_r_k
										             ,v_brk_pymt.cus_r_k,v_brk_pymt.drcr,v_brk_pymt.tran_srce,v_brk_pymt.pol_r_k,v_brk_pymt.clm_r_k,v_brk_pymt.pymt_amt,v_brk_pymt.tran_desc,v_brk_pymt.due_dt,v_brk_pymt.ldgr_key_cr,v_brk_pymt.pymt_ref,v_brk_pymt.mode_pymt,v_brk_pymt.vchr_tp);
		  
			 
			     END IF;
			 
             EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
             
	END PC_70_BRK_PYMT_TRAN;
    
    
	 --- Post Bank Payment approval
     PROCEDURE PC_70_BRK_PYMT_TRAN_APR (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
     
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
		v_brk_pymt   v_70_brk_pymt_tran%ROWTYPE; 
        v_act_tran   v_70_cus_act_tran%ROWTYPE;
        v_err        v_99_ssu_log%ROWTYPE;
        v_gl_tran    v_70_gl_tran%ROWTYPE;

        
        CURSOR c_pymt IS SELECT cus_r_k, cus_acc_r_k,pymt_ref,tran_desc,pymt_amt,mode_pymt,tran_srce,drcr,ldgr_key_cr,apr_sta FROM  v_70_brk_pymt_tran WHERE apr_sta = 0 AND r_k = p_brk_pymt.r_k;
        
           BEGIN
           
                    FOR i in c_pymt LOOP 

                        v_brk_pymt.cus_r_k         := i.cus_r_k;
                        v_brk_pymt.cus_acc_r_k     := i.cus_acc_r_k;
                        v_brk_pymt.pymt_ref        := i.pymt_ref;
			            v_brk_pymt.tran_desc       := i.tran_desc;
                        v_brk_pymt.pymt_amt        := i.pymt_amt;
                        v_brk_pymt.mode_pymt       := i.mode_pymt;
			            v_brk_pymt.tran_srce       := i.tran_srce;
			            v_brk_pymt.drcr            := i.drcr;
                        v_brk_pymt.ldgr_key_cr     := i.ldgr_key_cr;
                        v_brk_pymt.apr_sta         := i.apr_sta;
          
                   END LOOP;
                   
                   v_brk_pymt.pymt_ref        := p_brk_pymt.pymt_ref;
                   v_brk_pymt.ldgr_key_cr     := p_brk_pymt.ldgr_key_cr;
                   v_brk_pymt.mode_pymt       := p_brk_pymt.mode_pymt;
                   v_brk_pymt.vchr_tp         := p_brk_pymt.vchr_tp;
                  v_brk_pymt.tran_btch_no     := p_brk_pymt.tran_btch_no;

                   
                   
                   IF     v_brk_pymt.apr_sta IS NULL THEN 
                            v_err.err_cd := '-20028';
                            p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                    END IF;
           
                   
                        v_brk_pymt.r_k         := p_brk_pymt.r_k;  
                        v_brk_pymt.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			            v_brk_pymt.sys_dtt     := SYSDATE;
			            v_brk_pymt.apr_sta     := 1;
			            v_brk_pymt.apr_dt      := SYSDATE;
			            v_brk_pymt.apr_by      := V('APP_USER');
                        
                IF v_err.err_msg IS NULL THEN

                    UPDATE t_70_brk_pymt_tran SET apr_sta = v_brk_pymt.apr_sta, apr_dt = v_brk_pymt.apr_dt, sys_dtt = v_brk_pymt.sys_dtt,bus_dt = v_brk_pymt.bus_dt
                                                 , apr_by = v_brk_pymt.apr_by, pymt_ref = v_brk_pymt.pymt_ref, ldgr_key_cr = v_brk_pymt.ldgr_key_cr, mode_pymt = v_brk_pymt.mode_pymt ,vchr_tp = v_brk_pymt.vchr_tp,tran_btch_no = v_brk_pymt.tran_btch_no WHERE r_k = v_brk_pymt.r_k;
										                   
                 END IF;
    
    
    
                 -- Transaction for customer account
		         IF v_brk_pymt.cus_r_k IS NOT NULL THEN
				 
				     v_act_tran.tran_desc  := v_brk_pymt.tran_desc ;
                     v_act_tran.cus_r_k    := v_brk_pymt.cus_r_k;
                     v_act_tran.tran_amt   := v_brk_pymt.pymt_amt;
                     v_act_tran.tran_srce  := v_brk_pymt.tran_srce;
                     v_act_tran.ref_no     := v_brk_pymt.pymt_ref;
                     v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                     v_act_tran.dr_cr      := v_brk_pymt.drcr;
                     v_act_tran.tran_r_k   := v_brk_pymt.r_k;
                     v_act_tran.mode_pymt  := v_brk_pymt.mode_pymt;
                                         
                        IF v_err.err_msg IS NULL THEN
                            PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                           PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                        END IF;
                        
                       ---Debit GL Account with Payment amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_brk_pymt.pymt_amt;
                        v_gl_tran.tran_desc    := v_brk_pymt.tran_desc;
                        v_gl_tran.ldgr_key     := v_brk_pymt.cus_acc_r_k;
                        v_gl_tran.tran_srce    := 5;
                        v_gl_tran.tran_no      := v_brk_pymt.r_k ;
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                        ---Credit GL Bank Account with payment amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_brk_pymt.pymt_amt;
                        v_gl_tran.tran_desc    := v_brk_pymt.tran_desc;
                        v_gl_tran.ldgr_key     := v_brk_pymt.ldgr_key_cr;
                        v_gl_tran.tran_srce    := 5;
                        v_gl_tran.tran_no      := v_brk_pymt.r_k ;
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
				 IF v_brk_pymt.cus_r_k  IS  NULL THEN
                 
                       ---Debit GL Account with payment amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_brk_pymt.pymt_amt;
                        v_gl_tran.tran_desc    := v_brk_pymt.tran_desc;
                        v_gl_tran.ldgr_key     := v_brk_pymt.cus_acc_r_k;
                        v_gl_tran.tran_srce    := 5;
                        v_gl_tran.tran_no      := v_brk_pymt.r_k ;
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                         
                       ---Credit GL Bank Account with payment amount 
                       
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_brk_pymt.pymt_amt;
                        v_gl_tran.tran_desc    := v_brk_pymt.tran_desc;
                        v_gl_tran.ldgr_key     := v_brk_pymt.ldgr_key_cr;
                        v_gl_tran.tran_srce    := 5;
                        v_gl_tran.tran_no      := v_brk_pymt.r_k ;
                        
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                 
                            IF v_err.err_msg IS NOT NULL THEN
                             v_err.err_cd := '-20099';
                            p_err_msg := v_err.err_msg; 
                            ROLLBACK;
                            raise_application_error(v_err.err_cd ,p_err_msg);
                            END IF;
                 END IF;
                 COMMIT;
             
             
     END PC_70_BRK_PYMT_TRAN_APR;
     
     
     
     
	 --- Cancel Bank Payment 
     PROCEDURE PC_70_BRK_PYMT_TRAN_CNL (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
	 
	    v_gl_tran    v_70_gl_tran%ROWTYPE;
		v_err        v_99_ssu_log%ROWTYPE;
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
		v_brk_pymt   v_70_brk_pymt_tran%ROWTYPE; 
		
		BEGIN
        
      
      
         
			 v_brk_pymt.bus_dt         := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
		     v_brk_pymt.sys_dtt        := SYSDATE;
      		 v_brk_pymt.pol_r_k        := p_brk_pymt.pol_r_k;
			 v_brk_pymt.pymt_r_k       := p_brk_pymt.tran_desc;
			 v_brk_pymt.apr_sta        :=9;
			 
			 
			     IF v_err.err_msg IS NULL THEN
			 
			         UPDATE t_70_brk_pymt_tran SET sys_dtt =  v_brk_pymt.sys_dtt , bus_dt = v_brk_pymt.bus_dt, apr_sta = v_brk_pymt.apr_sta

                           WHERE  pol_r_k = v_brk_pymt.pol_r_k AND pymt_r_k = v_brk_pymt.pymt_r_k AND apr_sta = 0;
			 
			 
			   
			     END IF;
			 
             EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
             
	END PC_70_BRK_PYMT_TRAN_CNL;
    
    
    
    	 --- Update Bank Payment 
     PROCEDURE PC_70_BRK_PYMT_TRAN_UPD (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
     
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
		v_brk_pymt   v_70_brk_pymt_tran%ROWTYPE; 
        v_act_tran   v_70_cus_act_tran%ROWTYPE;
        v_err        v_99_ssu_log%ROWTYPE;
        v_gl_tran    v_70_gl_tran%ROWTYPE;

        
        
           BEGIN
           
             
                   
                   v_brk_pymt.pymt_ref        := p_brk_pymt.pymt_ref;
                   v_brk_pymt.ldgr_key_cr     := p_brk_pymt.ldgr_key_cr;
                   v_brk_pymt.mode_pymt       := p_brk_pymt.mode_pymt;
                   v_brk_pymt.vchr_tp         := p_brk_pymt.vchr_tp;
  
                   
                        v_brk_pymt.r_k         := p_brk_pymt.r_k;  
                        v_brk_pymt.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			            v_brk_pymt.sys_dtt     := SYSDATE;
			            v_brk_pymt.apr_dt      := SYSDATE;
			            v_brk_pymt.apr_by      := V('APP_USER');
                        
                IF v_err.err_msg IS NULL THEN

                    UPDATE t_70_brk_pymt_tran SET  sys_dtt = v_brk_pymt.sys_dtt,bus_dt = v_brk_pymt.bus_dt
                                                 , pymt_ref = v_brk_pymt.pymt_ref, ldgr_key_cr = v_brk_pymt.ldgr_key_cr, mode_pymt = v_brk_pymt.mode_pymt ,vchr_tp = v_brk_pymt.vchr_tp WHERE r_k = v_brk_pymt.r_k;
										                   
                 END IF;
    
    
                 COMMIT;
             
             
     END PC_70_BRK_PYMT_TRAN_UPD;
    
END PK_70_BRK_PYMT_TRAN;

/
