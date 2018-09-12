--------------------------------------------------------
--  DDL for View V_70_GL_JV_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_JV_TRAN_DTL" ("R_K", "LDGR_KEY", "TRAN_SRCE", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "POL_R_K", "CLM_R_K", "TRAN_AMT", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "TRAN_REF", "MODE_PYMT", "VCHR_TP", "DR_CR", "BATCH_NO", "ACT_NM") AS 
  SELECT
    tran.r_k,
    tran.ldgr_key,
    tran.tran_srce,
    tran.apr_sta,
    tran.bus_dt,
    tran.crt_by,
    tran.crt_dt,
    tran.upd_by,
    tran.upd_dt,
    tran.due_dt,
    tran.pol_r_k,
    tran.clm_r_k,
    tran.tran_amt,
    tran.tran_desc,
    tran.apr_dt,
    tran.sys_dtt,
    tran.apr_by,
    tran.tran_ref,
    tran.mode_pymt,
    tran.vchr_tp,
    tran.dr_cr,
    tran.batch_no,
    act.ACT_NM
FROM
    v_70_gl_jv_tran tran, V_70_GL_ACT_CTL_ALL act WHERE tran.ldgr_key = act.R_K
;
