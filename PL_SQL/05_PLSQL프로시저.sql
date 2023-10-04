-- ���ν���(procedure) -> void �޼��� ����
-- Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ� ��� (����)
-- ������ ���ν����� ���ؼ� ���� �����ϴ� ����� �ֽ��ϴ�.

CREATE PROCEDURE gogoproc 
    (P_dan IN NUMBER)
IS
BEGIN
    DBMS_OUTPUT.put_line(p_dan || '��');
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.put_line(p_dan || 'X' || i || '=' || p_dan*i);
    END LOOP;
END;

EXEC gogoproc(5);

--�Ű���(�μ�) ���� ���ν���
CREATE PROCEDURE p_test
IS
    v_msg VARCHAR2(30) := 'Hello Procedure!';
BEGIN
    DBMS_OUTPUT.put_line(v_msg);
END;
DROP PROCEDURE p_test;
EXEC p_test;



-- IN �Է°��� ���� �� ���޹޴� ���ν���
CREATE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    )
IS
BEGIN
    INSERT INTO jobs
    VALUES(p_job_id,p_job_title,p_min_sal,p_max_sal);
    COMMIT;
END;

DROP PROCEDURE my_new_job_proc;
EXEC my_new_job_proc('JOB2','test job2',20000,30000);
SELECT * FROM jobs;

-- job_id �� Ȯ���ؼ�
-- �̹� �����ϴ� �����Ͷ�� ����, ���ٸ� ���Ӱ� �߰�(job_id�� pk �̱� ����)
CREATE OR REPLACE PROCEDURE my_new_job_proc --���� ���ν��� ������ ����
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    --������ job_id �� �ִ������� üũ
    --�̹� �����Ѵٸ�1,�������� �ʴ´ٸ� 0 -> v_cnt �� ����.
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        INSERT INTO jobs
        VALUES(p_job_id,p_job_title,p_min_sal,p_max_sal);
    ELSE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;
EXEC my_new_job_proc('JOB4','test job4',2000,3000);

-- �Ű���(�μ�)�� ����Ʈ ��(�⺻��) ����
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    --������ job_id �� �ִ������� üũ
    --�̹� �����Ѵٸ�1,�������� �ʴ´ٸ� 0 -> v_cnt �� ����.
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        INSERT INTO jobs
        VALUES(p_job_id,p_job_title,p_min_sal,p_max_sal);
    ELSE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;
EXEC my_new_job_proc('JOB5','test job5');


----------------------------------------------------------
-- OUT , IN OUT �Ű����� ���
-- OUT ������ ����ϸ� ���ν��� �ٱ������� ���� �����ϴ�.
-- OUT �� �̿��ؼ� ���� ���� �ٱ� �͸� ��Ͽ��� �����ؾ� �մϴ�.

CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000,
     p_result OUT VARCHAR2  --�ٱ��ʿ��� ����� �ϱ� ���� ����
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100):= '�������� �ʴ� ���̶� insert ó�� �Ǿ����ϴ�.';
BEGIN
    --������ job_id �� �ִ������� üũ
    --�̹� �����Ѵٸ�1,�������� �ʴ´ٸ� 0 -> v_cnt �� ����.
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        INSERT INTO jobs
        VALUES(p_job_id,p_job_title,p_min_sal,p_max_sal);
    ELSE --������ �����ϴ� �����Ͷ�� ��ȸ�� ����� ����.
        SELECT 
            p_job_id || '�� �ִ� ���� : ' || max_salary || ', �ּҿ��� : ' || min_salary
        INTO
            v_result  -- ��ȸ ����� ������ ����
        FROM jobs
        WHERE job_id = p_job_id;
        
        
    END IF;
    
    --out �Ű������� ��ȸ ����� �Ҵ�.
    p_result := v_result;
    COMMIT;
END;

DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('JOB2','test job2',2000,8000,msg);
    dbms_output.put_line(msg);
    
    my_new_job_proc('CEO','test ceo',200000,800000,msg);
    dbms_output.put_line(msg);
END;
SELECT * FROM jobs;


----------------------------------------------------------------------------

-- IN, OUT ���ÿ� ó��
CREATE OR REPLACE PROCEDURE my_parmeter_test_proc
    (
    -- IN: ��ȯ �Ұ�, �޴� �뵵�θ� Ȱ��
    p_var1 IN VARCHAR2,
    -- OUT: �޴� �뵵�δ� Ȱ�� �Ұ���,
    -- OUT�� �Ǵ� ������ ���ν����� ���� ��, �� �������� �Ҵ��� �ȵ�.
    p_var2 OUT VARCHAR2,
    -- IN , OUT �� �� �� ������.
    p_var3 IN OUT VARCHAR2
    )
IS
BEGIN
    DBMS_OUTPUT.put_line('p_var1 : ' || p_var1); --IN : �翬�� ��µ�
    DBMS_OUTPUT.put_line('p_var2 : ' || p_var2); --OUT: ���� ���޵��� ����.
    DBMS_OUTPUT.put_line('p_var3 : ' || p_var3); --IN OUT: IN �� ������ ������ �ֱ���~
    -- p_var1 := '���1'; IN ������ �� �Ҵ� ��ü�� �Ұ���.
    p_var2 := '���2';
    p_var3 := '���3';
    
    
END;

DECLARE
    v_var1 VARCHAR(10) := 'value1';
    v_var2 VARCHAR(10) := 'value2';
    v_var3 VARCHAR(10) := 'value3';
BEGIN
    my_parmeter_test_proc(v_var1,v_var2,v_var3);
    
    DBMS_OUTPUT.put_line('V_var1 : ' || V_var1); 
    DBMS_OUTPUT.put_line('V_var2 : ' || V_var2); 
    DBMS_OUTPUT.put_line('V_var3 : ' || V_var3); 
    
END;


-- RETURN
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_result OUT VARCHAR2  
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100):= '�������� �ʴ� ���̶� insert ó�� �Ǿ����ϴ�.';
BEGIN
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        DBMS_OUTPUT.put_line(p_job_id || '�� ���̺� �������� �ʽ��ϴ�.');
        RETURN; -- ���ν��� ���� ����
    END IF;
    --������ �����ϴ� �����Ͷ�� ��ȸ�� ����� ����.
    SELECT 
        p_job_id || '�� �ִ� ���� : ' || max_salary || ', �ּҿ��� : ' || min_salary
    INTO
        v_result  -- ��ȸ ����� ������ ����
    FROM jobs
    WHERE job_id = p_job_id;

    p_result := v_result;
    COMMIT;
END;

DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('IT_PROG1',msg);
    dbms_output.put_line(msg);
END;

-------------------------------------------------------------------
-- ���� ó��
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10/0;
    /*
    OTHERS �ڸ��� ������ Ÿ���� �ۼ��� �ݴϴ�.
    ACCESS_INTO_NULL -> ��ü �ʱ�ȭ�� �Ǿ� ���� ���� ���¿��� ���.
    NO_DATA_FOUND -> SELECT INTO �� �����Ͱ� �� �ǵ� ���� ��
    ZERO_DIVIDE -> 0���� ���� ��
    VALUE_ERROR -> ��ġ �Ǵ� �� ����
    INVALID_NUMBER -> ���ڸ� ���ڷ� ��ȯ�� �� ������ ���
    */
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('0���� ������ �ȵǿ�');
            dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE);
            dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);
        WHEN OTHERS THEN
            -- WHEN ���� ������ ���ܰ� �ƴ� �ٸ� ���ܰ� �߻� �� OTHERS �߻�
            dbms_output.put_line('�� �� ���� ���� �߻�');
    
END;