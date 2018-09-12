--------------------------------------------------------
--  DDL for Package Body PK_70_GL_RCPT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_GL_RCPT" AS

-- Author       : Gbenga Cruz 
-- Description  : Receipt Management
-- Date         : January 18, 2017 

     --- Receipt Creation
     PROCEDURE PC_70_GL_RCPT (p_rcpt IN v_70_gl_rcpt%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_rcpt      v_70_gl_rcpt%ROWTYPE;
		 v_cus_act   v_70_cus_act%ROWTYPE;
         v_err       v_99_ssu_log%ROWTYPE;

         CURSOR c_cus_act IS SELECT r_k FROM v_70_cus_act WHERE cus_r_k = p_rcpt.cus_r_k AND apr_sta =1 ;
        
         BEGIN
		           

         
             v_rcpt.r_k         := p_rcpt.r_k;
			 v_rcpt.cus_r_k     := p_rcpt.cus_r_k;
			 v_rcpt.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			 v_rcpt.sys_dtt     := SYSDATE;
			 v_rcpt.apr_sta     := 0;
			-- v_rcpt.apr_dt      := SYSDATE;
			-- v_rcpt.apr_by      := V('APP_USER');
			 v_rcpt.act_r_k     := p_rcpt.act_r_k;
			 v_rcpt.tran_desc   := p_rcpt.tran_desc;
			 v_rcpt.tran_amt    := p_rcpt.tran_amt;
             v_rcpt.ref_no      := p_rcpt.ref_no;
             v_rcpt.mode_pymt   := p_rcpt.mode_pymt;
             v_rcpt.tran_srce   := 1;
			 v_rcpt.dr_cr       := 'C';
			 v_rcpt.vchr_tp     := p_rcpt.vchr_tp;
             v_rcpt.act_r_k     := p_rcpt.act_r_k;
             v_rcpt.act_tp      := p_rcpt.act_tp;
             v_rcpt.cus_nm      := p_rcpt.cus_nm;
             v_rcpt.ldgr_key_dr := p_rcpt.ldgr_key_dr;
             
			     IF v_rcpt.act_tp = 1 THEN
			 
		             OPEN  c_cus_act;
			         FETCH c_cus_act INTO v_rcpt.act_r_k;
			         CLOSE c_cus_act;
			 
			         IF    v_rcpt.act_r_k IS NULL THEN 
                            v_err.err_cd := '-20026';
                            p_err_msg := v_err.err_msg; 
                           raise_application_error(v_err.err_cd ,p_err_msg);
                     END IF;
			 
                 END IF;
             
                                        
                         
                 IF v_err.err_msg IS NULL THEN

                     INSERT INTO T_70_GL_RCPT ( r_k, cus_r_k, act_r_k, bus_dt, sys_dtt, apr_sta, apr_by, tran_desc, tran_amt, 
                             					 ref_no, mode_pymt, apr_dt, tran_srce, dr_cr,act_tp,vchr_tp,cus_nm,ldgr_key_dr)
					                            VALUES 
												( v_rcpt.r_k, v_rcpt.cus_r_k, v_rcpt.act_r_k, v_rcpt.bus_dt, v_rcpt.sys_dtt, v_rcpt.apr_sta, v_rcpt.apr_by, v_rcpt.tran_desc, v_rcpt.tran_amt, 
                             					 v_rcpt.ref_no, v_rcpt.mode_pymt, v_rcpt.apr_dt, v_rcpt.tran_srce, v_rcpt.dr_cr,v_rcpt.act_tp,v_rcpt.vchr_tp,v_rcpt.cus_nm,v_rcpt.ldgr_key_dr);
                   
                 END IF;
		 
              
         COMMIT;
       EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_GL_RCPT;
    
    
         --- Receipt Approval
     PROCEDURE PC_70_GL_RCPT_APR (p_rcpt IN v_70_gl_rcpt%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_rcpt          v_70_gl_rcpt%ROWTYPE;
		 v_act_tran      v_70_cus_act_tran%ROWTYPE;
         v_err           v_99_ssu_log%ROWTYPE;
         v_gl_tran         v_70_gl_tran%ROWTYPE;

      
		 CURSOR c_rcpt IS SELECT cus_r_k, act_r_k, ref_no, tran_desc, tran_amt , mode_pymt, tran_srce, dr_cr, 
		                           vchr_tp,act_tp,apr_sta,ldgr_key_dr FROM v_70_gl_rcpt WHERE r_k = p_rcpt.r_k AND apr_sta = 0;
        
         BEGIN
				
				 
			  
			              				
             FOR i IN c_rcpt LOOP
			 
			     v_rcpt.cus_r_k     := i.cus_r_k;
			     v_rcpt.act_r_k     := i.act_r_k;
			     v_rcpt.tran_desc   := i.tran_desc;
			     v_rcpt.tran_amt    := i.tran_amt;
                 v_rcpt.ref_no      := i.ref_no;
                 v_rcpt.mode_pymt   := i.mode_pymt;
                 v_rcpt.tran_srce   := i.tran_srce;
			     v_rcpt.dr_cr       := i.dr_cr;
			     v_rcpt.vchr_tp     := i.vchr_tp;
                 v_rcpt.act_tp      := i.act_tp;
				 v_rcpt.apr_sta     := i.apr_sta;
                 v_rcpt.ldgr_key_dr := i.ldgr_key_dr;
				 
             END LOOP;
			 
			      IF     v_rcpt.apr_sta IS NULL THEN 
                            v_err.err_cd := '-20028';
                            p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                    END IF;
					
		     v_rcpt.r_k         := p_rcpt.r_k;  
			 v_rcpt.bus_dt      := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
			 v_rcpt.sys_dtt     := SYSDATE;
			 v_rcpt.apr_sta     := 1;
			 v_rcpt.apr_dt      := SYSDATE;
			 v_rcpt.apr_by      := V('APP_USER');
			
			 
	                                    
                         
                 IF v_err.err_msg IS NULL THEN

                    UPDATE T_70_GL_RCPT SET apr_sta = v_rcpt.apr_sta, apr_dt = v_rcpt.apr_dt, sys_dtt = v_rcpt.sys_dtt,bus_dt = v_rcpt.bus_dt, apr_by = v_rcpt.apr_by WHERE r_k = v_rcpt.r_k;
										                   
                 END IF;
				 
				 --- Transaction for customer account
		         IF v_rcpt.cus_r_k IS NOT NULL THEN
				 
				     v_act_tran.tran_desc  := v_rcpt.tran_desc ;
                     v_act_tran.cus_r_k    := v_rcpt.cus_r_k;
                     v_act_tran.tran_amt   := v_rcpt.tran_amt;
                     v_act_tran.tran_srce  := v_rcpt.tran_srce;
                     v_act_tran.ref_no     := v_rcpt.ref_no;
                     v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                     v_act_tran.dr_cr      := v_rcpt.dr_cr;
                     v_act_tran.tran_r_k   := v_rcpt.r_k;
                     v_act_tran.mode_pymt  := v_rcpt.mode_pymt;
                                         
                        IF v_err.err_msg IS NULL THEN
                            PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                           PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                        END IF;
                        
                       ---Credit GL Account with Receipt amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_rcpt.tran_amt;
                        v_gl_tran.tran_desc    := v_rcpt.tran_desc;
                        v_gl_tran.ldgr_key     := v_rcpt.act_r_k;
                        v_gl_tran.tran_srce    := 1;
                        v_gl_tran.tran_no      := v_rcpt.r_k ;
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                        ---Debit GL Bank Account with Receipt amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_rcpt.tran_amt;
                        v_gl_tran.tran_desc    := v_rcpt.tran_desc;
                        v_gl_tran.ldgr_key     := v_rcpt.ldgr_key_dr;
                        v_gl_tran.tran_srce    := 1;
                        v_gl_tran.tran_no      := v_rcpt.r_k ;
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
				 IF v_rcpt.cus_r_k  IS  NULL THEN
                 
                       ---Credit GL Account with Receipt amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_rcpt.tran_amt;
                        v_gl_tran.tran_desc    := v_rcpt.tran_desc;
                        v_gl_tran.ldgr_key     := v_rcpt.act_r_k;
                        v_gl_tran.tran_srce    := 1;
                        v_gl_tran.tran_no      := v_rcpt.r_k ;
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                         
                     ---Debit GL Bank Account with Receipt amount 
                        IF v_err.err_msg IS NULL THEN
                                                  
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_rcpt.tran_amt;
                        v_gl_tran.tran_desc    := v_rcpt.tran_desc;
                        v_gl_tran.ldgr_key     := v_rcpt.ldgr_key_dr;
                        v_gl_tran.tran_srce    := 1;
                        v_gl_tran.tran_no      := v_rcpt.r_k ;
                        
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
       EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_GL_RCPT_APR;
    
      --- Receipt Delete
     PROCEDURE PC_70_GL_RCPT_DEL (p_rcpt IN v_70_gl_rcpt%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

         v_rcpt          v_70_gl_rcpt%ROWTYPE;
         v_err           v_99_ssu_log%ROWTYPE;

      
		 CURSOR c_rcpt IS SELECT r_k, apr_sta FROM v_70_gl_rcpt WHERE r_k = p_rcpt.r_k;
        
         BEGIN
		      
			     OPEN  c_rcpt;
	             FETCH c_rcpt INTO v_rcpt.r_k,v_rcpt.apr_sta;
				 CLOSE c_rcpt;
			 
                IF       v_rcpt.apr_sta = 1  THEN 
                            v_err.err_cd := '-20027';
                            p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                END IF;				
	
			    IF v_rcpt.apr_sta  = 0 THEN
                       
                      IF v_err.err_msg IS NULL THEN
                        
						DELETE FROM t_70_gl_rcpt WHERE r_k = v_rcpt.r_k AND apr_sta = 0;
										                   
                      END IF;
					COMMIT;
				 
				END IF;
           
      EXCEPTION WHEN OTHERS THEN
         ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_GL_RCPT_DEL;
    
    
END PK_70_GL_RCPT;

/
