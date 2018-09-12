--------------------------------------------------------
--  DDL for Package PK_70_GL_RCPT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_GL_RCPT" AS 
-- Author       : Gbenga Cruz 
-- Description  : Receipt Management
-- Date         : January 18, 2017 

     --- Receipt Creation
     PROCEDURE PC_70_GL_RCPT (p_rcpt IN v_70_gl_rcpt%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Receipt Approval
     PROCEDURE PC_70_GL_RCPT_APR (p_rcpt IN v_70_gl_rcpt%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
     --- Receipt Delete
     PROCEDURE PC_70_GL_RCPT_DEL (p_rcpt IN v_70_gl_rcpt%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_70_GL_RCPT;

/
