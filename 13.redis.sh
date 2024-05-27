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

# bash쉘을 활용하여 재고 감소 프로그램 작성 - 14번 파일

# 캐싱 기능 구현
# 1번 author 회원 정보 조회;
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장 => {key:value, key:value...}
# \ 달아주는 것을 escape문이라고 한다 !

# 왜 select 문을 안 쓰고 아래처럼 작성했을까..? -> 속도. 빈번하게 발생하는 경우에 O
# 캐싱(저장) 해놓은 redis 에서 조회하는게 훨씬 빠르다.
set user:1:detail "{\"name\":\"hong\", \"email\":\"test@test.com\", \"age\":30}" ex 10

# list
# redis 의 list는 java의 deque와 같은 구조. 즉, double-ended queue 구조.
# java에서 list -> RPUSH, LPOP !

# 데이터 왼쪽 삽입
LPUSH [key value] # ex) LPUSH fruit apple
# 데이터 오른쪽 삽입
RPUSH [key value]
# 데이터 왼쪽부터 / 오른쪽부터 꺼내기
LPOP key
RPOP key

lpush fruits apple
lpush fruits banana
lpush fruits kiwi

lpop fruits
# lpop > kiwi 가 나옴! lpush 했으니까 {kiwi, banana, apple}

# 꺼내서 없애는게 아니라 꺼내서 보기만! (pop은 없어짐)
lrange fruits -1 -1
lrange fruits 0 0

# 데이터 개수 조회
llen key # llen fruits
# list 요소 조회시에는 범위 지정
lrange key 0 -1 # 처음부터 끝까지 lrange fruits 0 -1 # -1이 맨 뒤
lrange fruits start end # start부터 end 까지 ! lrange fruits 1 2 > banana, apple
# ttl 적용
expire fruits 30
# ttl 조회
ttl fruits
# pop과 push를 동시에 실행하는 명령어
RPOPLPUSH A리스트 B리스트 # A 에서 RPOP 한 걸 B 에 넣겠다.

# 어떤 목적으로 사용하나요? -> 최근 본 상품 목록, 최근 방문한 페이지
# java set > 중복 제거됨 . 최근 본 상품을 redis list로 만들면 ? 본 걸 또 보는 게 문제 . .
# => 그럼 또 보고 또 보고 또 보면 한 상품으로 리스트가 가득차게 됨 !
# => sorted set (zset) 을 활용하는 것이 적절.

# 최근 방문한 페이지
# 데이터 10개 정도 push
# 최근 방문한 페이지 3개 정도만 보여주는 명령어
rpush pages kiwi1.com
rpush pages kiwi2.com ...
# 이러면 10번이 제일 최근. 방문할 때마다 추가된 게 rpush pages.
# 여기서 최근 방문한 페이지 메뉴를 눌렀을 때 보이게 하려면?
lrange pages 2 -1 # 범위를 알고 있다는 가정 하에.



# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 앞으로 가기 누르면 앞으로 간 페이지가 뭔지 출력
# 지금 kiwi5.com 가 가장 최근에 방문한 페이지. 뒤로 가면? kiwi4가 나와야 됨.
rpoplpush pages recent
# 이러면..? 가장 최근에 방문한 게 recent 로 들어가게 됨
# 다시 앞으로 가려면? recent에 있는 걸 pages에 다시 넣어줘
rpoplpush recent pages

#recent 가 없어서 안 들어감..ㅠㅠ

rpush pages kiwi1.com
rpush pages kiwi2.com
rpush pages kiwi3.com
rpush pages kiwi4.com
rpush pages kiwi5.com

lrange pages -1 -1
# 5에서 뒤로가기 하면 4 3 2 1
# 5를 backwards 에 저장해놨다가 다시 불러오면? 그게 앞으로가기
lpoprpush pages backwards # 왜지???????????????? rpop 해야 뒤로가기 아니야?




# set 자료구조
# set 자료구조에 멤버 추가
sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers members
# member1 이 중복 => 제거되어있음! set 자료구조는 중복이 제거된다.
# set 값 개수 조회
scard members
# 특정 멤버가 set 안에 있는지 존재 여부 확인
sismember members member3

#set에서 멤버 삭제
srem members member2

# 매일 방문자 수 계산
# 같은 사람이 여러번 반복해도 오르지 않도록.
# 금일 날짜를 key 값으로 방문자 수를 계산.
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-27 hong2@naver.com ...
sacrd visit:2024-05-27


# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score기준 오름차순 정렬 / 내림차순 정렬
zrange zmembers 0 -1
zrevrange zmembers 0 -1

# zset 삭제
# zset 기존 값에 덮어씌우기 가능
zrem zmembers member2
# zset 의 값이 몇번째에 존재하고 있는지 (오름차순 기준) index 몇번째인지 출력.
zrank zmembers member2

# 최근 본 상품 목록
zadd recent:products 192402 melon
zadd recent:products 192411 appple
zadd recent:products 192413 appple
zadd recent:products 192415 banana
zadd recent:products 192420 kiwi
zadd recent:products 192422 appple
zadd recent:products 192431 appple

zrevrange recent:products 0 2 # apple은 덮어씌워지기 때문에 조회시 마지막 apple, banana, kiwi 조회됨.


# hashes
# 해당 자료구조에서는 문자와 숫자가 구분됨. apple > ""로 문자 구분지어줌.
hset product:1 name "apple" price 1000 stock 50
hget product:1 price # price 를 name, stock 등으로 교체 > 해당 값 조회
# 모든 객체 값 get
hgetall product:1
# 특정 요소 값 수정
hset product:1 stock 40

# 특정 요소 값 증가 / 감소
hincrby product:1 stock 5 # -5 하면 감소
hget product:1 stock