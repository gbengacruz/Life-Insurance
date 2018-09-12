--------------------------------------------------------
--  DDL for Package PK_99_SSU_ERR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_99_SSU_ERR" AS  
 
-- Author       : Gbenga Cruz 
-- Description  : Error Handling 
-- Date         : January 18, 2017 
 
 --- Error Handling  
  PROCEDURE PC_99_SSU_ERR (p_err IN OUT v_99_ssu_log%ROWTYPE); 
END PK_99_SSU_ERR;

/
