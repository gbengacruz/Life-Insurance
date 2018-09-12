--------------------------------------------------------
--  DDL for View V_70_CUS_ACT_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_CUS_ACT_TRAN_DTL" ("R_K", "CUS_R_K", "ACT_R_K", "BUS_DT", "SYS_DTT", "APR_STA", "APR_BY", "TRAN_DESC", "TRAN_AMT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "REF_NO", "MODE_PYMT", "APR_DT", "CUS_NM", "TRAN_SRCE", "DR_CR", "TRAN_R_K") AS 
  SELECT
    tran.r_k,
    tran.cus_r_k,
    tran.act_r_k,
    tran.bus_dt,
    tran.sys_dtt,
    tran.apr_sta,
    tran.apr_by,
    tran.tran_desc,
    tran.tran_amt,
    tran.crt_by,
    tran.crt_dt,
    tran.upd_by,
    tran.upd_dt,
    tran.ref_no,
    tran.mode_pymt,
    tran.apr_dt,
    act.cus_nm,
    tran.tran_srce,
    tran.dr_cr,
    tran.TRAN_R_K
    
FROM
    v_70_cus_act_tran tran , v_70_cus_act_dtl act
    WHERE tran.act_r_k = act.r_k(+)
;
