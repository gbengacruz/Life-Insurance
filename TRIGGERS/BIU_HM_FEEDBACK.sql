--------------------------------------------------------
--  DDL for Trigger BIU_HM_FEEDBACK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BIU_HM_FEEDBACK" 
    before insert or update
    on HM_feedback
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
    if inserting then
        :new.created := localtimestamp;
        :new.created_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
    end if;
    :new.updated := localtimestamp;
    :new.updated_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
end;




/
ALTER TRIGGER "BIU_HM_FEEDBACK" ENABLE;
