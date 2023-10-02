
-- 1. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)
DECLARE
    v_first_name employees.first_name%TYPE;
    v_email employees.email%TYPE;
BEGIN
    SELECT first_name,email
    INTO v_first_name,v_email
    FROM employees
    WHERE employee_id=201;
    DBMS_OUTPUT.put_line('201����� �̸�,�̸��� : ' || v_first_name || ' , ' || v_email);
END;


-- 2. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�.
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/
DECLARE
    v_max_emp_id employees.employee_id%TYPE;
BEGIN
    SELECT MAX(employee_id)
    INTO v_max_emp_id
    FROM employees;

    DBMS_OUTPUT.put_line('MAX EMPLOYEE_ID : ' || v_max_emp_id);

    INSERT INTO emps 
        (employee_id,last_name,email,hire_date,job_id)
    VALUES
        (v_max_emp_id+1 ,'steven','stevenjobs',sysdate,'CEO');
    
END;

SELECT * FROM emps
ORDER BY employee_id;

DELETE FROM emps
WHERE employee_id>=207;



