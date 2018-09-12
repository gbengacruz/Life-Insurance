--------------------------------------------------------
--  DDL for View R_70_CUS_ACT_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "R_70_CUS_ACT_TRAN_DTL" ("R_K", "CUS_R_K", "ACT_R_K", "BUS_DT", "APR_BY", "APR_DT", "TRAN_DESC", "TRAN_AMT", "CUS_NM", "CR", "DR") AS 
  SELECT
    r_k,
    cus_r_k,
    act_r_k,
    bus_dt,
    apr_by,
    apr_dt,
    tran_desc,
    tran_amt,
    cus_nm,
    case when dr_cr = 'C' THEN tran_amt ELSE 0.0 END CR,
    case when dr_cr = 'D' THEN tran_amt ELSE 0.0 END DR
    
FROM
    v_70_cus_act_tran_dtl where apr_sta = 1
;
