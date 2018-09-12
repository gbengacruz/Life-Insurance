--------------------------------------------------------
--  DDL for View V_70_GL_ACT_ALL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_ALL" ("R_K", "ACT_DESC", "ACT_TP", "MN_ACT") AS 
  select r_k, cus_nm ACT_DESC, 1 act_tp, mn_act from v_70_cus_act_dtl where apr_sta = 1
    union
    select r_k, ACT_DESC, 2 act_tp,mn_act from v_70_gl_act_ctl where mn_act is not null and apr_sta = 1
    union
    select r_k, ACT_DESC, 3 act_tp,mn_act from v_70_gl_act_ctl where mn_act is null and apr_sta = 1
;
