--------------------------------------------------------
--  DDL for View V_20_CUS_BRK_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_BRK_DTL" ("R_K", "CUS_DESC", "IUS_YN", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "CUS_TP", "TP_R_K", "PHN_NO", "CUS_EML") AS 
  SELECT
    brk.r_k,
    brk.cus_desc,
    brk.ius_yn,
    brk.crt_by,
    brk.crt_dt,
    brk.upd_by,
    brk.upd_dt,
    tp.cus_tp,
    tp.r_k tp_r_k,
    brk.phn_no,
    brk.cus_eml
FROM
    v_20_cus_brk brk, v_20_cus_tp tp
    where brk.cus_tp = tp.r_k(+)
;
