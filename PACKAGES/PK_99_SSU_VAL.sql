--------------------------------------------------------
--  DDL for Package PK_99_SSU_VAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_99_SSU_VAL" AS  
 
-- Author       : Gbenga Cruz 
-- Description  : Validation Management 
-- Date         : January 18, 2017 
 
         
         --- Validate Password
         FUNCTION FN_99_SSU_PWD_VAL  (p_prf_cd IN v_99_ssu_pwd_prf.prf_cd%type, p_usr_pwd IN v_99_ssu_usr.usr_pwd%type)  RETURN BOOLEAN;

         --- Validate User ID
         FUNCTION FN_99_SSU_USR_VAL (p_usr_id IN v_99_ssu_usr.usr_id%type)  RETURN BOOLEAN;

END PK_99_SSU_VAL;

/
