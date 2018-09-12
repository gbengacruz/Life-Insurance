--------------------------------------------------------
--  DDL for View V_20_UW_CUS_DOC
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_UW_CUS_DOC" ("R_K", "CUS_R_K", "DOC_TP", "DOC_BLOB", "DOC_MIMETYPE", "DOC_CHARSET", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DOC_NAME") AS 
  SELECT
    r_k,
    cus_r_k,
    doc_tp,
    doc_blob,
    doc_mimetype,
    doc_charset,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    doc_name
FROM
    t_20_uw_cus_doc
;
