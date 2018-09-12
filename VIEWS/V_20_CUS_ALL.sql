--------------------------------------------------------
--  DDL for View V_20_CUS_ALL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_ALL" ("R_K", "CUS_NM", "CODE", "CUS_TP", "APR_STA", "IUS_YN", "ASR_TP") AS 
  SELECT cus.R_K, nvl(cus.FST_NM,cus_nm)||' '|| cus.LST_NM AS cus_nm, cus.CUS_TP as code,tp.CUS_TP, cus.apr_sta, null ius_yn , cus.asr_tp FROM  V_20_CUS_INFO cus, V_20_CUS_TP tp WHERE cus.cus_tp = tp.r_k(+)
union all
SELECT brk.r_k, brk.cus_desc as cus_nm, brk.CUS_TP as code,tp.cus_tp , brk.apr_sta , brk.ius_yn, null asr_tp FROM v_20_cus_brk brk, V_20_CUS_TP tp WHERE brk.cus_tp = tp.r_k(+)
;
