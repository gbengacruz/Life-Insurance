--------------------------------------------------------
--  DDL for View V_70_GL_ACT_MAP
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_MAP" ("R_K", "CUS_R_K", "SUB_ACT", "MN_ACT", "BUS_DT", "SYS_DTT", "APR_STA", "DEPT_R_K", "LOC_R_K", "CURR_R_K", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "COMP_R_K", "APR_BY", "APR_DT", "IUS_YN", "PRD_R_K", "ACT_NO") AS 
  SELECT
    r_k,
    cus_r_k,
    sub_act,
    mn_act,
    bus_dt,
    sys_dtt,
    apr_sta,
    dept_r_k,
    loc_r_k,
    curr_r_k,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    comp_r_k,
    apr_by,
    apr_dt,
    ius_yn,
    prd_r_k,
    act_no
FROM
    t_70_gl_act_map
;
