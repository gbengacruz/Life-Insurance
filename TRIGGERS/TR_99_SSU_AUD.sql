--------------------------------------------------------
--  DDL for Trigger TR_99_SSU_AUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_99_SSU_AUD" 
   BEFORE INSERT OR UPDATE ON t_99_ssu_aud
   FOR EACH ROW 
 BEGIN 
   IF :new.r_k IS NULL THEN 
    -- SELECT to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') INTO :new.r_k FROM dual; 
    SELECT s_99_ssu_aud.NEXTVAL INTO :new.r_k FROM dual; 
   END IF; 
   IF inserting THEN 
       :new.crt_dt := localtimestamp; 
       :new.crt_by := nvl(wwv_flow.g_user,user); 

    END IF; 

 END TR_99_SSU_AUD;

/
ALTER TRIGGER "TR_99_SSU_AUD" ENABLE;
