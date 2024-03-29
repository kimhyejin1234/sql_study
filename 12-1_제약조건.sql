-- 테이블 생성과 제약조건
--  :테이블에 부적절한 테이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음.
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.

--컬럼 레벨 제약 조건(컬럼 선언마다 제약조건 지정)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL  CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M','F'))
);

DROP TABLE dept2;

--테이블 레벨 제약 조건(모든 열 선언후 제약 조건을 취하는 방식)
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

-- 외래키(foreign key) 가 부모테이블(참조테이블)에 없다면 INSERT 불가능
INSERT INTO dept2
VALUES (10,'gg',3000,100000,'M');

INSERT INTO dept2
VALUES (20,'hh',1900,100000,'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10;  --실패(외래키 제약조건 위반)

--제약 조건을 변경
--제약 조건은 추가,삭제만 가능합니다. 변경은 안됩니다.
--변경하려면 삭제하고 새로운 내용으로 추가하셔야 합니다.
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

--pk 추가
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
                        
--fk 추가
ALTER TABLE dept2 add CONSTRAINT dept2_loca_locid_fk 
FOREIGN KEY(loca) REFERENCES locations(location_id);

--check 추가
ALTER TABLE dept2 add CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0);

--unique 추가
ALTER TABLE dept2 add CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

--not null 은 열 수정형태로 변경합니다.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

--제약 조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

--제약조건 삭제(제약 조건 이름으로)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;

--------------------------------------------------------------------
-- 문제1.
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
-- 문제 2
SELECT a.m_name , a.m_num , 
       b.street_address,b.location_id
FROM members a 
JOIN locations b
ON a.loca = b.location_id 
ORDER BY a.m_num;
