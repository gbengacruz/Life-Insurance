--------------------------------------------------------
--  DDL for Trigger TR_20_CUS_BRK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_20_CUS_BRK" 
   BEFORE INSERT OR UPDATE ON t_20_cus_brk
   FOR EACH ROW 
 BEGIN 
   IF :new.r_k IS NULL THEN 
    -- SELECT to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') INTO :new.r_k FROM dual; 
    SELECT s_20_cus_brk.NEXTVAL INTO :new.r_k FROM dual; 
   END IF; 
   IF inserting THEN 
       :new.crt_dt := localtimestamp; 
       :new.crt_by := nvl(wwv_flow.g_user,user); 
       :new.upd_dt := localtimestamp; 
       :new.upd_by := nvl(wwv_flow.g_user,user); 

    END IF; 
    IF inserting OR updating THEN 
       :new.upd_dt := localtimestamp; 
       :new.upd_by := nvl(wwv_flow.g_user,user); 
    END IF; 

 END TR_20_CUS_BRK;


/
ALTER TRIGGER "TR_20_CUS_BRK" ENABLE;
