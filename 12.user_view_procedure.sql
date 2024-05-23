-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- localhost 를 % 로 변경 : 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';

-- 사용자에게 권한 부여 (root 에서 test1 에게 권한 부여)
-- root 계정에서 부여. 당연함.
grant select on board.author to 'test1'@'localhost';

-- test1 로 로그인 후에 root 계정에 있던 author 테이블 조회해보기
select * from board.author;

-- 환경설정을 변경 후 확정
flush privileges;

-- 권한 조회
show grants for 'test1'@'localhost';

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';

-- 사용자 삭제
drop user 'test1'@'localhost';

-- view
-- view 생성
create view author_for_marketing_team as select name, age, role from author;
-- view 조회
select * from author_for_marketing_team;
-- (test1 계정에)view 권한 부여
grant select on board.author_for_marketing_team to test1;
-- test1 계정에서 권한 확인
SELECT * FROM board.author_for_marketing_team;

-- view 수정(변경)
create or replace view author_for_marketing_team as select name, email, age, role from author;
-- view 삭제
drop view author_for_marketing_team;

-- procedure 생성
DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN 
    select 'hello world';
END
// DELIMITER ;

-- 프로시저 호출
call test_procedure();