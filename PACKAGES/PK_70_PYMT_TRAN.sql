--------------------------------------------------------
--  DDL for Package PK_70_PYMT_TRAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_PYMT_TRAN" AS 

-- Author       : Gbenga Cruz 
-- Description  : Policy Management
-- Date         : January 18, 2017 

  --- Payments
  PROCEDURE PC_70_PYMT_TRAN (p_pymt_tran IN v_70_pymt_tran%ROWTYPE,p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
 
  --- Payments Approval
  PROCEDURE PC_70_PYMT_TRAN_APR (p_pymt_tran IN v_70_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
  
  --- Delete Payments
  PROCEDURE PC_70_PYMT_TRAN_DEL (p_pymt_tran IN v_70_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
  
  --- Cancel Payments Approval
  PROCEDURE PC_70_PYMT_TRAN_APR_CNL (p_pymt_tran IN v_70_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_70_PYMT_TRAN;

/
