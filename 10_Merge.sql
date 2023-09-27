--MERGE : ���̺� ����

/*
UPDATE �� INSERT �� �� �濡 ó��.
�� ���̺� �ش��ϴ� �����Ͱ� �ִٸ� UPDATE��,
������ INSERT �� ó���ض�.
*/
CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);
INSERT INTO emps_it
    (employee_id,first_name,last_name,email,hire_date,job_id)
VALUES
    (105,'���̺��','��','DAVIDKIM',sysdate , 'IT_PROG');
    
INSERT INTO emps_it
    (employee_id,first_name,last_name,email,hire_date,job_id)
VALUES
    (106,'�ӽ�ũ','�Ϸ�','ELONMUSK',sysdate , 'IT_PROG');    
    
SELECT * FROM employees
WHERE job_id ='IT_PROG'; 

SELECT * FROM emps_it;

MERGE INTO emps_it a --(������ �� Ÿ�� ���̺�)
    USING -- ���ս�ų ������
        (SELECT * FROM employees
         WHERE job_id = 'IT_PROG') b -- �����ϰ��� �ϴ� �����͸� ���������� ǥ��.
    ON --���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN --������ ��ġ��� ��쿡�� Ÿ�� ���̺� �̷��� �����϶�.
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id =  b.department_id
WHEN NOT MATCHED THEN 
    INSERT /*�Ӽ�(�÷�)*/ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
 
 
---------------------------------------------------------------
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');


select * from emps_it
ORDER BY employee_id;
/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
*/
MERGE INTO emps_it a
    USING 
        (SELECT * FROM employees) b
    ON
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id =  b.department_id,
        a.email = b.email
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

ROLLBACK;

MERGE INTO emps_it a --(������ �� Ÿ�� ���̺�)
    USING -- ���ս�ų ������
        (SELECT * FROM employees
         WHERE job_id = 'IT_PROG') b -- �����ϰ��� �ϴ� �����͸� ���������� ǥ��.
    ON --���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN --������ ��ġ��� ��쿡�� Ÿ�� ���̺� �̷��� �����϶�.
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id =  b.department_id
        
         /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
        */
    DELETE
        WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN 
    INSERT /*�Ӽ�(�÷�)*/ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
 
/*
���� 1.
DEPTS���̺��� ������ �߰��ϼ���
DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID
    280���� null 1800
    290ȸ��� null 1800
    300���� 301 1800
    310�λ� 302 1800
    320���� 303 1700

*/
CREATE TABLE depts AS
    (SELECT * FROM departments);
     
INSERT INTO depts (department_id,department_name,location_id) 
VALUES(280,'����',1800); --1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO depts VALUES(290,'ȸ���',null,1800); --1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO depts VALUES(300,'����',301,1800); -- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO depts VALUES(310,'�λ�',302,1800); --1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO depts VALUES(320,'����',303,1800);  -- 1 �� ��(��) ���ԵǾ����ϴ�.
DROP TABLE depts;
select * from depts;
select * from departments;
/*
���� 2.
DEPTS���̺��� �����͸� �����մϴ�
1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
2. department_id�� 290�� �������� manager_id�� 301�� ����
3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
1800���� �����ϼ���
4. ȸ��, ����, �λ�, �������� �Ŵ��� ���̵� 301�� �ϰ� �����ϼ���.
*/
ROLLBACK;
UPDATE depts 
SET department_name = 'IT bank'
WHERE department_name = 'IT Support'; -- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE depts 
SET manager_id = 301
WHERE department_id = 290; -- 1�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE depts 
SET department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk'; -- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE depts 
SET manager_id = 301
WHERE department_name IN ('ȸ���','����','�λ�','����'); -- 4 �� ��(��) ������Ʈ�Ǿ����ϴ�.


select * from departments;


/*
���� 3.
������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
1. �μ��� �����θ� ���� �ϼ���
2. �μ��� NOC�� �����ϼ���
*/
DELETE FROM depts  
WHERE department_id = 
    (SELECT department_id FROM depts WHERE department_name = '����');
    -- 1 �� ��(��) �����Ǿ����ϴ�.

DELETE FROM depts  
WHERE department_id = 
    (SELECT department_id FROM depts WHERE department_name = 'NOC');
    -- 1 �� ��(��) �����Ǿ����ϴ�.


/*
����4
1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
*/
DELETE FROM depts  
WHERE department_id > 200; 
    -- 10 �� ��(��) �����Ǿ����ϴ�.

UPDATE depts 
SET manager_id = 100
WHERE manager_id IS NOT null; --11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

MERGE INTO depts a
    USING
        (SELECT * FROM departments ) b
    ON
        (a.department_id = b.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.department_id,b.department_name,b.manager_id,b.location_id);
    --27�� �� ��(��) ���յǾ����ϴ�.
        

/*
���� 5
1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
    JOB_ID JOB_TITLE MIN_SALARY MAX_SALARY
    IT_DEV ����Ƽ������ 6000 20000
    NET_DEV ��Ʈ��ũ������ 5000 20000
    SEC_DEV ���Ȱ����� 6000 1900

3. jobs_it�� Ÿ�� ���̺� �Դϴ�
4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
min_salary�÷��� 5000���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
*/

CREATE TABLE jobs_it AS
    (SELECT * FROM jobs WHERE min_salary > 6000 ); -- Table JOBS_IT��(��) �����Ǿ����ϴ�.
SELECT * FROM jobs_it;    

INSERT INTO jobs_it VALUES ('IT_DEV','����Ƽ������',6000,20000); -- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO jobs_it VALUES ('NET_DEV','��Ʈ��ũ������',5000,20000); -- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO jobs_it VALUES ('SEC_DEV','���Ȱ�����',6000,19000); -- 1 �� ��(��) ���ԵǾ����ϴ�.

MERGE INTO jobs_it a
    USING
        (SELECT * FROM jobs 
         WHERE min_salary > 5000) b
    ON
        (a.job_id = b.job_id) 
WHEN MATCHED THEN
    UPDATE SET
         a.min_salary = b.min_salary, 
         a.max_salary = b.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES
        (b.job_id , b.job_title , b.min_salary , b.max_salary);
-- 9�� �� ��(��) ���յǾ����ϴ�.
    