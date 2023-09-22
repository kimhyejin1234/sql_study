
-- 집합 연산자
--서로 다른 퀴리 결과의 생들을 하나로 결합,비교,차이를 구할 수 있게 해 주는 연산자
-- UNION(합집합 중복 X), UNION ALL(합집합 중복 O) , INTERSECT(교집합), MINUS(차집합)
-- 위 아래 colunm 개수와 데이터 타입이 정확히 일치해야 합니다.

SELECT
    employee_id,first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION
SELECT
    employee_id,first_name
FROM employees
WHERE department_id = 20;

-- UNION ALL
SELECT
    employee_id,first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id,first_name
FROM employees
WHERE department_id = 20;

-- INTERSECT 교집합
SELECT
    employee_id,first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id,first_name
FROM employees
WHERE department_id = 20;

-- MINUS 차집합
SELECT
    employee_id,first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT
    employee_id,first_name
FROM employees
WHERE department_id = 20;

-- MINUS 차집합
SELECT
    employee_id,first_name
FROM employees
WHERE department_id = 20
MINUS
SELECT
    employee_id,first_name
FROM employees
WHERE hire_date LIKE '04%';
