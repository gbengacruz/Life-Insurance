--------------------------------------------------------
--  DDL for View V_70_GL_TRAN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_TRAN" ("R_K", "BUS_DT", "SYS_DTT", "APR_STA", "COMP_R_K", "LOC_R_K", "TRAN_BTCH_NO", "TRAN_NO", "LDGR_KEY", "CURR_R_K", "TRAN_DESC", "TRAN_SRCE", "TRAN_DM", "TRAN_AMT", "EXCH_RT", "SYS_TRAN_YN", "UPD_FLAG_YN", "EFF_DT", "PROC_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DEPT_R_K", "PRD_R_K", "LDGR_KEY_FM", "DR_CR") AS 
  SELECT
    r_k,
    bus_dt,
    sys_dtt,
    apr_sta,
    comp_r_k,
    loc_r_k,
    tran_btch_no,
    tran_no,
    ldgr_key,
    curr_r_k,
    tran_desc,
    tran_srce,
    tran_dm,
    tran_amt,
    exch_rt,
    sys_tran_yn,
    upd_flag_yn,
    eff_dt,
    proc_dt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    dept_r_k,
    prd_r_k,
    ldgr_key_fm,
    dr_cr
FROM
    t_70_gl_tran
;
