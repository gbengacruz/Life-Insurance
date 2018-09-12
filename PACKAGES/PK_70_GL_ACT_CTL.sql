--------------------------------------------------------
--  DDL for Package PK_70_GL_ACT_CTL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_GL_ACT_CTL" AS 

 -- Author       : Gbenga Cruz 
-- Description  : Account Management
-- Date         : January 18, 2017 
 
    --- Account Creation
     PROCEDURE PC_70_GL_ACT_CTL (p_act_ctl IN v_70_gl_act_ctl%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
    --- Account Approval
     PROCEDURE PC_70_GL_ACT_CTL_APR (p_act_ctl IN v_70_gl_act_ctl%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_70_GL_ACT_CTL;

/
