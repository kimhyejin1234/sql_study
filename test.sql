CREATE TABLE score(

    stu_num NUMBER(4) PRIMARY KEY,
    stu_name VARCHAR2(30) NOT NULL,
    kor NUMBER(3) NOT NULL,
    eng NUMBER(3) NOT NULL,
    math NUMBER(3) NOT NULL,
    total NUMBER(3) DEFAULT 0,
    average NUMBER(5,2),
    grade VARCHAR2(5)
);
CREATE SEQUENCE score_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;
    
SELECT * FROM score;    