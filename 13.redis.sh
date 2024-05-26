brew services start redis


# 레디스 접속
# cli : commandline interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택
select 번호 # default = 0

# 데이터 베이스 내 모든 키 조회
keys *
# 데이터 베이스 내 모든 value 조회
get value
# get을 통해 value 값 얻기
get test_key1

# 일반 string 자료구조
# key:value 값 세팅
# key값은 중복되면 안된다! > 중복되면 덮어쓰여지는 것이 기본. : 맵 저장소에서 key 값은 유일하게 관리가 되므로.
SET key(키) value(값) # key와 value에 각각 값을 넣는 것!
set test_key1 test_value1
set user:email:1 hong@test.com # 'user:email:1' 이 문자열! user_email_1로 써도 동일하다.
# > set user:email:1 로 조회
# nx : not exist
set user:email:2 hong1@test.com nx # user:email:1 에 값이 nx 할 때만 value를 넣겠다!
# ex : 만료시간 - 초 단위 > ttl(time to live) 
set user:email:2 hong2@test.com ex 20

# 특정 key 삭제
del user:email:1
# 현재 데이터베이스의 모든 key 값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0 # posting 게시글 1번의 좋아요가 0
incr likes:posting:1 # 특정 key 값의 value를 1만큼 증가시키겠다. # 0 자체는 문자열!
decr likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# bash쉘을 활용하여 재고 감소 프로그램 작성