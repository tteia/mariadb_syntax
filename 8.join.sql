-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기.
select * from author inner join post on author.id = post.author_id;
select * from author a inner join post p on a.id = p.author_id;

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- 모든 글 목록을 출력하고, 만약 글쓴이가 있다면 이메일을 출력.
-- outer는 생략 가능 / 보통 쓰지 않는다! outher left join
select p.id, p.title, p.contents, a.email from post p left join author a on p.author_id = a.id;

-- join된 상황에서 where 조건 : on 뒤에 where 조건이 나옴.
-- 실습
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상만.
select p.title, a.email, a.age from post p inner join author a on p.author_id = a.id where a.age >= 25;

-- 2) 모든 글 목록 중 글의 title과 저자가 있다면 email을 출력, 2024년 5월 1일 이후 만들어진 글만 출력.
SELECT p.title, a.email FROM post p left join author a on a.ID = p.author_id where p.created_time >= '2024-05-01';
-- on > 어떤 기준으로 합칠거냐 / where > 해당되지 않는 건 거르겠다


-- union  : 중복을 제회한 두 테이블의 select 문을 결합. (join은 옆으로 붙인다면 union은 아래로 !)
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

-- author 테이블의 name, email / post 테이블의 title, contents 를 union
select name, email from author union select title, contents from post;


-- 서브 쿼리
-- select 절 안에 서브쿼리 : select 문 안에 또 다른 select 문.
-- author email과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) as count from author a;

-- from 절 안에 서브쿼리 : from 안에 또 다른 select 문
select a.name from (select * from author) as a;

-- where 절 안에 서브쿼리 : where 문 안에 또 다른 select 문
select a.* from author a inner join post p on a.id = p.author_id;
-- 위 쿼리를 where 절로 변환
select * from author where id in (select author_id from post);


-- 프로그래머스 "없어진 기록 찾기"
-- JOIN 이용
SELECT o.ANIMAL_ID, o.NAME FROM animal_outs o LEFT JOIN animal_ins i ON o.animal_id = i.animal_id
WHERE i.animal_id is null ORDER BY o.animal_id;
-- 서브쿼리 대표적 방법 이용
SELECT animal_id, name FROM animal_outs o WHERE animal_id NOT IN(SELECT ANIMAL_ID FROM animal_ins) ORDER BY ANIMAL_ID;


-- 집계 함수
SELECT COUNT (*) FROM author; -- (= SELECT COUNT(ID) FROM AUTHOR;) >> 행의 갯수를 세는 거라 ID 갯수와 동일함.
SELECT SUM(price) FROM post;
SELECT AVG(price) FROM post; -- 반올림하면 ROUND(AVG(PRICE), 소수점자리) >> SELECT ROUND(AVG(price),0) FROM post;

-- group by와 집계함수
SELECT author_id FROM post GROUP BY author_id; -- author_id 로 그룹화 했기 때문에 title을 조회할 수 없음!
SELECT author_id, COUNT(*), SUM(price), ROUND(AVG(price),0), MIN(price), MAX(price)
FROM post GROUP BY author_id;

-- 저자 email 출력, 해당 저자가 작성한 글 수 출력
SELECT a.id, IF(p.id is null, 0, count(*)) FROM author a LEFT JOIN post p ON a.id = p.author_id GROUP BY a.id;

-- where 와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외 > 제외되는 부분 where 로 제외
SELECT 연도, COUNT(*) FROM table WHERE GROUP BY 연도;
SELECT DATE_FORMAT(created_time, '%Y'), count(*) FROM post p WHERE p.created_time is not null GROUP BY DATE_FORMAT(created_time, '%Y');

-- alias 로 깔끔하게 정리
SELECT DATE_FORMAT(created_time, '%Y') as year, count(*) FROM post p WHERE p.created_time is not null GROUP BY year;

-- 프로그래머스 "입양 시각 구하기(1)"
SELECT DATE_FORMAT(datetime, '%H') as HOUR, COUNT(*) FROM animal_outs WHERE DATE_FORMAT(datetime, '%H:%i')
between '09:00' and '19:59' GROUP BY HOUR ORDER BY HOUR;
-- 시간을 한 자리 숫자로 (09 -> 9)
SELECT CAST(DATE_FORMAT(datetime, '%H') as unsigned) as HOUR, COUNT(*) FROM animal_outs WHERE DATE_FORMAT(datetime, '%H:%i')
between '09:00' and '19:59' GROUP BY HOUR ORDER BY HOUR;

-- HAVING : GROUP BY 를 통해 나온 통계에 대한 조건
SELECT author_id, COUNT(*) FROM post GROUP BY author_id;
-- 글을 2개 이상 쓴 사람에 대한 통계 정보
SELECT author_id, COUNT(*) AS count from post group by author_id HAVING count >= 2; --having은 group by된 결과에 대한 having !

-- 실습 : 포스팅 price 가 2,000원 이상인 글을 대상으로 작성자별로 몇 건인지와 평균 price를 구하되,
-- 평균 price 가 3,000원 이상인 데이터를 대상으로만 통계 출력
SELECT p.author_id, avg(price) as avg FROM post p WHERE price >= 2000 GROUP BY author_id HAVING avg >= 3000;

-- 실습 : 두 건 이상의 글을 쓴 사람의 id와 횟수 구하기.
-- 나이는 25세 이상인 사람만 통계에 사용, 가장 나이 많은 사람 한 명의 통계만 출력하시오.
SELECT a.id, COUNT(a.id) as count FROM post p INNER JOIN author a
ON a.id = p.author_id WHERE a.age >= 25 GROUP BY a.id HAVING count >=2 ORDER BY max(a.age) DESC LIMIT 1;
-- 한 그룹에는 다 같은 나이가 잡힐 거니까 max를 쓸 필요가 없다 >> a.age 를 DESC 로 정렬하면 당연히 max 가 최상단일테니까..


-- 다중열 group by
SELECT author_id, title, count(title) FROM post GROUP BY author_id, title;
-- author_id 로 묶었던 그룹을 title로 한 번 더 묶어줌 >> 앞에서 title도 뽑아내기 OK

-- 프로그래머스 "재구매가 일어난 상품과 회원 리스트 구하기"
SELECT USER_ID, PRODUCT_ID FROM ONLINE_SALE GROUP BY USER_ID
HAVING COUNT(*) >= 2
-- 위 코드는 2번 이상 구매한 id 는 알 수 있지만, 같은 상품을 구매한 건지는 알 수 없다!
-- 최종 코드
SELECT USER_ID, PRODUCT_ID FROM ONLINE_SALE GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(*) >= 2 ORDER BY USER_ID, product_id DESC;