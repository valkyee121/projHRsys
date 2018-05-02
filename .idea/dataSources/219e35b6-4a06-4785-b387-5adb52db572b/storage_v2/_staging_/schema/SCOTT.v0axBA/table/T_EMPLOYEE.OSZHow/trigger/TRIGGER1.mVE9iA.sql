CREATE TRIGGER TRIG_ATTE_FORBID
  BEFORE INSERT OR UPDATE OR DELETE
  ON T_HRSYS_ATTE
  BEGIN
    IF to_char(sysdate,'day') IN ('星期六','星期日') OR
      TO_NUMBER(to_char(sysdate,'hh24')) NOT BETWEEN 9 AND 18 THEN
      raise_application_error(-20001,'非工作时间禁止操作');
    END IF;
  END;
/

