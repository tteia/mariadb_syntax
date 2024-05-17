-- tinyint는 -128 ~ 127까지 표현
-- 실습 => author 테이블에 age 컬럼 추가
alter table author add column age tinyint;
-- insert 시 age 조정해서 값 넣어보기
insert into author(id, email, age) values(5, 'hello1@test.com', 130);
insert into author(id, email, age) values(5, 'hello1@test.com', 125);
-- unsigned 시 255까지 표현 범위 확대
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(6, 'hello1@test.com', 200);

-- decimal 실습 (소수점 고정 실수 타입)
alter table post add column price decimal(10,3); -- 총 자리수 10자리, 소수부 3자리. 넘으면 알아서 잘린다!
describe post;

-- decimal 소수점 초과 값 입력 후 잘림 확인
insert into post(id, title, price) values(6, 'hello java', 3.123123);
-- update : 1234.1
update post set price='1234.1' where id=6;


-- blob 바이너리 데이터 실습
-- author 테이블에 profile_photo 컬럼을 blob 형식으로 추가
ALTER TABLE author modify COLUMN profile_photo longblob;
INSERT INTO author(id, email, profile_photo) VALUES(7, 'abc@test.com', LOAD_FILE('/Users/tteia/tteia-picture-1676009404091.png'));

-- enum : 삽인될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼 / not null 일 때 default를 지정해주지 않으면 자동으로 enum(1,2)의 1번이 값으로 지정된다!
ALTER TABLE author ADD COLUMN ROLE ENUM('admin', 'user') NOT NULL DEFAULT 'user';

-- enum 컬럼 실습
-- user1 을 insert => 에러
insert into author(id, email, role) values(8, 'test@test.com', 'user1');
-- user 또는 admin insert => 정상
insert into author(id, email, role) values(8, 'test@test.com', 'user');


-- DATE / DATETIME 실습
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date; 
insert into author(id, email, birth_day) values(9, 'tteia@test.com', '1996-04-30'); -- date 타입이 아닌 varchar 였어도 들어갈 값. 왜 date ? => +40을 한다면 40일이 더해짐. varchar 였으면 계산이 X

-- author, post 둘 다 datetime으로 created_time 컬럼 추가
alter table author add column created_time datetime;
alter table post add column created_time datetime;

insert into author(id, email, created_time) values(10, 'abc@abc.com', '1999-01-01 23:11:32');
insert into post(id, title, created_time) values(7, 'hello', '1999-01-01 23:11:32');

alter table author modify column created_time datetime default current_timestamp;
insert into author(id, email) values(11, 'abc@abc.com');

-- 비교 연산자
-- and 또는 && / or 또는 || / NOT 또는 !
select * from post where id >=2 and id <= 4;
select * from post where id between 2 and 4;
select * from post where not(id > 2 or id > 4);
-- NULL 여부 확인
select * from post where contents is null;
select * from post where contents is not null;
-- in(리스트 형태), not in(리스트 형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);
-- like :  특정 문자를 포함하는 데이터를 조회하기 위해서 사용하는 키워드
select * from post where title like '%o'; --o로 끝나는 title 검색
select * from post where title like 'h%'; --h로 시작하는 title 검색
select * from contents where title like '%orl%'; --단어 중간에 orl 이라는 키워드가 있는 경우 검색
select * from post where title not like '%o'; --o로 시작하지 않는 title 검색

-- ifnull(a,b) : 만약에 a가 null이면 b 반환, null이 아니면 a반환.
select title, contents, author_id from post;
select title, contents, ifnull(author_id, '익명') as 저자 from post;

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name REGEXP '[a-z]';
select * from author where name REGEXP '[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST / CONVERT
select CAST(20200101 AS DATE);
SELECT CAST('20200101' AS DATE);
select CONVERT(20200101, DATE);
SELECT CONVERT('20200101', DATE);

-- datetime 조회 방법
select * from post where created_time like '2024-05%';
select * from post where created_time <= '2024' and created_time >= '1999';
select * from post where created_time between '1999-01-01' and '2024-12-31';

-- date_format
select date_format(created_time, '%Y-%m') from post;
-- 실습 : post를 조회할 때 date_format 활용하여 2024년 데이터 조회
select * from post where date_format(created_time, '%Y') = '2024';
