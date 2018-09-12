--------------------------------------------------------
--  DDL for View V_20_DASH_01
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_DASH_01" ("PRD_DESC", "AMT") AS 
  select pol.PRD_DESC, sum(tran.PYMT_AMT) amt from V_20_UW_POL_DTL pol, v_70_pymt_tran_dtl tran WHERE pol.r_k = tran.pol_r_k  and tran.apr_sta = 1 and pol.EN_DT >= PK_99_SSU_PMV.FN_99_SS_PMV_BUS_DT
    GROUP BY pol.PRD_DESC
;
