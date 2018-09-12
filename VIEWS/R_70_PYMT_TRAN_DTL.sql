--------------------------------------------------------
--  DDL for View R_70_PYMT_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "R_70_PYMT_TRAN_DTL" ("R_K", "CUS_ACC_R_K", "CUS_R_K", "DRCR", "TRAN_TP", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "PYMT_AMT", "POL_R_K", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "CUS_NM", "POL_NO") AS 
  SELECT
    r_k,
    cus_acc_r_k,
    cus_r_k,
    drcr,
    tran_tp,
    apr_sta,
    bus_dt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    due_dt,
    pymt_amt,
    pol_r_k,
    tran_desc,
    apr_dt,
    sys_dtt,
    apr_by,
    cus_nm,
    pol_no
FROM
    v_70_pymt_tran_dtl
;
