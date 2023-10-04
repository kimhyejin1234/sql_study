-- WHILE ��

DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        DBMS_OUTPUT.put_line(v_num);
        v_count := v_count + 1;
        v_num := v_num + 1;
    END LOOP;    
END;


DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        v_num := v_num +v_count;
        v_count := v_count + 1;
    END LOOP;    
    DBMS_OUTPUT.put_line(v_num);
END;

--Ż�⹮
DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        EXIT WHEN v_count = 5;
        v_num := v_num +v_count;
        v_count := v_count + 1;
    END LOOP;    
    DBMS_OUTPUT.put_line(v_num);
END;

-- FOR��
DECLARE
    v_num NUMBER := 4;
BEGIN
    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        DBMS_OUTPUT.put_line('������ 4�� : ' || v_num || 'x' || i  || ' = ' || v_num * i);
    END LOOP;
END;


-- CONTINUE ��
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        CONTINUE WHEN i = 5;
        DBMS_OUTPUT.put_line('������ 4�� : ' || v_num || ' x ' || i  || ' = ' || v_num * i);
    END LOOP;
END;

-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)
BEGIN
    FOR i IN 2..9
    LOOP
        IF MOD(i , 2 ) = 0
        THEN 
            DBMS_OUTPUT.put_line('������ ' || i || '�� : ');    
            FOR j IN 1..9
            LOOP
                DBMS_OUTPUT.put_line( i || 'x' || j  || ' = ' || i * j);    
            END LOOP;
            DBMS_OUTPUT.put_line('--------------------');    
        END IF;
    END LOOP;    
END;



-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....
DROP TABLE board;
CREATE TABLE board (
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(10),
    title VARCHAR2(10)
);

CREATE SEQUENCE b_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;
    
BEGIN    
    FOR i IN 1..300
    LOOP
        INSERT INTO board VALUES(i , 'test'||TO_CHAR(i) , 'title'||TO_CHAR(i)); 
    END LOOP;    
    COMMIT;
END;

DECLARE
    v_NUM NUMBER := 1;
BEGIN
    WHILE v_num <= 300
    LOOP
        INSERT INTO board 
        VALUES(b_seq.NEXTVAL, 'test'||v_num , 'title'||v_num); 
        v_num := v_num + 1;
    END LOOP;    
    COMMIT;
END;
SELECT * FROM board;