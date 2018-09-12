--------------------------------------------------------
--  DDL for View V_20_UW_CUS_DOC_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_UW_CUS_DOC_DTL" ("R_K", "CUS_R_K", "DOC_TP", "DOC_BLOB", "DOC_MIMETYPE", "DOC_CHARSET", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "DOC_NAME", "DOC_DESC", "DOC_TP_R_K") AS 
  SELECT
    doc.r_k,
    doc.cus_r_k,
    doc.doc_tp,
    doc.doc_blob,
    doc.doc_mimetype,
    doc.doc_charset,
    doc.crt_by,
    doc.crt_dt,
    doc.upd_by,
    doc.upd_dt,
    doc.doc_name,
    tp.doc_desc,
    tp.doc_tp_r_k
FROM
    t_20_uw_cus_doc doc, t_20_uw_doc tp WHERE doc.doc_tp = tp.r_k
;
