--------------------------------------------------------
--  DDL for View V_70_PYMT_COMM_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_PYMT_COMM_TRAN_DTL" ("R_K", "CUS_ACC_R_K", "CUS_R_K", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "POL_R_K", "PYMT_AMT", "TRAN_DESC", "APR_DT", "APR_BY", "CUS_DESC", "PYMT_R_K") AS 
  SELECT
    tran.r_k,
    tran.cus_acc_r_k,
    tran.cus_r_k,
    tran.apr_sta,
    tran.bus_dt,
    tran.crt_by,
    tran.crt_dt,
    tran.upd_by,
    tran.upd_dt,
    tran.due_dt,
    tran.pol_r_k,
    tran.pymt_amt,
    tran.tran_desc,
    tran.apr_dt,
    tran.apr_by,
    brk.cus_desc,
    tran.PYMT_R_K
FROM
    v_70_pymt_comm_tran tran, v_20_cus_brk brk
    WHERE tran.cus_r_k = brk.R_K(+)
;
