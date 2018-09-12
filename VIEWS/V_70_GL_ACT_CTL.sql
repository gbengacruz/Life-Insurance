--------------------------------------------------------
--  DDL for View V_70_GL_ACT_CTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_CTL" ("R_K", "CUS_R_K", "MN_ACT", "BUS_DT", "SYS_DTT", "APR_STA", "DEPT_R_K", "LOC_R_K", "CURR_R_K", "ACT_DESC", "LST_TRAN_AMT", "TRAN_BAL", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "COMP_R_K", "APR_BY", "APR_DT", "TRAN_TP", "IUS_YN", "PRD_R_K", "ACT_NO", "ACT_TP", "ACT_LVL", "ACT_NTR", "ACT_CATG") AS 
  SELECT
      r_k,
    cus_r_k,
    mn_act,
    bus_dt,
    sys_dtt,
    apr_sta,
    dept_r_k,
    loc_r_k,
    curr_r_k,
    act_desc,
    lst_tran_amt,
    tran_bal,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    comp_r_k,
    apr_by,
    apr_dt,
    tran_tp,
    ius_yn,
    prd_r_k,
    act_no,
    act_tp,
    ACT_LVL,
    act_ntr,
    act_catg
FROM
    t_70_gl_act_ctl
;
