-- insert into : 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2 데이터3);
insert into author(id, name, email) values(1, 'tteia', 'tteia@naver.com');


-- select : 데이터 조회. * : 모든 컬럼 조회
select * from author;

-- id, title, content, author_id -> post에 한 건 추가
insert into posts(id, title, content, author_id) values(1, 'hello', 'hello world', 1);

-- 테이블 제약 조건 조회
-- 내가 현재 use하고 있는 스키마에서는 select * from 테이블명;
-- use 하고 있지 않다면? select * from board.author; (스키마 명.table);
select * from information_schema.key_column_usage where table_name = 'posts';

-- update 테이블명 set 컬럼명1=데이터1, 컬럼명2=데이터2, ...  where id = 1;
-- where문이 빠질 경우 모든 데이터에 update 가 적용됨.
update author set email='abc@test.com' where id=2;


-- delete from 테이블명 where
delete from author where id = 3;

-- SELECT의 다양한 조회 방법
select * from author;
select * from author where id = 1;
select * from author where id > 2 and name = bambi;

-- 특정 컬럼만 조회할 때
select name, email from author where id = 3;

-- 중복 제거하고 조회
select distinct title from post;

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬 조건없이 조회할 경우에는 pk 기준 오름차순으로 조회.
-- asc : 오름차순, desc : 내림차순
select * from author order by name asc;

-- 멀티 order by : 여러 컬럼으로 정렬. 먼저 쓴 컬럼 우선 정렬, 그 다음 정렬 옵션 적용.
-- asc : 오름차순, desc : 내림차순
select * from post order by contents;
select * from post order by title, id desc; -- 중복일 경우에 id desc 하겠다!

-- limit number : 특정 숫자로 결과값 개수 제한
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a; -- 테이블이 여러 개일 때 사용

-- null을 조회 조건으로
select * from post where author_id is null; -- 비어있는 것만 조회 null / 아닌 것 not null
