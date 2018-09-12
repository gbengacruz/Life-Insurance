--------------------------------------------------------
--  DDL for View V_70_CUS_ACT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_CUS_ACT" ("R_K", "CUS_R_K", "BUS_DT", "SYS_DTT", "APR_STA", "DEPT_R_K", "LOC_R_K", "COMP_R_K", "CURR_R_K", "TRAN_DESC", "TRAN_SRCE", "TRAN_DM", "LST_TRAN_AMT", "TRAN_BAL", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "APR_BY", "APR_DT", "MN_ACT", "IUS_YN") AS 
  SELECT
    r_k,
    cus_r_k,
    bus_dt,
    sys_dtt,
    apr_sta,
    dept_r_k,
    loc_r_k,
    comp_r_k,
    curr_r_k,
    tran_desc,
    tran_srce,
    tran_dm,
    lst_tran_amt,
    tran_bal,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    apr_by,
    apr_dt,
    mn_act,
    ius_yn
FROM
    t_70_cus_act
;
