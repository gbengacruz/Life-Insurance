--------------------------------------------------------
--  DDL for View V_70_CUS_ACT_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_CUS_ACT_DTL" ("R_K", "CUS_R_K", "BUS_DT", "SYS_DTT", "APR_STA", "DEPT_R_K", "LOC_R_K", "CURR_R_K", "TRAN_DESC", "TRAN_SRCE", "TRAN_DM", "LST_TRAN_AMT", "TRAN_BAL", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "COMP_R_K", "CUS_NM", "CUS_TP", "MN_ACT") AS 
  SELECT
    act.r_k,
    act.cus_r_k,
    act.bus_dt,
    act.sys_dtt,
    act.apr_sta,
    act.dept_r_k,
    act.loc_r_k,
    act.curr_r_k,
    act.tran_desc,
    act.tran_srce,
    act.tran_dm,
    act.lst_tran_amt,
    act.tran_bal,
    act.crt_by,
    act.crt_dt,
    act.upd_by,
    act.upd_dt,
    act.comp_r_k,
    cus.cus_nm,
    cus.cus_tp,
    mn_act
FROM
    t_70_cus_act act, v_20_cus_all cus 
    where act.cus_r_k = cus.r_k(+)
;
