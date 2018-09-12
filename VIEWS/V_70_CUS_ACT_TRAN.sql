--------------------------------------------------------
--  DDL for View V_70_CUS_ACT_TRAN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_CUS_ACT_TRAN" ("R_K", "CUS_R_K", "ACT_R_K", "BUS_DT", "SYS_DTT", "APR_STA", "APR_BY", "TRAN_DESC", "TRAN_AMT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "REF_NO", "MODE_PYMT", "APR_DT", "TRAN_SRCE", "DR_CR", "TRAN_R_K") AS 
  SELECT
    r_k,
    cus_r_k,
    act_r_k,
    bus_dt,
    sys_dtt,
    apr_sta,
    apr_by,
    tran_desc,
    tran_amt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    ref_no,
    mode_pymt,
    apr_dt,
    tran_srce,
    dr_cr,
    TRAN_R_K
FROM
    t_70_cus_act_tran
;
