CREATE OR REPLACE PROCEDURE saveJob(jobName IN VARCHAR2, jobSal IN NUMBER, msg OUT NUMBER)
AS
  v_count NUMBER(2);
  BEGIN
    SELECT count(*) INTO v_count FROM T_HRSYS_JOB WHERE JOB_NAME=jobName;
    IF (v_count=0) THEN
      INSERT INTO T_HRSYS_JOB (JOB_NAME, JOB_SALARY, JOB_STATUS)
      VALUES (jobName,jobSal,1);
      msg:=1;
    ELSE
      msg:=0;
    END IF;
    COMMIT ;
  END;
/

