--------------------------------------------------------
--  DDL for Package PK_70_GL_JV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_GL_JV" AS 

-- Author       : Gbenga Cruz 
-- Description  : Adjustment Voucher
-- Date         : January 18, 2017


	 --- GL Adjustment Journal
     PROCEDURE PC_70_GL_JV (p_gl_jv IN v_70_gl_jv%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
     --- GL Adjustment Journal transaction
     PROCEDURE PC_70_GL_JV_TRAN (p_gl_jv IN v_70_gl_jv_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
     --- Approve Journal voucher
     PROCEDURE PC_70_GL_JV_TRAN_APR (p_jv_tran IN v_70_gl_jv_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
END PK_70_GL_JV;

/
