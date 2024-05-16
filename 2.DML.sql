-- insert into : 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2 데이터3);
insert into author(id, name, email) values(1, 'tteia', 'tteia@naver.com');


-- select : 데이터 조회. * : 모든 컬럼 조회
select * from author;

-- id, title, content, author_id -> post에 한 건 추가
insert into posts(id, title, content, author_id) values(1, 'hello', 'hello world', 1);

-- 테이블 제약 조건 조회
-- 내가 현재 use하고 있는 스키마에서는 select * from 테이블명;
-- use 하고 있지 않다면? selecet * from board.author; (스키마 명.table);
select * from information_schema.key_column_usage where table_name = 'posts';