--------------------------------------------------------
--  DDL for View V_70_PYMT_COMM_TRAN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_PYMT_COMM_TRAN" ("R_K", "CUS_ACC_R_K", "CUS_R_K", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "POL_R_K", "PYMT_AMT", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "PYMT_R_K") AS 
  SELECT
    r_k,
    cus_acc_r_k,
    cus_r_k,
    apr_sta,
    bus_dt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    due_dt,
    pol_r_k,
    pymt_amt,
    tran_desc,
    apr_dt,
    sys_dtt,
    apr_by,
    PYMT_R_K
FROM
    t_70_pymt_comm_tran
;
