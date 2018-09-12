--------------------------------------------------------
--  DDL for Trigger BIU_HM_PREFERENCES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BIU_HM_PREFERENCES" 
    before insert or update on HM_preferences
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
        -- Validate Data
        if :old.is_required_yn != :new.is_required_yn
                or :old.datatype != :new.datatype
                or nvl(:old.description,'asIBj1') != nvl(:new.description,'asIBj1')
                or nvl(:old.valid_values, 'asIBj1') != nvl(:new.valid_values, 'asIBj1') then
            raise_application_error(-20100, 'Unable to update value');
        end if;
        if :old.is_required_yn = 'Y' and :new.preference_value is null then
            raise_application_error(-20101, 'Unable to set preference value to null');
        end if;
        if :old.datatype = 'NUM' then
            declare
                l_num number;
            begin
                l_num := to_number(:new.preference_value);
            exception
                when others then
                    raise_application_error(-20102, 'Invalid preference value: not a number');
            end;
        end if;
        if :old.valid_values is not null
                and ':'||:old.valid_values||':' not like '%:'||:new.preference_value||':%' then
            raise_application_error(-20103, 'Invalid preference value');
        end if;
    end if;
    :new.updated := localtimestamp;
    :new.updated_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
end;




/
ALTER TRIGGER "BIU_HM_PREFERENCES" ENABLE;
