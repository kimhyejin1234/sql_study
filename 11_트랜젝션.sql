-- ����Ŀ�� Ȱ��ȭ ���� Ȯ��
SHOW AUTOCOMMIT;

-- �����ڹ� ��
SET AUTOCOMMIT ON;
-- �����ڹ� OFF
SET AUTOCOMMIT OFF;


SELECT * FROM  emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail.com', sysdate, 1800);

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (305, 'park', 'park1234@gmail.com', sysdate, 1800);
    
-- ���̺�����Ʈ ����.
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
--ANSI ǥ�� ������ �ƴϱ� ������ ���������� ����.
SAVEPOINT insert_park;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (306, 'kim', 'kim1234@gmail.com', sysdate, 1800);
    
ROLLBACK TO SAVEPOINT     insert_park;
SELECT * FROM emps WHERE employee_id = 306;
DELETE FROM emps WHERE employee_id = 304;

-- �������� ��� ������ ��������� ���(���)
--���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ������ ����
ROLLBACK;    

-- �������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� �����ϴ�.
COMMIT;
