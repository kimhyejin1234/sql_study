--MERGE : 테이블 병합

/*
UPDATE 와 INSERT 를 한 방에 처리.
한 테이블에 해당하는 데이터가 있다면 UPDATE를,
없으면 INSERT 로 처리해라.
*/
CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);
INSERT INTO emps_it
    (employee_id,first_name,last_name,email,hire_date,job_id)
VALUES
    (105,'데이비드','김','DAVIDKIM',sysdate , 'IT_PROG');
    
INSERT INTO emps_it
    (employee_id,first_name,last_name,email,hire_date,job_id)
VALUES
    (106,'머스크','일론','ELONMUSK',sysdate , 'IT_PROG');    
    
SELECT * FROM employees
WHERE job_id ='IT_PROG'; 

SELECT * FROM emps_it;

MERGE INTO emps_it a --(머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM employees
         WHERE job_id = 'IT_PROG') b -- 병합하고자 하는 데이터를 서브쿼리로 표현.
    ON --병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN --조건이 일치라는 경우에는 타겟 테이블에 이렇게 실행하라.
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id =  b.department_id
WHEN NOT MATCHED THEN 
    INSERT /*속성(컬럼)*/ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
 
 
---------------------------------------------------------------
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');


select * from emps_it
ORDER BY employee_id;
/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
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

MERGE INTO emps_it a --(머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM employees
         WHERE job_id = 'IT_PROG') b -- 병합하고자 하는 데이터를 서브쿼리로 표현.
    ON --병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN --조건이 일치라는 경우에는 타겟 테이블에 이렇게 실행하라.
    UPDATE SET 
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id =  b.department_id
        
         /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
        */
    DELETE
        WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN 
    INSERT /*속성(컬럼)*/ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
 
/*
문제 1.
DEPTS테이블의 다음을 추가하세요
DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID
    280개발 null 1800
    290회계부 null 1800
    300재정 301 1800
    310인사 302 1800
    320영업 303 1700

*/
CREATE TABLE depts AS
    (SELECT * FROM departments);
     
INSERT INTO depts (department_id,department_name,location_id) 
VALUES(280,'개발',1800); --1 행 이(가) 삽입되었습니다.
INSERT INTO depts VALUES(290,'회계부',null,1800); --1 행 이(가) 삽입되었습니다.
INSERT INTO depts VALUES(300,'재정',301,1800); -- 1 행 이(가) 삽입되었습니다.
INSERT INTO depts VALUES(310,'인사',302,1800); --1 행 이(가) 삽입되었습니다.
INSERT INTO depts VALUES(320,'영업',303,1800);  -- 1 행 이(가) 삽입되었습니다.
DROP TABLE depts;
select * from depts;
select * from departments;
/*
문제 2.
DEPTS테이블의 데이터를 수정합니다
1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
2. department_id가 290인 데이터의 manager_id를 301로 변경
3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
1800으로 변경하세요
4. 회계, 재정, 인사, 영업부의 매니저 아이디를 301로 일괄 변경하세요.
*/
ROLLBACK;
UPDATE depts 
SET department_name = 'IT bank'
WHERE department_name = 'IT Support'; -- 1 행 이(가) 업데이트되었습니다.

UPDATE depts 
SET manager_id = 301
WHERE department_id = 290; -- 1개 행 이(가) 업데이트되었습니다.

UPDATE depts 
SET department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk'; -- 1 행 이(가) 업데이트되었습니다.

UPDATE depts 
SET manager_id = 301
WHERE department_name IN ('회계부','재정','인사','영업'); -- 4 행 이(가) 업데이트되었습니다.


select * from departments;


/*
문제 3.
삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
1. 부서명 영업부를 삭제 하세요
2. 부서명 NOC를 삭제하세요
*/
DELETE FROM depts  
WHERE department_id = 
    (SELECT department_id FROM depts WHERE department_name = '영업');
    -- 1 행 이(가) 삭제되었습니다.

DELETE FROM depts  
WHERE department_id = 
    (SELECT department_id FROM depts WHERE department_name = 'NOC');
    -- 1 행 이(가) 삭제되었습니다.


/*
문제4
1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
3. Depts 테이블은 타겟 테이블 입니다.
4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
*/
DELETE FROM depts  
WHERE department_id > 200; 
    -- 10 행 이(가) 삭제되었습니다.

UPDATE depts 
SET manager_id = 100
WHERE manager_id IS NOT null; --11개 행 이(가) 업데이트되었습니다.

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
    --27개 행 이(가) 병합되었습니다.
        

/*
문제 5
1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
2. jobs_it 테이블에 다음 데이터를 추가하세요
    JOB_ID JOB_TITLE MIN_SALARY MAX_SALARY
    IT_DEV 아이티개발팀 6000 20000
    NET_DEV 네트워크개발팀 5000 20000
    SEC_DEV 보안개발팀 6000 1900

3. jobs_it은 타겟 테이블 입니다
4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
min_salary컬럼이 5000보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
데이터는 그대로 추가해주는 merge문을 작성하세요
*/

CREATE TABLE jobs_it AS
    (SELECT * FROM jobs WHERE min_salary > 6000 ); -- Table JOBS_IT이(가) 생성되었습니다.
SELECT * FROM jobs_it;    

INSERT INTO jobs_it VALUES ('IT_DEV','아이티개발팀',6000,20000); -- 1 행 이(가) 삽입되었습니다.
INSERT INTO jobs_it VALUES ('NET_DEV','네트워크개발팀',5000,20000); -- 1 행 이(가) 삽입되었습니다.
INSERT INTO jobs_it VALUES ('SEC_DEV','보안개발팀',6000,19000); -- 1 행 이(가) 삽입되었습니다.

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
-- 9개 행 이(가) 병합되었습니다.
    