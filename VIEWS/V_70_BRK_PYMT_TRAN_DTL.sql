--------------------------------------------------------
--  DDL for View V_70_BRK_PYMT_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_BRK_PYMT_TRAN_DTL" ("R_K", "CUS_ACC_R_K", "CUS_R_K", "DRCR", "TRAN_SRCE", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "POL_R_K", "CLM_R_K", "PYMT_AMT", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "ACT_R_K", "PYMT_REF", "MODE_PYMT", "LDGR_KEY_CR", "VCHR_TP", "ACT_DESC", "TRAN_BTCH_NO") AS 
  SELECT
    tran.r_k,
    tran.cus_acc_r_k,
    tran.cus_r_k,
    tran.drcr,
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
    tran.pymt_amt,
    tran.tran_desc,
    tran.apr_dt,
    tran.sys_dtt,
    tran.apr_by,
    tran.act_r_k,
    tran.pymt_ref,
   tran.mode_pymt,
    tran.ldgr_key_cr,
    tran.vchr_tp,
    cus.cus_nm act_desc,
    tran.TRAN_BTCH_NO
FROM
    v_70_brk_pymt_tran tran, v_20_cus_all cus where  tran.cus_r_k = cus.r_k(+)
;
