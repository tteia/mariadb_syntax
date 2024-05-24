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

-- 프로시저 삭제
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN 
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

-- 게시글 단건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in postID int)
BEGIN 
    select * from post where id = postID;
END
// DELIMITER ;

call 게시글단건조회();

-- 저자id로 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255))
BEGIN 
    select * from post where author_id = 저자id and title = 제목;
END
// DELIMITER ;

call 게시글단건조회(4, 'hello');

-- 글쓰기
DELIMITER //
CREATE PROCEDURE 글쓰기(in 제목 varchar(255), in 내용 varchar(3000), in 저자id int)
BEGIN 
    insert into post(title, contents, author_id) values(title = 제목, contents = 내용, author_id = 저자id);
END
// DELIMITER ;

call 글쓰기('hi', 'hello', 1);
-- 왜 안될까..?
insert into post(title, contents, author_id) values(제목, 내용, 저자id);
-- 위 코드로 작성해야하는데 잘못 지정했다 ^^;;
DELIMITER //
CREATE PROCEDURE 글쓰기(in 제목 varchar(255), in 내용 varchar(3000), in 저자id int)
BEGIN 
    insert into post(title, contents, author_id) values(제목, 내용, 저자id);
END
// DELIMITER ;

-- 글쓰기 : title, contents, email
DELIMITER //
CREATE PROCEDURE 게시글생성2(in 이메일 varchar(255), in 제목 varchar(255), in 내용 varchar(3000))
BEGIN
	declare authorId int;     
	select id into authorId from author where email = 이메일;     
	insert into post(title, contents, author_id) values(제목, 내용, authorId); 
END 
// DELIMITER ;  
	
call 게시글생성2('hong1@naver.com','hello', 'world');

-- sql에서 문자열 합치는 concat('hello', 'world');
-- 글 상세조회 : input 값이 postId
-- title, contents, '홍길동' + '님'

DELIMITER //
CREATE PROCEDURE 상세조회(in postId int)
BEGIN
    declare authorName varchar(255);
    SELECT name into authorName from author where id = (select author_id from post where id = postId);
    set authorName = concat(authorName, '님');
    SELECT title, contents, authorName from post where id = postId;
END
// DELIMITER ;

-- join 활용해보기



-- 등급 조회 >> IF문 활용
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 글을 10개 이상, 100개 미만 중수입니다.
-- 그 외 초보입니다.
DELIMITER //
CREATE PROCEDURE 등급조회(in emailInput varchar(255))
BEGIN
    declare authorID int;
    declare count int;
    select id into authorId from author where email = emailInput;
    select count(*) into count from post where author_id = authorId;
    IF count >= 100 then
        select '고수입니다.';
    ELSEIF count >= 10 and count < 100 then
        select '중수입니다.';
    ELSE
        select '초보입니다.';
    END IF;
END
// DELIMITER ;

-- 반복을 통해 post 대량 생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요'
DELIMITER //
CREATE PROCEDURE 글도배(in ab int)
BEGIN
    declare count int default 0;
    WHILE count < ab DO
        INSERT INTO post(title) values('안녕하세요');
        SET count = count + 1;
    END WHILE;
END
// DELIMITER ;

describe post;
-- NULL > YES : 비어있어도 됨
-- NULL > NO : 비어있으면 안됨!

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';