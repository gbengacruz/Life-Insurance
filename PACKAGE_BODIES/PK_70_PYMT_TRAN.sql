--------------------------------------------------------
--  DDL for Package Body PK_70_PYMT_TRAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_PYMT_TRAN" AS

-- Author       : Gbenga Cruz 
-- Description  : Policy Management
-- Date         : January 18, 2017 
 
  --- Payments
 PROCEDURE PC_70_PYMT_TRAN (p_pymt_tran IN v_70_pymt_tran%ROWTYPE,p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_pymt_tran       v_70_pymt_tran%ROWTYPE;
       v_err             v_99_ssu_log%ROWTYPE;
       v_pol_dtl         v_20_uw_pol_dtl%ROWTYPE;
	   v_add_mon         NUMBER:=12;
       v_bus_dt         v_99_ssu_pmv.v_d%TYPE;
     
         CURSOR c_pol_dtl IS SELECT r_k, pol_no, prd_r_k, prd_term, si_amt, mns_pymt, insr_r_k, pymt_r_k, cus_r_k, prm_amt,
                               st_dt, en_dt, bus_dt, pol_sta, apr_sta, term_id, pymt_feq, pymt_id,sngl_id FROM v_20_uw_pol_dtl where r_k = p_uw_pol.r_k;
         BEGIN
            
             FOR i IN  c_pol_dtl LOOP
                 
                 v_pol_dtl.r_k      := i.r_k;
                 v_pol_dtl.term_id  := i.term_id;
			     v_pol_dtl.pymt_id  := i.pymt_id;
				 v_pol_dtl.insr_r_k := i.insr_r_k;
				 v_pol_dtl.prm_amt  := i.prm_amt;
				 v_pol_dtl.st_dt    := i.st_dt;
                 v_pol_dtl.pol_no   := i.pol_no;
                 v_pol_dtl.sngl_id   := i.sngl_id;
                
				 
             END LOOP;
             
               IF p_pymt_tran.tran_tp = 1 THEN 
              
               v_pol_dtl.prm_amt := p_pymt_tran.pymt_amt;
               v_pol_dtl.st_dt  := SYSDATE;
               
               END IF;
             
             v_pymt_tran.sys_dtt    := SYSDATE;
             v_pymt_tran.tran_desc  := 'Premium due for Policy ' ||v_pol_dtl.pol_no ;
             v_bus_dt               := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 
             v_pymt_tran.bus_dt     := v_bus_dt;
             v_pymt_tran.apr_sta    := 0;
             
             IF v_err.err_msg IS NULL THEN

               INSERT INTO t_70_pymt_tran(r_k, cus_acc_r_k, cus_r_k, drcr, tran_tp, apr_sta, bus_dt, due_dt,pymt_amt,tran_desc,pol_r_k, sys_dtt)
                     VALUES
                    (v_pymt_tran.r_k, NULL, v_pol_dtl.insr_r_k,NULL , NULL, 0, v_pymt_tran.bus_dt, v_pol_dtl.st_dt,v_pol_dtl.prm_amt, v_pymt_tran.tran_desc, v_pol_dtl.r_k, v_pymt_tran.sys_dtt );

            
		   
		     v_pol_dtl.term_id := ((v_pol_dtl.term_id * v_pol_dtl.pymt_id) - 1);
			 v_add_mon         := (v_add_mon/v_pol_dtl.pymt_id);
             
             --Non Single payment
             IF v_pol_dtl.sngl_id <> 1 THEN
             
               FOR i IN 1..v_pol_dtl.term_id LOOP
			 
                  v_pol_dtl.st_dt := add_months(v_pol_dtl.st_dt, v_add_mon);
				 
				     INSERT INTO t_70_pymt_tran(r_k, cus_acc_r_k, cus_r_k, drcr, tran_tp, apr_sta, bus_dt, due_dt, pymt_amt,tran_desc,pol_r_k)
                                 VALUES
                    (v_pymt_tran.r_k, NULL, v_pol_dtl.insr_r_k, NULL, NULL, 0, v_pymt_tran.bus_dt, v_pol_dtl.st_dt, v_pol_dtl.prm_amt, v_pymt_tran.tran_desc,v_pol_dtl.r_k );

                 COMMIT;
               END LOOP;
             
             END IF;
            
             COMMIT;
  
             END IF;
		   

       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_PYMT_TRAN;
    
    
    
  --- Payments Approval
     PROCEDURE PC_70_PYMT_TRAN_APR (p_pymt_tran IN v_70_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE)      AS
         v_cus_act         v_70_cus_act%ROWTYPE;
		 v_pymt_tran       v_70_pymt_tran%ROWTYPE;
         v_pymt_comm_tran  v_70_pymt_comm_tran%ROWTYPE;
         v_uw_pol          v_20_uw_pol%ROWTYPE;
         v_err             v_99_ssu_log%ROWTYPE;
         v_min_dt          v_70_pymt_tran.due_dt%TYPE;
         v_pymt_yr         NUMBER;
         v_comm_rt         NUMBER;
         v_bus_dt          v_99_ssu_pmv.v_d%TYPE;
         v_act_tran        v_70_cus_act_tran%ROWTYPE;
         v_dec             v_99_ssu_pmv.v_v%TYPE;
         v_gl_tran         v_70_gl_tran%ROWTYPE;
         v_act_ctl         v_70_gl_act_ctl%rowtype;
         v_prm_act_catg    NUMBER:= 10042;
         v_brk_pymt       v_70_brk_pymt_tran%ROWTYPE;
         
		 CURSOR c_cus_act IS SELECT tran_bal , r_k FROM v_70_cus_act WHERE cus_r_k = p_pymt_tran.cus_r_k;
         CURSOR c_pymt_tran IS SELECT MIN(due_dt) due_dt FROM v_70_pymt_tran WHERE pol_r_k = p_pymt_tran.pol_r_k;
        -- CURSOR c_pymt_tran_row IS SELECT pymt_amt, due_dt, cus_r_k FROM v_70_pymt_tran WHERE r_k = p_pymt_tran.r_k;
         CURSOR c_uw_pol IS SELECT prd_r_k, prd_term , cus_r_k, pol_no FROM v_20_uw_pol where r_k = p_pymt_tran.pol_r_k;
         CURSOR c_pmv IS SELECT v_v FROM v_99_ssu_pmv WHERE r_k =  70 AND v_yn = 1;
         
         BEGIN
         
             OPEN  c_pmv;
             FETCH c_pmv INTO v_dec;
             CLOSE c_pmv;

		     OPEN c_cus_act;
			 FETCH c_cus_act INTO v_cus_act.tran_bal,v_cus_act.r_k;
			 CLOSE c_cus_act;
             
             OPEN c_pymt_tran;
             FETCH c_pymt_tran INTO v_min_dt;
             CLOSE c_pymt_tran;
             
             OPEN c_uw_pol;
             FETCH c_uw_pol INTO v_uw_pol.prd_r_k,v_uw_pol.prd_term, v_uw_pol.cus_r_k, v_uw_pol.pol_no;
             CLOSE c_uw_pol;
             
            /* OPEN c_pymt_tran_row;
             FETCH c_pymt_tran_row INTO v_pymt_tran.pymt_amt,v_pymt_tran.due_dt, v_pymt_tran.cus_r_k;
             CLOSE c_pymt_tran_row;
			*/ 
                 v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
                 
			     v_pymt_tran.r_k            := p_pymt_tran.r_k;
                 v_pymt_tran.pymt_amt       := p_pymt_tran.pymt_amt;
                 v_pymt_tran.due_dt         := p_pymt_tran.due_dt;
                 v_pymt_tran.cus_r_k        := p_pymt_tran.cus_r_k;
                 v_pymt_tran.pol_r_k        := p_pymt_tran.pol_r_k;
                 v_pymt_tran.bus_dt         := v_bus_dt;
              --   v_pymt_comm_tran.tran_desc := 'Commission for policy' || ' ' || v_uw_pol.pol_no;
                 v_pymt_tran.apr_dt         :=  SYSDATE;
                 v_pymt_tran.apr_sta        :=  1;
                 v_pymt_tran.apr_by         := V('APP_USER');
                 v_pymt_tran.sys_dtt    := SYSDATE;
                 
                 
                 
                 IF v_uw_pol.cus_r_k  IS NOT NULL THEN 
                 
                 v_pymt_yr := CEIL((to_date(v_pymt_tran.due_dt) - to_date( v_min_dt) + 1) / 365);
     
                 
                 FOR i IN (SELECT comm_rt FROM v_70_pymt_comm WHERE  
                                          term_r_k = v_uw_pol.prd_term 
                                         AND prd_r_k = v_uw_pol.prd_r_k 
                                         AND prm_yr = v_pymt_yr)
                 LOOP
                   
                   v_comm_rt := i.comm_rt;
                   v_comm_rt :=  ROUND(v_comm_rt * v_pymt_tran.pymt_amt, v_dec);
                
                           
                   END LOOP;                     
                 
                 END IF; 
                 
                 v_pymt_comm_tran.tran_desc := 'Premium Due on '|| v_pymt_tran.due_dt||' for policy '|| v_uw_pol.pol_no;
                 v_act_tran.cus_r_k    := v_pymt_tran.cus_r_k;
                 v_act_tran.tran_desc  := v_pymt_comm_tran.tran_desc;
                 v_act_tran.tran_amt   := v_pymt_tran.pymt_amt;
                 v_act_tran.tran_srce  := 3;
                 v_act_tran.ref_no     := v_pymt_tran.pol_r_k;
                 v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                 v_act_tran.dr_cr      := 'D';
                 v_act_tran.tran_r_k   := v_pymt_tran.r_k ;
               
               /*  
                 IF v_pymt_tran.cus_r_k  IS NOT NULL THEN   
                     IF v_comm_rt IS NULL THEN
                       
                          v_err.err_cd := '-20024';
                          p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                     END IF;
                 END IF;
                 */
                  --- Approve Premium
			     IF v_cus_act.tran_bal >= v_pymt_tran.pymt_amt THEN
			 
		             IF v_err.err_msg IS NULL THEN

                     UPDATE t_70_pymt_tran SET apr_sta = v_pymt_tran.apr_sta, apr_dt = v_pymt_tran.apr_dt, sys_dtt = v_pymt_tran.sys_dtt,bus_dt = v_pymt_tran.bus_dt , apr_by = v_pymt_tran.apr_by  WHERE r_k = v_pymt_tran.r_k;
		             
                        IF v_err.err_msg IS NULL THEN
                            PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                           PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        --- Credit GL Account with Premium 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_pymt_tran.pymt_amt;
                        v_gl_tran.tran_desc    := v_act_tran.tran_desc;
                        v_gl_tran.prd_r_k      := v_uw_pol.prd_r_k;
                        v_act_ctl.prd_r_k      := v_gl_tran.prd_r_k;
                        v_act_ctl.act_catg     := v_prm_act_catg ;
                        v_gl_tran.ldgr_key     := PK_70_GL_TRAN.FN_70_GL_ACT_CTL(v_act_ctl);
                        v_gl_tran.tran_srce    := 3;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ;     
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                                     
                        END IF;
                        
                       --- Debit Customer GL Account with Premium 

                       IF v_err.err_msg IS NULL THEN
                        
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_pymt_tran.pymt_amt;
                        v_gl_tran.tran_desc    := v_act_tran.tran_desc;
                        v_gl_tran.ldgr_key     := v_cus_act.r_k;
                        v_gl_tran.tran_srce    := 3;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ;     
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                             IF v_err.err_msg IS NOT NULL THEN
                          
                            v_err.err_cd := '-20099';
                            p_err_msg := v_err.err_msg; 
                            ROLLBACK;
                            raise_application_error(v_err.err_cd ,p_err_msg);
                       
                          END IF;
                    --- Generate Commission    
                   IF v_uw_pol.cus_r_k  IS NOT NULL AND v_comm_rt IS NOT NULL  THEN 
                       v_pymt_comm_tran.tran_desc := 'Commission due on ' ||v_pymt_tran.due_dt ||' for policy ' || v_uw_pol.pol_no;
                       v_pymt_comm_tran.pymt_r_k  := v_pymt_tran.r_k;
                       v_act_tran.cus_r_k    := v_uw_pol.cus_r_k;
                       v_act_tran.tran_desc  := v_pymt_comm_tran.tran_desc;
                       v_act_tran.tran_amt   := v_comm_rt;
                       v_act_tran.tran_srce  := 2;
                       v_act_tran.ref_no     := v_pymt_tran.pol_r_k;
                       v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                       v_act_tran.dr_cr      := 'C';
                                         
                        INSERT INTO t_70_pymt_comm_tran (r_k, cus_acc_r_k, cus_r_k, pol_r_k, pymt_amt, apr_sta,due_dt,bus_dt,tran_desc,apr_dt,sys_dtt,apr_by,pymt_r_k)
                                                      VALUES
                                                      (v_pymt_comm_tran.r_k,null,v_uw_pol.cus_r_k,v_pymt_tran.pol_r_k,v_comm_rt, v_pymt_tran.apr_sta,v_pymt_tran.due_dt,v_pymt_tran.bus_dt,v_pymt_comm_tran.tran_desc,v_pymt_tran.apr_dt,v_pymt_tran.sys_dtt,v_pymt_tran.apr_by,v_pymt_comm_tran.pymt_r_k);
                      
                           
                        IF v_err.err_msg IS NULL THEN
                        PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                        PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                    
                        END IF;
                        
                      
                        --- Debit GL Account with Commission 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_act_tran.tran_amt;
                        v_gl_tran.tran_desc    := v_act_tran.tran_desc;
                        v_gl_tran.prd_r_k      := v_uw_pol.prd_r_k;
                        v_act_ctl.prd_r_k      := v_gl_tran.prd_r_k;
                        v_act_ctl.act_catg     := 10050;
                        v_gl_tran.ldgr_key     := PK_70_GL_TRAN.FN_70_GL_ACT_CTL(v_act_ctl);
                        v_gl_tran.tran_srce    := 2;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ; 
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                        
                        --- Post bank payment for  Commission 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_brk_pymt.drcr         := 'D';
                        v_brk_pymt.pymt_amt     := v_act_tran.tran_amt;
                        v_brk_pymt.tran_desc    := v_act_tran.tran_desc;
                        v_brk_pymt.pymt_r_k     := v_pymt_tran.r_k;
                        v_brk_pymt.pol_r_k      := v_pymt_tran.pol_r_k;
                        v_brk_pymt.cus_r_k      := v_act_tran.cus_r_k;
                        v_brk_pymt.tran_srce    := 2;
                        v_brk_pymt.due_dt       := SYSDATE;
                        PK_70_BRK_PYMT_TRAN.PC_70_BRK_PYMT_TRAN(v_brk_pymt,v_err.err_msg);
                        
                        END IF;
                        
                         --- Post Commission to Customer GL Account payment 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_cus_act.cus_r_k := v_act_tran.cus_r_k;
                        
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_act_tran.tran_amt;
                        v_gl_tran.tran_desc    :=  v_act_tran.tran_desc;
                        v_gl_tran.ldgr_key     := PK_70_GL_TRAN.FN_70_GL_CUS_ACT(v_cus_act);
                        v_gl_tran.tran_srce    := 2;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ;     
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
                       
		             END IF;
			     ELSE

                 v_err.err_cd := '-20023';
                 p_err_msg := v_err.err_msg;
                 ROLLBACK;
                 raise_application_error(v_err.err_cd ,p_err_msg);
				 
		         END IF;
		 
	  EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
           
     END PC_70_PYMT_TRAN_APR;
	 
     
  --- Delete Payments
 PROCEDURE PC_70_PYMT_TRAN_DEL (p_pymt_tran IN v_70_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_pymt_tran       v_70_pymt_tran%ROWTYPE;
       v_err             v_99_ssu_log%ROWTYPE;
       v_bus_dt         v_99_ssu_pmv.v_d%TYPE;
     

         BEGIN
            
             v_pymt_tran.pol_r_k := p_pymt_tran.pol_r_k;
             
             
             
             IF v_err.err_msg IS NULL THEN

                DELETE FROM t_70_pymt_tran WHERE pol_r_k = v_pymt_tran.pol_r_k AND apr_sta = 0;
  
             END IF;
		   

       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;

    END PC_70_PYMT_TRAN_DEL;
    

  --- Cancel Payments Approval
     PROCEDURE PC_70_PYMT_TRAN_APR_CNL (p_pymt_tran IN v_70_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE)      AS
         v_cus_act         v_70_cus_act%ROWTYPE;
		 v_pymt_tran       v_70_pymt_tran%ROWTYPE;
         v_pymt_comm_tran  v_70_pymt_comm_tran%ROWTYPE;
         v_uw_pol          v_20_uw_pol%ROWTYPE;
         v_err             v_99_ssu_log%ROWTYPE;
         v_min_dt          v_70_pymt_tran.due_dt%TYPE;
         v_pymt_yr         NUMBER;
         v_comm_rt         NUMBER;
         v_bus_dt          v_99_ssu_pmv.v_d%TYPE;
         v_act_tran        v_70_cus_act_tran%ROWTYPE;
         v_dec             v_99_ssu_pmv.v_v%TYPE;
         v_gl_tran         v_70_gl_tran%ROWTYPE;
         v_act_ctl         v_70_gl_act_ctl%rowtype;
         v_prm_act_catg    NUMBER:= 10042;
         v_brk_pymt       v_70_brk_pymt_tran%ROWTYPE;
         
		 CURSOR c_cus_act IS SELECT tran_bal , r_k FROM v_70_cus_act WHERE cus_r_k = p_pymt_tran.cus_r_k;
         CURSOR c_pymt_tran IS SELECT r_k,  cus_acc_r_k, cus_r_k, apr_sta, due_dt,  pymt_amt,  pol_r_k  FROM v_70_pymt_tran WHERE pol_r_k = p_pymt_tran.pol_r_k;
         CURSOR c_uw_pol IS SELECT prd_r_k, prd_term , cus_r_k, pol_no FROM v_20_uw_pol where r_k = p_pymt_tran.pol_r_k;
         CURSOR c_pmv IS SELECT v_v FROM v_99_ssu_pmv WHERE r_k =  70 AND v_yn = 1;
         
         BEGIN
         
             OPEN  c_pmv;
             FETCH c_pmv INTO v_dec;
             CLOSE c_pmv;

		     OPEN c_cus_act;
			 FETCH c_cus_act INTO v_cus_act.tran_bal,v_cus_act.r_k;
			 CLOSE c_cus_act;
                
             OPEN c_uw_pol;
             FETCH c_uw_pol INTO v_uw_pol.prd_r_k,v_uw_pol.prd_term, v_uw_pol.cus_r_k, v_uw_pol.pol_no;
             CLOSE c_uw_pol;
             
         
                 v_bus_dt := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
				 v_pymt_tran.apr_dt         :=  SYSDATE;
                 v_pymt_tran.apr_sta        :=  1;
                 v_pymt_tran.apr_by         := V('APP_USER');
                 v_pymt_tran.sys_dtt    := SYSDATE;
                 v_pymt_tran.bus_dt         := v_bus_dt;

				 
		    FOR i IN c_pymt_tran LOOP
                 
				 IF i.apr_sta = 1 THEN
                 
                 
                            FOR x IN ( SELECT   COUNT(r_k) v_count FROM v_70_brk_pymt_tran WHERE  
                                        pol_r_k = i.pol_r_k AND tran_srce = 2 and apr_sta = 1 AND pymt_r_k = i.r_k) 
                                    
                                    LOOP
                                    
                                        IF x.v_count > 0 THEN
                             
                                           v_err.err_cd := '-20099';
                                           p_err_msg := v_err.err_msg; 
                                           ROLLBACK;
                                           raise_application_error(v_err.err_cd ,p_err_msg);
                                       
                                        END IF;
                                    END LOOP;
                                    
                                    
                                    
                                    
                 
                 
                 v_pymt_comm_tran.pymt_r_k  := i.r_k;
			     v_pymt_tran.r_k            := s_70_pymt_tran.NEXTVAL;--i.r_k;
                 v_pymt_tran.pymt_amt       := i.pymt_amt;
                 v_pymt_tran.due_dt         := i.due_dt;
                 v_pymt_tran.cus_r_k        := i.cus_r_k;
                 v_pymt_tran.pol_r_k        := i.pol_r_k;
              --   v_pymt_comm_tran.tran_desc := 'Commission for policy' || ' ' || v_uw_pol.pol_no;
        
                 

                 
                 v_pymt_comm_tran.tran_desc := 'Cancelled Premium Due on '|| v_pymt_tran.due_dt||' for policy '|| v_uw_pol.pol_no;
                 v_act_tran.cus_r_k    := v_pymt_tran.cus_r_k;
                 v_act_tran.tran_desc  := v_pymt_comm_tran.tran_desc;
                 v_act_tran.tran_amt   := v_pymt_tran.pymt_amt;
                 v_act_tran.tran_srce  := 3;
                 v_act_tran.ref_no     := v_pymt_tran.pol_r_k;
                 v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                 v_act_tran.dr_cr      := 'C';
               
               /*  
                 IF v_pymt_tran.cus_r_k  IS NOT NULL THEN   
                     IF v_comm_rt IS NULL THEN
                       
                          v_err.err_cd := '-20024';
                          p_err_msg := v_err.err_msg; 
                          raise_application_error(v_err.err_cd ,p_err_msg);
                     END IF;
                 END IF;
                 */
                  --- Approve Premium
			 --    IF v_cus_act.tran_bal >= v_pymt_tran.pymt_amt THEN
			 
		             IF v_err.err_msg IS NULL THEN
                     /*
                     UPDATE t_70_pymt_tran SET apr_sta = v_pymt_tran.apr_sta, apr_dt = v_pymt_tran.apr_dt, sys_dtt = v_pymt_tran.sys_dtt,bus_dt = v_pymt_tran.bus_dt , apr_by = v_pymt_tran.apr_by  WHERE r_k = v_pymt_tran.r_k;
		              */
                      INSERT INTO t_70_pymt_tran (r_k, cus_r_k,apr_sta, apr_by, due_dt,  pymt_amt,  pol_r_k,bus_dt,sys_dtt, tran_desc)
                                                  VALUES
                                                  ( v_pymt_tran.r_k , v_pymt_tran.cus_r_k, v_pymt_tran.apr_sta , v_pymt_tran.apr_by,v_pymt_tran.due_dt, -1* v_pymt_tran.pymt_amt, v_pymt_tran.pol_r_k, v_pymt_tran.bus_dt,v_pymt_tran.sys_dtt,v_pymt_comm_tran.tran_desc);
 					 END IF;	
					 
                        IF v_err.err_msg IS NULL THEN
                            PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                           PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        --- Debit GL Account with Premium 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_pymt_tran.pymt_amt;
                        v_gl_tran.tran_desc    := v_act_tran.tran_desc;
                        v_gl_tran.prd_r_k      := v_uw_pol.prd_r_k;
                        v_act_ctl.prd_r_k      := v_gl_tran.prd_r_k;
                        v_act_ctl.act_catg     := v_prm_act_catg ;
                        v_gl_tran.ldgr_key     := PK_70_GL_TRAN.FN_70_GL_ACT_CTL(v_act_ctl);
                        v_gl_tran.tran_srce    := 3;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ;     
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                                     
                        END IF;
                        
                       --- Credit Customer GL Account with Premium 

                       IF v_err.err_msg IS NULL THEN
                        
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_pymt_tran.pymt_amt;
                        v_gl_tran.tran_desc    := v_act_tran.tran_desc;
                        v_gl_tran.ldgr_key     := v_cus_act.r_k;
                        v_gl_tran.tran_srce    := 3;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ;     
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                             IF v_err.err_msg IS NOT NULL THEN
                          
                                 v_err.err_cd := '-20099';
                                 p_err_msg := v_err.err_msg; 
                                 ROLLBACK;
                                 raise_application_error(v_err.err_cd ,p_err_msg);
                       
                             END IF;
                             
                  --- GET Commission             
                FOR i IN (SELECT  r_k,  cus_r_k, apr_sta, due_dt, pol_r_k, pymt_amt, tran_desc, pymt_r_k 
                                 FROM v_70_pymt_comm_tran WHERE pymt_r_k = v_pymt_comm_tran.pymt_r_k) LOOP
                
                      NULL;
                  
                    --- Generate Commission    
                  -- IF v_uw_pol.cus_r_k  IS NOT NULL AND v_comm_rt IS NOT NULL  THEN 
                   
                       v_pymt_comm_tran.tran_desc := 'Cancelled Commission due on ' ||i.due_dt ||' for policy ' || v_uw_pol.pol_no;
                       v_act_tran.cus_r_k    := i.cus_r_k;
                       v_act_tran.tran_desc  := v_pymt_comm_tran.tran_desc;
                       v_act_tran.tran_amt   := i.pymt_amt;
                       v_act_tran.tran_srce  := 2;
                       v_act_tran.ref_no     := i.pol_r_k;
                       v_act_tran.r_k        := s_70_cus_act_tran.NEXTVAL;  
                       v_act_tran.dr_cr      := 'D';
                       v_act_tran.tran_r_k   := v_pymt_comm_tran.pymt_r_k;
                        
                                         
                        INSERT INTO t_70_pymt_comm_tran (r_k, cus_r_k, pol_r_k, pymt_amt, apr_sta,due_dt,bus_dt,tran_desc,apr_dt,sys_dtt,apr_by,pymt_r_k)
                                                      VALUES
                                                      (v_pymt_comm_tran.r_k,v_uw_pol.cus_r_k,v_pymt_tran.pol_r_k,-1 * v_act_tran.tran_amt, v_pymt_tran.apr_sta,v_pymt_tran.due_dt,v_pymt_tran.bus_dt,v_pymt_comm_tran.tran_desc,v_pymt_tran.apr_dt,v_pymt_tran.sys_dtt,v_pymt_tran.apr_by,v_pymt_comm_tran.pymt_r_k);
                      
                        IF v_err.err_msg IS NULL THEN
                        PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN (v_act_tran, v_err.err_msg);
                        END IF;
                        
                        IF v_err.err_msg IS NULL THEN
                        PK_70_CUS_ACT.PC_70_CUS_ACT_TRAN_APR (v_act_tran, v_err.err_msg);
                    
                        END IF;
                        
                     
                        --- Debit GL Account with Commission 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_gl_tran.dr_cr        := 'C';
                        v_gl_tran.tran_amt     := v_act_tran.tran_amt;
                        v_gl_tran.tran_desc    := v_act_tran.tran_desc;
                        v_gl_tran.prd_r_k      := v_uw_pol.prd_r_k;
                        v_act_ctl.prd_r_k      := v_gl_tran.prd_r_k;
                        v_act_ctl.act_catg     := 10050;
                        v_gl_tran.ldgr_key     := PK_70_GL_TRAN.FN_70_GL_ACT_CTL(v_act_ctl);
                        v_gl_tran.tran_srce    := 2;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ; 
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                        
                        --- Cancel bank payment for  Commission 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_brk_pymt.drcr         := 'C';
                        v_brk_pymt.pymt_amt     := v_act_tran.tran_amt;
                        v_brk_pymt.tran_desc    := v_act_tran.tran_desc;
                        v_brk_pymt.pymt_r_k     := v_pymt_tran.r_k;
                        v_brk_pymt.pol_r_k      := v_pymt_tran.pol_r_k;
                        v_brk_pymt.cus_r_k      := v_act_tran.cus_r_k;
                        v_brk_pymt.tran_srce    := 2;
                        v_brk_pymt.due_dt       := SYSDATE;
                        PK_70_BRK_PYMT_TRAN.PC_70_BRK_PYMT_TRAN_CNL(v_brk_pymt,v_err.err_msg);
                        
                        END IF;
                        
                         --- Post Commission to Customer GL Account payment 
                        IF v_err.err_msg IS NULL THEN
                        
                        v_cus_act.cus_r_k := v_act_tran.cus_r_k;
                        
                        v_gl_tran.dr_cr        := 'D';
                        v_gl_tran.tran_amt     := v_act_tran.tran_amt;
                        v_gl_tran.tran_desc    :=  v_act_tran.tran_desc;
                        v_gl_tran.ldgr_key     := PK_70_GL_TRAN.FN_70_GL_CUS_ACT(v_cus_act);
                        v_gl_tran.tran_srce    := 2;
                        v_gl_tran.tran_no      := v_pymt_tran.r_k ;     
                        PK_70_GL_TRAN.PC_70_GL_TRAN(v_gl_tran,v_err.err_msg);
                        
                        END IF;
                        
                        
                       
                          IF v_err.err_msg IS NOT NULL THEN
                          
                            v_err.err_cd := '-20099';
                            p_err_msg := v_err.err_msg; 
                            ROLLBACK;
                            raise_application_error(v_err.err_cd ,p_err_msg);
                       
                          END IF;
                        
                       
                ---  END IF;
                        
                 END LOOP;
						
				   					
				 ELSE
				
				     NULL;
				                     
		         END IF;
             END LOOP;   
                  
              COMMIT;
                     /*
			     ELSE

                 v_err.err_cd := '-20023';
                 p_err_msg := v_err.err_msg;
                 ROLLBACK;
                 raise_application_error(v_err.err_cd ,p_err_msg);
				 
		         END IF;
                  */
		 
	  EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
           
     END PC_70_PYMT_TRAN_APR_CNL;
     
     
END PK_70_PYMT_TRAN;

/
