
--그룹 함수 AVG,MAX,MIN,SUM,COUNT

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT  COUNT(*) FROM employees; --총 행 데이터의 수
SELECT  COUNT(commission_pct) FROM employees; --null 은 count 되지 않는다.

--부서별로 그룹화, 그룹함수의 사용
--주의할 점) 
--    그룹함수는 일반 컬럼과 동시에 그냥 출력할 수는 없습니다.

SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;

SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY job_id, department_id
ORDER BY job_id, department_id;

-- GROUP BY 를 통해 그룹화 할 때 조건을 걸 경우 HAVING 을 사용
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;

SELECT
    job_id,
    count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5;


--부서id 가 50 이상인 것들을 그룹화 시키고, 그룹 월급 평균이 5000 이상만 조회
SELECT 
    department_id,
    AVG(salary) AS 평균
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >=5000
ORDER BY department_id DESC;

/*
문제 1.
1-1사원 테이블에서 JOB_ID별 사원 수를 구하세요.
1-2사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/
SELECT 
    job_id,
    COUNT(*) AS 사원수
FROM employees
GROUP BY job_id;

SELECT 
    job_id,
    AVG(salary) AS 평균월급
FROM employees
GROUP BY job_id
ORDER BY 평균월급 DESC;


/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/
SELECT 
    TO_CHAR(hire_date,'YYYY') AS 입사년도,
    COUNT(*) AS 사원수
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
ORDER BY 입사년도;


/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/
SELECT 
    department_id,
    AVG(salary) AS 평균급여
FROM employees
WHERE salary >= 5000
GROUP BY department_id
HAVING AVG(salary) >= 7000;



/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
*/
SELECT 
    department_id,
    TRUNC(AVG(salary+(salary*commission_pct)),2) AS 평균급여,
    SUM(salary+(salary*commission_pct)) AS 합계,
    COUNT(*) AS count
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;
