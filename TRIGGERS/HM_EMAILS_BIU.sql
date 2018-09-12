--------------------------------------------------------
--  DDL for Trigger HM_EMAILS_BIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "HM_EMAILS_BIU" 
   before insert or update on HM_emails
   for each row
begin
   if :new.id is null then
      :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
   end if;
   if inserting and :new.created is null then
      :new.created    := localtimestamp;
      :new.created_by := lower(nvl(SYS_CONTEXT('APEX$SESSION','APP_USER'),user));
   end if;
   :new.updated    := localtimestamp;
   :new.updated_by := lower(nvl(SYS_CONTEXT('APEX$SESSION','APP_USER'),user));
end;




/
ALTER TRIGGER "HM_EMAILS_BIU" ENABLE;
