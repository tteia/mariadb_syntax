-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 스키마(database) 생성
-- 명령어는 대소문자 상관없으나, 이름은 소문자로 만드는 것이 정석! 명령어는 대문자가 정석!
create DATABASE board;

-- database 선택
USE board -- 위에서 board로 생성했으니 board로 선택.

-- 테이블 조회
show tables;

-- author 테이블 생성
create table author(id, name, email, password);
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼 조회
describe author;

-- column 상세 조회
show full colums from author;

-- 테이블 생성문 조회
show create table author;

-- posts table 신규 생성
-- author_id 가 위 author 테이블을 참조하고 있다는 것을 함께 작성
-- 테이블 전체에 대한 제약 조건(foreign key)이나 PK는 맨 마지막에 INT PRIMARY KEY(ID) 이런 식으로도 작성 가능
create table posts(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, FOREIGN KEY (author_id) references author (id));

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER문 : 테이블의 구조를 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
-- 수정은 add 대신 modify
alter table author add column test1 VARCHAR(50);
-- 테이블 컬럼 삭제
alter table author drop column test1;
-- 테이블 컬럼명 변경
alter table post change column content contents VARCHAR(255);
-- 테이블 컬럼 타입과 제약 조건 변경
-- 덮어쓰기와 같은 개념이기 때문에 기존에 있던 값도 빼먹지 말고 적어주기!
alter table author modify column email VARCHAR(255) not null;


--실습 : author 테이블에 address 컬럼 추가. 
alter table author add column address VARCHAR(255);

--실습 : post 테이블에 title은 not null 제약 조건 추가, contents는 3000자로 변경.
--,를 통해 한 줄로 작성할 수 있다!
alter table post modify column title VARCHAR(255) not null, modify column contents VARCHAR(3000);

-- 테이블 삭제
-- 복구 => show create  table post; 로 조회 후 복사, 그대로 붙여넣기 하면 복구 완료!
--  CREATE TABLE `post` ( `id` int(11) NOT NULL, `title` varchar(255) NOT NULL, `contents` varchar(3000) DEFAULT NULL, `author_id` int(11) DEFAULT NULL, PRIMARY KEY (`id`), KEY `author_id` (`author_id`), CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`));
drop 테이블명;