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