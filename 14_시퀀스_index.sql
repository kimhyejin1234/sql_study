-- ������ (���������� �����ϴ� ���� ����� �ִ� ��ü)

CREATE SEQUENCE dept2_seq
    START WITH 1 --���۰� (�⺻���� ������ �� �ּҰ�, ������ �� �ִ밪)
    INCREMENT BY 1 --������(����� ����, ������ ����, �⺻�� 1)
    MAXVALUE 10 -- �ִ밪(�⺻�� ������ �� 1027 , ������ �� -1)
    MINVALUE 1 -- �ּҰ�(�⺻�� ������ �� 1, ������ �� -1028)
    NOCACHE --ĳ�ø޸� ��� ����(�⺻�� : CACHE)
    NOCYCLE; -- ��ȯ ����(�⺻�� : NOCYCLE, ��ȯ��Ű���� CYCLE)
    
DROP SEQUENCE dept2_seq;    

CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    loca VARCHAR2(13),
    dept_date DATE
);    

--������ ����ϱ�(NEXTVAL , CURRVAL)
INSERT INTO dept2
VALUES (dept2_seq.NEXTVAL,'test','test',sysdate);

SELECT * FROM dept2;

SELECT dept2_seq.CURRVAL FROM dual;

--������ ����(���� ���� ����)
-- START WITH �� ������ �Ұ����մϴ�.
ALTER SEQUENCE dept2_seq MAXVALUE 9999; --�ִ밪 ����
ALTER SEQUENCE dept2_seq INCREMENT BY -1; -- ������ ����
ALTER SEQUENCE dept2_seq MINVALUE 0; --�ּҰ� ����

--������ ���� �ٽ� ó������ ������ ���
ALTER SEQUENCE dept2_seq INCREMENT BY -72;
SELECT dept2_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY 1;


/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint ������ �մϴ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ֽ��ϴ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ٶ����մϴ�.
*/
SELECT * FROM employees WHERE salary = 12008;

--�ε��� ����
CREATE INDEX emp_salary_idx ON employees(salary);

/*
���̺� ��ȸ �� ���ؽ��� ���� �÷��� �������� ����Ѵٸ�
���̺� ��ü ��ȸ�� �ƴ�, �÷��� ���� �ε����� �̿��ؼ� ��ȸ�� �����մϴ�.
�ε����� �����ϰ� �Ǹ� ������ �÷��� rowid �� ���� ���ؽ��� �غ�ǰ�,
��ȸ�� ������ �� �ش� �ε����� rowid �� ���� ���� ��ĵ�� �����ϰ� �մϴ�.
*/
DROP INDEX emp_salary_idx;


-- �������� ���ؽ��� ����ϴ� hint ���
CREATE SEQUENCE board_seq
    START WITH 1 --���۰� (�⺻���� ������ �� �ּҰ�, ������ �� �ִ밪)
    INCREMENT BY 1 --������(����� ����, ������ ����, �⺻�� 1)
    NOCACHE --ĳ�ø޸� ��� ����(�⺻�� : CACHE)
    NOCYCLE; -- ��ȯ ����(�⺻�� : NOCYCLE, ��ȯ��Ű���� CYCLE)
    
CREATE TABLE tbl_board(
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim1');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim2');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim3');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim4');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim5');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim6');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim7');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim8');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim9');
INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL,'kim10');

SELECT * FROM tbl_board
where bno = 32;
COMMIT;

ALTER INDEX SYS_C007077
RENAME TO tbl_board_idx;

SELECT * FROM 
    (
    SELECT ROWNUM AS rn , a.*
    FROM
        (
        SELECT *
        FROM tbl_board
        ORDER BY bno DESC
        ) a
    )
WHERE RN > 10 AND RN <=20 ;    

-- /*+ INDEX(table_name index_name) */
-- ������ �ε����� ������ ���Բ� ����.
-- INDEX ASC, DESC�� �߰��ؼ� ������, ������ ������ ���Բ� ���� ����.
SELECT * FROM 
    (
    SELECT /*+ INDEX_DESC(tbl_board tbl_board_idx) */
        ROWNUM AS rn,
        bno,
        writer
    FROM tbl_board
    )
WHERE RN > 10 AND RN <=20 ;  

/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ���
2. ���� �������� ���� �����ϴ� ���
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�.
*/