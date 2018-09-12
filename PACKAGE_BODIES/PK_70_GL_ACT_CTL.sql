--------------------------------------------------------
--  DDL for Package Body PK_70_GL_ACT_CTL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_70_GL_ACT_CTL" AS

-- Author       : Gbenga Cruz 
-- Description  : Account Management
-- Date         : January 18, 2017 
 
    --- Account Creation
     PROCEDURE PC_70_GL_ACT_CTL (p_act_ctl IN v_70_gl_act_ctl%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_act_ctl    v_70_gl_act_ctl%ROWTYPE;
       v_err        v_99_ssu_log%ROWTYPE;

       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;



         BEGIN



            v_act_ctl.r_k            := p_act_ctl.r_k;
            v_act_ctl.cus_r_k        := p_act_ctl.cus_r_k;
            v_act_ctl.dept_r_k       := p_act_ctl.dept_r_k;
            v_act_ctl.loc_r_k        := p_act_ctl.loc_r_k;
            v_act_ctl.curr_r_k       := PK_99_SSU_PMV.FN_99_SS_PMV_CURR;
            v_act_ctl.act_desc       := p_act_ctl.act_desc;
            v_act_ctl.comp_r_k       := p_act_ctl.comp_r_k;
            v_act_ctl.ius_yn         := p_act_ctl.ius_yn;
            v_act_ctl.prd_r_k        := p_act_ctl.prd_r_k;
            v_act_ctl.act_no         := p_act_ctl.act_no;
            v_act_ctl.act_lvl        := p_act_ctl.act_lvl;
            v_act_ctl.act_tp        := p_act_ctl.act_tp;
            v_act_ctl.act_ntr        := p_act_ctl.act_ntr;
            v_act_ctl.act_catg        := p_act_ctl.act_catg;
            v_act_ctl.apr_sta        := 0;
            v_act_ctl.sys_dtt        := SYSDATE;
            v_act_ctl.bus_dt         := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 



           IF v_err.err_msg IS NULL THEN
           
               IF v_act_ctl.r_k IS NULL THEN
                 INSERT INTO t_70_gl_act_ctl(r_k,cus_r_k,dept_r_k,loc_r_k,curr_r_k,act_desc,comp_r_k,ius_yn,prd_r_k,act_no,act_lvl,apr_sta,sys_dtt,bus_dt,act_tp,act_ntr, act_catg )
                     VALUES
                    (v_act_ctl.r_k,v_act_ctl.cus_r_k,v_act_ctl.dept_r_k,v_act_ctl.loc_r_k,v_act_ctl.curr_r_k,v_act_ctl.act_desc,
					  v_act_ctl.comp_r_k,v_act_ctl.ius_yn,v_act_ctl.prd_r_k ,v_act_ctl.act_no,v_act_ctl.act_lvl,v_act_ctl.apr_sta,v_act_ctl.sys_dtt, v_act_ctl.bus_dt,v_act_ctl.act_tp,v_act_ctl.act_ntr ,v_act_ctl.act_catg );

                ELSE 
                        UPDATE t_70_gl_act_ctl SET dept_r_k = v_act_ctl.dept_r_k, loc_r_k = v_act_ctl.loc_r_k, 
			                              act_desc = v_act_ctl.act_desc, sys_dtt = v_act_ctl.sys_dtt,
                                          bus_dt = v_act_ctl.bus_dt,comp_r_k  = v_act_ctl.comp_r_k, act_tp = v_act_ctl.act_tp ,act_ntr  = v_act_ctl.act_ntr , act_catg = v_act_ctl.act_catg, prd_r_k = v_act_ctl.prd_r_k
									  WHERE r_k = v_act_ctl.r_k;
                END IF;
           END IF;
        COMMIT;
       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
    END PC_70_GL_ACT_CTL;
    
    
   --- Account Approval
     PROCEDURE PC_70_GL_ACT_CTL_APR (p_act_ctl IN v_70_gl_act_ctl%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS

       v_act_ctl    v_70_gl_act_ctl%ROWTYPE;
       v_err        v_99_ssu_log%ROWTYPE;

       v_bus_dt    v_99_ssu_pmv.v_d%TYPE;



         BEGIN



            v_act_ctl.r_k            := p_act_ctl.r_k;
            v_act_ctl.apr_sta        := 1;
            v_act_ctl.sys_dtt        := SYSDATE;
			v_act_ctl.apr_dt         := SYSDATE;
			v_act_ctl.apr_by         := V('APP_USER');
            v_act_ctl.bus_dt         := PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT; 



           IF v_err.err_msg IS NULL THEN
              
               UPDATE t_70_gl_act_ctl SET apr_sta = v_act_ctl.apr_sta, apr_dt = v_act_ctl.apr_dt, 
			                              apr_by = v_act_ctl.apr_by, sys_dtt = v_act_ctl.sys_dtt, bus_dt = v_act_ctl.bus_dt
									  WHERE r_k = v_act_ctl.r_k;

              
           END IF;
           
        COMMIT;
       EXCEPTION WHEN OTHERS THEN
           ROLLBACK;
             pk_99_ssu_err.pc_99_ssu_err(v_err);
             p_err_msg := v_err.err_msg;
    END PC_70_GL_ACT_CTL_APR;
    
END PK_70_GL_ACT_CTL;

/
