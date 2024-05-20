-- dirty read 실습
-- auto_commit 해제 후 update 실행 -> commit이 안 된 상태. >> 1트랜잭션
-- 터미널을 열어 select 했을 때, 위 변경사항이 변경됐는지 확인 >> 2트랜잭션


-- phantom read 동시성 이슈 실습
-- 디비버에서 시간을 두고 2번의 select 실행, 터미널에서 중간에 insert를 실행해도
-- 디비버에서는 두 번의 select 결과가 모두 동일해야 함.

START TRANSACTION;
SELECT COUNT(*) from author; -- count > 갯수 세기
do sleep(15);
SELECT COUNT(*) from author;
commit;

-- 터미널에서 아래 insert문 실행
insert into author(name, email) values ('kim', 'kim@test.com');


-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 디비버에서 아래 코드 실행
start transaction;
select post_count from author where id = 1 lock in share mode;
do sleep(15);
select post_count from author where id = 1 lock in share mode;
commit;

-- 터미널 실행
select post_count from author where id = 1 lock in share mode;
update author set post_count = 0 where id = 1;


-- 배타적 잠금(exclusive lock) : select for update
-- select 부터 바로 lock !
start transaction;
select post_count from author where id = 1 for update;
do sleep(15);
select post_count from author where id = 1 for update;
commit;

-- 터미널 실행
select post_count from author where id = 1 for update;
update author set post_count = 0 where id = 1;