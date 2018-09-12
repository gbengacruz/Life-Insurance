--------------------------------------------------------
--  DDL for View V_70_BRK_PYMT_TRAN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_BRK_PYMT_TRAN" ("R_K", "PYMT_R_K", "CUS_ACC_R_K", "CUS_R_K", "DRCR", "TRAN_SRCE", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "POL_R_K", "CLM_R_K", "PYMT_AMT", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "ACT_R_K", "PYMT_REF", "MODE_PYMT", "LDGR_KEY_CR", "VCHR_TP", "TRAN_BTCH_NO") AS 
  SELECT
    r_k,
    pymt_r_k,
    cus_acc_r_k,
    cus_r_k,
    drcr,
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
    pymt_amt,
    tran_desc,
    apr_dt,
    sys_dtt,
    apr_by,
    act_r_k,
    PYMT_REF,
    mode_pymt,
    ldgr_key_cr,
    vchr_tp,
    TRAN_BTCH_NO
FROM
    t_70_brk_pymt_tran
;
