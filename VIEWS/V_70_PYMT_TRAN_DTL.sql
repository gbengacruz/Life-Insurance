--------------------------------------------------------
--  DDL for View V_70_PYMT_TRAN_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_PYMT_TRAN_DTL" ("R_K", "CUS_ACC_R_K", "CUS_R_K", "DRCR", "TRAN_TP", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DUE_DT", "PYMT_AMT", "POL_R_K", "TRAN_DESC", "APR_DT", "SYS_DTT", "APR_BY", "CUS_NM", "POL_NO") AS 
  SELECT
    pymt.r_k,
    pymt.cus_acc_r_k,
    pymt.cus_r_k,
    pymt.drcr,
    pymt.tran_tp,
    pymt.apr_sta,
    pymt.bus_dt,
    pymt.crt_by,
    pymt.crt_dt,
    pymt.upd_by,
    pymt.upd_dt,
    pymt.due_dt,
    pymt.pymt_amt,
    pymt.pol_r_k,
    pymt.tran_desc,
    pymt.apr_dt,
    pymt.sys_dtt,
    pymt.apr_by,
    cus.cus_nm,
    pol.pol_no
FROM
    v_70_pymt_tran pymt, v_20_cus_all cus , v_20_uw_pol pol
    where pymt.cus_r_k = cus.r_k(+) AND
          pymt.pol_r_k = pol.r_k(+)
;
