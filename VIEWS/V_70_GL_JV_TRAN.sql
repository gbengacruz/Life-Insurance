--------------------------------------------------------
--  DDL for View V_70_GL_JV_TRAN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_JV_TRAN" ("R_K", "LDGR_KEY", "TRAN_SRCE", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "POL_R_K", "CLM_R_K", "TRAN_AMT", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "TRAN_REF", "MODE_PYMT", "VCHR_TP", "DR_CR", "BATCH_NO") AS 
  SELECT
    r_k,
    ldgr_key,
    tran_srce,
    apr_sta,
    bus_dt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    due_dt,
    pol_r_k,
    clm_r_k,
    tran_amt,
    tran_desc,
    apr_dt,
    sys_dtt,
    apr_by,
    tran_ref,
    mode_pymt,
    vchr_tp,
    dr_cr,
    batch_no
FROM
    t_70_gl_jv_tran
;
