--------------------------------------------------------
--  DDL for Package PK_70_GL_TRAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_GL_TRAN" AS 

-- Author       : Gbenga Cruz 
-- Description  : General Ledger Transactions
-- Date         : January 18, 2018
 

	 --- GL Posting
     PROCEDURE PC_70_GL_TRAN (p_gl_tran IN v_70_gl_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
       --- Get Account for Product
     FUNCTION FN_70_GL_ACT_CTL(p_act_ctl IN v_70_gl_act_ctl%ROWTYPE)  RETURN NUMBER;
     
         --- Get Account for Product
   FUNCTION FN_70_GL_CUS_ACT(p_cus_act IN v_70_cus_act%ROWTYPE)  RETURN NUMBER;

END PK_70_GL_TRAN;

/
