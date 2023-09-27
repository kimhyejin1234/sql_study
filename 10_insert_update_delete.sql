-- insert
--���̺� ���� Ȯ��
DESC departments;

-- INSERT �� ù��° ���(��� �÷� �����͸� �� ���� ����)
INSERT INTO departments
VALUES(300,'���ߺ�',null,null);

SELECT * FROM departments;
ROLLBACK; --���� ������ �ٽ� �ڷ� �ǵ����� Ű����


-- INSERT �� �ι�° ���(���� �÷��� �����ϰ� ����,NOT NULL Ȯ���ϼ���)
INSERT INTO departments
    (department_id,department_name,manager_id,location_id)
VALUES(280,'������',103,1700);

INSERT INTO departments
    (department_id,department_name,location_id)
VALUES(290,'�ѹ���',1700);

--�纻 ���̺� ���� (CTAS)
-- �纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� ������ ���� ��� ����
--WHERE ���� flase��(1=2) �����ϸ� -> ���̺��� ������ ����ǰ� �����ʹ� ���� X
CREATE TABLE emps AS 
(SELECT employee_id,first_name,job_id,hire_date
FROM employees WHERE 1=2);

SELECT * FROM emps;
DROP TABLE emps;

-- INSERT(��������)
INSERT INTO emps
(SELECT employee_id,first_name,job_id,hire_date
FROM employees WHERE department_id=50);

----------------------------------------------------------
-- UPDATE
CREATE TABLE emps AS 
(SELECT * FROM employees );

--update �� ������ ���� ������ ������ �� �� �����ؾ� �մϴ�.
--�׷��� ������ ���� ����� ���̺� ��ü�� ����˴ϴ�.
UPDATE emps SET salary = 30000;
ROLLBACK;
UPDATE emps SET salary = 30000
WHERE employee_id = 100;

--update(��������)
UPDATE emps
SET (job_id , salary , manager_id) = 
    (
        SELECT job_id , salary , manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id=101;

------------------------------------------
--DELETE
DELETE FROM emps;

--DELETE(��������)
DELETE FROM emps
WHERE department_id = ( SELECT department_id FROM departments
                        WHERE department_name = 'IT');  

