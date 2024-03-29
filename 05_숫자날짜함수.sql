-- 숫자함수
-- ROUND(반올림)
-- 원하는 반올림 위치를 매개값으로 지정, 음수를 주는 것도 가능
SELECT
    ROUND(3.1415,3),ROUND(45.923,0),ROUND(49.923,-1)
FROM dual;

-- TRUNC(절사)
-- 정해진 소수점 자리수까지 잘라냅니다.
SELECT
    TRUNC(3.1415,3),TRUNC(45.923,0),TRUNC(49.923,-1)
FROM dual;

-- ABS (절대값)
SELECT ABS(-34) FROM dual;

--CEIL(올림),FLOOR(내림)
SELECT CEIL(3.14), FLOOR(3.14)
FROM dual;

--MOD(나머지)
SELECT 10/4,MOD(10,4)
FROM dual;

-- 날짜 함수
-- sysdate :  컴퓨터의 현재 날짜, 시간 정보를 가져와서 제공하는 함수
SELECT sysdate FROM dual;
SELECT systimestamp FROM dual;

-- 날짜도 연산이 가능합니다.
SELECT sysdate + 1 FROM dual;


-- 일수,주수,년수
-- 날짜 타입과 날짜 타입은 뺄셈 연상을 지원합니다.
-- 덧셈은 허용하지 않습니다.
SELECT  first_name , hire_date,
(sysdate - hire_date) as days,
(sysdate - hire_date) / 7 AS  week,
(sysdate - hire_date) / 365 AS  year
FROM employees;

--날짜 반올림,절사
--정오를 넘으면 다음날이 표기된다.
SELECT ROUND(sysdate) FROM dual;
SELECT ROUND(sysdate,'year') FROM dual;--년 기준으로 반올림
SELECT ROUND(sysdate,'month') FROM dual;--월 기준으로 반올림
SELECT ROUND(sysdate,'day') FROM dual;--일 기준으로 반올림(해당주의 일요일 날짜)

--절사
SELECT TRUNC(sysdate) FROM dual;
SELECT TRUNC(sysdate,'year') FROM dual;--년 기준으로 절사
SELECT TRUNC(sysdate,'month') FROM dual;--월 기준으로 절사
SELECT TRUNC(sysdate,'day') FROM dual;--일 기준으로 절사(해당주의 일요일 날짜)
