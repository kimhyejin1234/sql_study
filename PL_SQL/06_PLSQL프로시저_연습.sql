/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
    (
    p_num IN NUMBER
    )
IS
    v_result NUMBER := 0;
BEGIN
    FOR i IN 1..p_num
    LOOP
        IF MOD(p_num , i) = 0 THEN
            v_result := v_result + 1;
        END IF;
    END LOOP;
    dbms_output.put_line('���� ' || p_num || ' �� ����� ������ ' || v_result || ' �� �Դϴ�.'); 

END;

EXEC divisor_proc(72);


/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (
    p_dept_id IN depts.department_id%TYPE,
    p_dept_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS  v_cnt NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_dept_id;
    
    CASE 
    WHEN p_flag = 'I' THEN
        IF v_cnt = 1 THEN
            dbms_output.put_line('�̹� �μ���ȣ�� �����մϴ�.');
            RETURN;
        END IF;
        INSERT INTO depts (department_id,department_name)
        VALUES(p_dept_id,p_dept_name);
    WHEN p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            DBMS_OUTPUT.put_line('�μ���ȣ�� �����ϴ�.');
            RETURN;
        END IF;
        
        DELETE FROM  depts
        WHERE department_id = p_dept_id;
            
    WHEN p_flag = 'U' THEN
        IF v_cnt = 0 THEN
            DBMS_OUTPUT.put_line('�μ���ȣ�� �����ϴ�.');
            RETURN;
        END IF;
        UPDATE depts
        SET department_name = p_dept_name
        WHERE department_id = p_dept_id;        

    ELSE
        DBMS_OUTPUT.put_line('�Ű����� I/U/D �� �ƴմϴ�.');
    END CASE;    
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('������ �߻��߽��ϴ�.' || SQLERRM);
            ROLLBACK;
END;

EXEC depts_proc(4513,'������1','u');
SELECT * FROM depts;

CREATE OR REPLACE PROCEDURE depts_proc
    (
    p_department_id IN depts.department_id%TYPE,
    p_department_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_department_id;
    
    IF p_flag = 'I' THEN
        INSERT INTO depts
        (department_id, department_name)
        VALUES(p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts
        SET department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN;
        END IF;
        
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;

END;

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
CREATE OR REPLACE PROCEDURE emp_test
    ( p_emp_id IN employees.employee_id%TYPE,
      p_result OUT NUMBER )
IS v_result NUMBER := 0
BEGIN
    SELECT 
END;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/