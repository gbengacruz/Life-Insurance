--------------------------------------------------------
--  DDL for View V_70_GL_ACT_CTL_ALL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_CTL_ALL" ("R_K", "DEPT_R_K", "LOC_R_K", "CURR_R_K", "COMP_R_K", "PRD_R_K", "ACT_NM", "ACT_TP", "ACT_CATG") AS 
  SELECT R_K , dept_r_k, loc_r_k, curr_r_k, comp_r_k, prd_r_k , act_desc act_nm , act_tp, act_catg FROM v_70_gl_act_ctl
                                   UNION 
                                   SELECT R_K, dept_r_k, loc_r_k, curr_r_k, comp_r_k,  NULL prd_r_k , cus_nm act_nm, 1 act_tp , null act_catg FROM v_70_cus_act_dtl
;
