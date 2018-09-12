--------------------------------------------------------
--  DDL for Trigger TR_70_GL_ACT_NTR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_70_GL_ACT_NTR" 
   BEFORE INSERT OR UPDATE ON t_70_gl_act_ntr
   FOR EACH ROW 
 BEGIN 
   IF :new.r_k IS NULL THEN 
    -- SELECT to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') INTO :new.r_k FROM dual; 
    SELECT s_70_gl_act_ntr.NEXTVAL INTO :new.r_k FROM dual; 
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

 END TR_70_GL_ACT_NTR;


/
ALTER TRIGGER "TR_70_GL_ACT_NTR" ENABLE;
