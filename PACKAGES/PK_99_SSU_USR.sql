--------------------------------------------------------
--  DDL for Package PK_99_SSU_USR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_99_SSU_USR" AS  
 
-- Author       : Gbenga Cruz 
-- Description  : Cloud Application User Management 
-- Date         : January 18, 2017 
  
     --- Create App user 
     PROCEDURE PC_99_SSU_USR (p_usr IN v_99_ssu_usr%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE); 

     --- Password reset
     PROCEDURE PC_99_SSU_PWD (p_usr IN v_99_ssu_usr%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;

     --- User Roles Management
     PROCEDURE PC_99_SSU_USR_RLE (p_usr_rle IN v_99_ssu_usr_rle %ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     PROCEDURE PC_99_SSU_USR_RLE_DEL (p_usr_rle IN v_99_ssu_usr_rle %ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);

     --- Lock / Unlock Account
     PROCEDURE PC_99_USR_LU (p_usr IN v_99_ssu_usr%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;

     --- Role Management
      PROCEDURE PC_99_SSU_RLE (p_rle IN v_99_ssu_rle %ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);

END PK_99_SSU_USR;

/
