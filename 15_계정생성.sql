--사용자 계정 확인
SELECT * FROM all_users;

--계정 생성 명령
CREATE USER user1   IDENTIFIED BY user1;

/*
DCL: GRANT(권한 부여), REVOKE(권한 회수)

CREATE USER -> 데이터베이스 유저 생성 권한
CREATE SESSION -> 데이터베이스 접속 권한
CREATE TABLE -> 테이블 생성 권한
CREATE VIEW -> 뷰 생성 권한
CREATE SEQUENCE -> 시퀀스 생성 권한
ALTER ANY TABLE -> 어떠한 테이블도 수정할 수 있는 권한
INSERT ANY TABLE -> 어떠한 테이블에도 데이터를 삽입하는 권한.
SELECT ANY TABLE...

SELECT ON [테이블 이름] TO [유저 이름] -> 특정 테이블만 조회할 수 있는 권한.
INSERT ON....
UPDATE ON....

- 관리자에 준하는 권한을 부여하는 구문.
RESOURCE, CONNECT, DBA TO [유저 이름]
*/
GRANT CREATE SESSION TO user1;
GRANT SELECT ON hr.departments TO user1;
SELECT * FROM hr.departments;
GRANT INSERT ON hr.departments TO user1;
GRANT CREATE TABLE TO user1;

-- 실제 db(users) 에 생성 권한 부여
ALTER USER user1 
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

GRANT SELECT ANY TABLE TO user1;
GRANT RESOURCE , CONNECT , DBA TO user1;
REVOKE RESOURCE,CONNECT,DBA FROM user1;

-- 사용자 계정 삭제
-- DROP USER [유저이름] CASCADE;
-- CASCADE 없을 시 -> 테이블 or 시퀀스 등 객체가 존재한다면 계정 삭제 안됨.
DROP USER user1 CASCADE;

/*
테이블 스페이스는 데이터베이스 객체 내 실제 데이터가 저장되는 공간입니다.
테이블 스페이스를 생성하면 지정된 경로에 실제 파일로 정의한 용량만큼의
파일이 생성이 되고, 데이터가 물리적으로 저장됩니다.
당연히 테이블 스페이스의 용량을 초과한다면 프로그램이 비정상적으로 동작합니다.
*/

SELECT * FROM dba_tablespaces;

CREATE USER test1 IDENTIFIED BY test1;
GRANT CREATE SESSION TO test1;
GRANT CONNECT,RESOURCE TO test1;

-- USER_TABLESPACE 테이블 스페이스를 기본 사용 공간으로 지정하고 사용량 제한.
ALTER USER test1 DEFAULT TABLESPACE user_tablespace
QUOTA UNLIMITED ON user_tablespace;

-- TABLESPACE 내의 객체를 전체 삭제
DROP TABLESPACE user_tablespace INCLUDING CONTENTS;

--물리적 파일까지 한번에 삭제하는 법
DROP TABLESPACE user_tablespace INCLUDING CONTENTS AND DATAFILES;
