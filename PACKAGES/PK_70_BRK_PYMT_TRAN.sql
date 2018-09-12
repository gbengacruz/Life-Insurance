--------------------------------------------------------
--  DDL for Package PK_70_BRK_PYMT_TRAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_BRK_PYMT_TRAN" AS 
-- Author       : Gbenga Cruz 
-- Description  : Bank Payment Process
-- Date         : January 18, 2018



	 --- Post Bank Payment 
     PROCEDURE PC_70_BRK_PYMT_TRAN (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Post Bank Payment approval
     PROCEDURE PC_70_BRK_PYMT_TRAN_APR (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
      --- Cancel Bank Payment 
     PROCEDURE PC_70_BRK_PYMT_TRAN_CNL (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
             
      --- Update Bank Payment 
     PROCEDURE PC_70_BRK_PYMT_TRAN_UPD (p_brk_pymt IN v_70_brk_pymt_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);

END PK_70_BRK_PYMT_TRAN;

/
