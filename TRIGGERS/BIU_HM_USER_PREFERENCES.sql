--------------------------------------------------------
--  DDL for Trigger BIU_HM_USER_PREFERENCES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BIU_HM_USER_PREFERENCES" 
    before insert or update on HM_user_preferences
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
    if inserting then
        :new.created := localtimestamp;
        :new.created_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
        :new.row_version_number := 1;
    elsif updating then
        :new.row_version_number := nvl(:old.row_version_number,1) + 1;
    end if;
    :new.updated := localtimestamp;
    :new.updated_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
end;




/
ALTER TRIGGER "BIU_HM_USER_PREFERENCES" ENABLE;
