--------------------------------------------------------
--  DDL for View V_70_GL_RCPT_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_RCPT_DTL" ("R_K", "CUS_R_K", "ACT_R_K", "BUS_DT", "SYS_DTT", "APR_BY", "APR_STA", "TRAN_DESC", "TRAN_AMT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "MODE_PYMT", "REF_NO", "APR_DT", "CUS_NM", "TRAN_SRCE", "PRC_DT", "DR_CR", "ACT_TP", "VCHR_TP", "ACT_DESC", "MN_ACT", "PYMT_TP", "LDGR_KEY_DR") AS 
  SELECT
    rcpt.r_k,
    rcpt.cus_r_k,
    rcpt.act_r_k,
    rcpt.bus_dt,
    rcpt.sys_dtt,
    rcpt.apr_by,
    rcpt.apr_sta,
    rcpt.tran_desc,
    rcpt.tran_amt,
    rcpt.crt_by,
    rcpt.crt_dt,
    rcpt.upd_by,
    rcpt.upd_dt,
    rcpt.mode_pymt,
    rcpt.ref_no,
    rcpt.apr_dt,
    rcpt.cus_nm,
    rcpt.tran_srce,
    rcpt.prc_dt,
    rcpt.dr_cr,
    rcpt.act_tp,
    rcpt.vchr_tp,
    act.act_desc,
    act.mn_act,
    pymt.pymt_tp,
    rcpt.LDGR_KEY_DR
    
FROM
    v_70_gl_rcpt rcpt, v_70_gl_act_all act, v_70_mode_pymt pymt
    WHERE rcpt.act_r_k = act.r_k(+)
         and rcpt.mode_pymt = pymt.r_k(+)
;
