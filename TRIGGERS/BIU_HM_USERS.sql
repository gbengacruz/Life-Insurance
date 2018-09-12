--------------------------------------------------------
--  DDL for Trigger BIU_HM_USERS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BIU_HM_USERS" 
    before insert or update on HM_users
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
    :new.username := upper(:new.username);
    :new.email_address := lower(:new.email_address);
end;




/
ALTER TRIGGER "BIU_HM_USERS" ENABLE;
