-- ���̺� ������ ��������
--  :���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����.
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.

--�÷� ���� ���� ����(�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL  CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M','F'))
);

DROP TABLE dept2;

--���̺� ���� ���� ����(��� �� ������ ���� ������ ���ϴ� ���)
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14)NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M','F'))
);

-- �ܷ�Ű(foreign key) �� �θ����̺�(�������̺�)�� ���ٸ� INSERT �Ұ���
INSERT INTO dept2
VALUES (10,'gg',3000,100000,'M');

INSERT INTO dept2
VALUES (20,'hh',1900,100000,'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10;  --����(�ܷ�Ű �������� ����)

--���� ������ ����
--���� ������ �߰�,������ �����մϴ�. ������ �ȵ˴ϴ�.
--�����Ϸ��� �����ϰ� ���ο� �������� �߰��ϼž� �մϴ�.
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

--pk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
                        
--fk �߰�
ALTER TABLE dept2 add CONSTRAINT dept2_loca_locid_fk 
FOREIGN KEY(loca) REFERENCES locations(location_id);

--check �߰�
ALTER TABLE dept2 add CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0);

--unique �߰�
ALTER TABLE dept2 add CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

--not null �� �� �������·� �����մϴ�.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

--���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

--�������� ����(���� ���� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;

--------------------------------------------------------------------
-- ����1.
CREATE TABLE members (
    m_name VARCHAR2(10) NOT NULL,
    m_num NUMBER(4) CONSTRAINT mem_memnum_pk PRIMARY KEY,
    reg_date DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
    gender VARCHAR2(1),
    loca NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);
SELECT * FROM user_constraints
WHERE table_name = 'MEMBERS';

DROP TABLE members;

INSERT INTO members VALUES ('AAA',1,'2018-07-01','M',1800);
INSERT INTO members VALUES ('BBB',2,'2018-07-02','F',1900);
INSERT INTO members VALUES ('CCC',3,'2018-07-03','M',2000);
INSERT INTO members VALUES ('DDD',4,sysdate,'M',2000);

COMMIT;
SELECT * FROM members ORDER BY M_NAME;
-- ���� 2
SELECT a.m_name , a.m_num , 
       b.street_address,b.location_id
FROM members a 
JOIN locations b
ON a.loca = b.location_id 
ORDER BY a.m_num;
