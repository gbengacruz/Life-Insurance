--------------------------------------------------------
--  DDL for Trigger TR_70_CUS_ACT_TRAN 
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_70_CUS_ACT_TRAN " 
   BEFORE INSERT OR UPDATE ON t_70_cus_act_tran
   FOR EACH ROW 
 BEGIN 
   IF :new.r_k IS NULL THEN 
    -- SELECT to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') INTO :new.r_k FROM dual; 
    SELECT s_70_cus_act_tran.NEXTVAL INTO :new.r_k FROM dual; 
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

 END TR_70_CUS_ACT_TRAN;


/
ALTER TRIGGER "TR_70_CUS_ACT_TRAN " ENABLE;
