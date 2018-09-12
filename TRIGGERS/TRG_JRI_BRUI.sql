--------------------------------------------------------
--  DDL for Trigger TRG_JRI_BRUI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_JRI_BRUI" 
BEFORE INSERT OR UPDATE ON JRXML_REPORT_IMAGES
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.JRI_ADLER32_VALID:='N';
  ELSE
    IF     :OLD.JRI_ADLER32_VALID='Y'
       AND :NEW.JRI_ADLER32_VALID='Y' THEN
      :NEW.JRI_ADLER32_VALID:='N';
    END IF;
  END IF;
END;




/
ALTER TRIGGER "TRG_JRI_BRUI" ENABLE;
