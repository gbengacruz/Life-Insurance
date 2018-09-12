--------------------------------------------------------
--  DDL for View V_70_GL_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_TRAN_DTL" ("R_K", "BUS_DT", "SYS_DTT", "APR_STA", "COMP_R_K", "LOC_R_K", "TRAN_BTCH_NO", "TRAN_NO", "LDGR_KEY", "CURR_R_K", "TRAN_DESC", "TRAN_SRCE", "TRAN_DM", "TRAN_AMT", "EXCH_RT", "SYS_TRAN_YN", "UPD_FLAG_YN", "EFF_DT", "PROC_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DEPT_R_K", "PRD_R_K", "LDGR_KEY_FM", "DR_CR", "ACT_NM", "TRAN_SRCE_NM", "DEBIT", "CREDIT", "R_TRAN_AMT") AS 
  SELECT
    tran.r_k,
    tran.bus_dt,
    tran.sys_dtt,
    tran.apr_sta,
    tran.comp_r_k,
    tran.loc_r_k,
    tran.tran_btch_no,
    tran.tran_no,
    tran.ldgr_key,
    tran.curr_r_k,
    tran.tran_desc,
    tran.tran_srce,
    tran.tran_dm,
    tran.tran_amt,
    tran.exch_rt,
    tran.sys_tran_yn,
    tran.upd_flag_yn,
    tran.eff_dt,
    tran.proc_dt,
    tran.crt_by,
    tran.crt_dt,
    tran.upd_by,
    tran.upd_dt,
    tran.dept_r_k,
    tran.prd_r_k,
    tran.ldgr_key_fm,
    tran.dr_cr,
    act.act_nm,
    srce.TRAN_SRCE TRAN_SRCE_NM,
       case when  tran.dr_cr = 'D' THEN tran_amt ELSE 0 END DEBIT,
      case when  dr_cr = 'C' THEN tran_amt ELSE 0 END CREDIT,
      case when dr_cr = 'D' THEN -1 * tran_amt WHEN  dr_cr = 'C'  THEN tran_amt END r_tran_amt
FROM
    v_70_gl_tran tran , v_70_gl_act_ctl_all act,T_70_TRAN_SRCE srce where  tran.ldgr_key = act.R_K(+) AND  tran.tran_srce = srce.R_K(+)
;
