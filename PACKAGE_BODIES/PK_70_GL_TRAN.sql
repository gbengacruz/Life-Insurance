--------------------------------------------------------
--  DDL for Package Body PK_70_GL_TRAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_GL_TRAN" AS

-- Author       : Gbenga Cruz 
-- Description  : General Ledger Transactions
-- Date         : January 18, 2018


	 --- GL Posting
     PROCEDURE PC_70_GL_TRAN (p_gl_tran IN v_70_gl_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
	 
	    v_gl_tran    v_70_gl_tran%ROWTYPE;
		v_err        v_99_ssu_log%ROWTYPE;
        v_bus_dt     v_99_ssu_pmv.v_d%TYPE;
		v_act        v_70_gl_act_ctl%ROWTYPE; 
		CURSOR c_act IS SELECT dept_r_k, loc_r_k, curr_r_k, comp_r_k, prd_r_k FROM v_70_gl_act_ctl_all WHERE r_k = p_gl_tran.ldgr_key;
		BEGIN
        
             OPEN c_act;
             FETCH c_act INTO v_act.dept_r_k,v_act.loc_r_k,v_act.curr_r_k,v_act.comp_r_k,v_act.prd_r_k;
             CLOSE c_act;
		
        
                     IF    p_gl_tran.ldgr_key IS NULL THEN 
                            v_err.err_cd := '-20031';
                            p_err_msg := v_err.err_msg; 
                           raise_application_error(v_err.err_cd ,p_err_msg);
                     END IF;
        
		     v_gl_tran.r_k            := p_gl_tran.r_k;
			 v_gl_tran.bus_dt         := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT;
		     v_gl_tran.sys_dtt        := SYSDATE;
			 v_gl_tran.apr_sta        := 1;
			 v_gl_tran.comp_r_k       := v_act.comp_r_k;
			 v_gl_tran.loc_r_k        := v_act.loc_r_k;
			 v_gl_tran.tran_btch_no   := p_gl_tran.tran_btch_no;
			 v_gl_tran.tran_no        := p_gl_tran.tran_no;
			 v_gl_tran.ldgr_key       := p_gl_tran.ldgr_key;
			 v_gl_tran.curr_r_k       := v_act.curr_r_k;
			 v_gl_tran.tran_desc      := p_gl_tran.tran_desc;
			 v_gl_tran.tran_srce      := p_gl_tran.tran_srce;
			 v_gl_tran.dr_cr          := p_gl_tran.dr_cr;
			 v_gl_tran.tran_amt       := p_gl_tran.tran_amt;
			 v_gl_tran.dept_r_k       := v_act.dept_r_k;
			 v_gl_tran.prd_r_k        := v_act.prd_r_k;
			 v_gl_tran.proc_dt        := SYSDATE;
			 v_gl_tran.sys_tran_yn    := p_gl_tran.sys_tran_yn;
			 
			 IF v_err.err_msg IS NULL THEN
			 
			     INSERT INTO t_70_gl_tran(r_k,bus_dt,sys_dtt,apr_sta,comp_r_k,loc_r_k,tran_btch_no,tran_no,ldgr_key,curr_r_k
				                           ,tran_desc,tran_srce,dr_cr,tran_amt,dept_r_k,prd_r_k,proc_dt,sys_tran_yn) VALUES 
										  (v_gl_tran.r_k,v_gl_tran.bus_dt,v_gl_tran.sys_dtt,v_gl_tran.apr_sta,v_gl_tran.comp_r_k,v_gl_tran.loc_r_k,v_gl_tran.tran_btch_no,v_gl_tran.tran_no,v_gl_tran.ldgr_key,v_gl_tran.curr_r_k
				                           ,v_gl_tran.tran_desc,v_gl_tran.tran_srce,v_gl_tran.dr_cr,v_gl_tran.tran_amt,v_gl_tran.dept_r_k,v_gl_tran.prd_r_k,v_gl_tran.proc_dt,v_gl_tran.sys_tran_yn);
		  
			 
			 END IF;
			 
             EXCEPTION WHEN OTHERS THEN
             ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
        --  raise_application_error(v_err.err_cd ,p_err_msg);
	END PC_70_GL_TRAN;



  --- Get Account for Product
   FUNCTION FN_70_GL_ACT_CTL(p_act_ctl IN v_70_gl_act_ctl%ROWTYPE)  RETURN NUMBER  AS

     v_act_ctl  v_70_gl_act_ctl%rowtype;
	 
         CURSOR c_act_ctl IS SELECT r_k FROM v_70_gl_act_ctl
                     		 WHERE prd_r_k = p_act_ctl.prd_r_k AND act_catg = p_act_ctl.act_catg;

                 BEGIN

                         OPEN  c_act_ctl;
						 FETCH c_act_ctl INTO v_act_ctl.r_k;
						 CLOSE c_act_ctl;


                RETURN v_act_ctl.r_k;

    END FN_70_GL_ACT_CTL;
    
    
      --- Get Account for customer
   FUNCTION FN_70_GL_CUS_ACT(p_cus_act IN v_70_cus_act%ROWTYPE)  RETURN NUMBER  AS

     v_cus_act   v_70_cus_act%rowtype;
	 
         CURSOR c_cus_act IS SELECT r_k FROM v_70_cus_act
                     		 WHERE CUS_R_K =  p_cus_act.cus_r_k;

                 BEGIN

                         OPEN  c_cus_act;
						 FETCH c_cus_act INTO v_cus_act.r_k;
						 CLOSE c_cus_act;


                RETURN v_cus_act.r_k;

    END FN_70_GL_CUS_ACT;

END PK_70_GL_TRAN;

/
