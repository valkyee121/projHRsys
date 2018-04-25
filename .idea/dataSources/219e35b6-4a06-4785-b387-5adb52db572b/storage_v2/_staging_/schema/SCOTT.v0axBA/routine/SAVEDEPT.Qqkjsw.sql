CREATE OR REPLACE PROCEDURE saveDept(DEPTNAME IN VARCHAR2, msg OUT NUMBER)
  AS
  v_count NUMBER(2);
  BEGIN
    SELECT count(*) INTO v_count FROM T_HRSYS_DEPT WHERE DEPT_NAME=DEPTNAME;
    IF (v_count=0) THEN
      INSERT INTO T_HRSYS_DEPT (DEPT_NAME, DEPT_BUILD_TIME, DEPT_STATUS)
        VALUES (deptName,sysdate,1);
      msg:=1;
      ELSE
        msg:=0;
    END IF;
    COMMIT ;
  END;
/

