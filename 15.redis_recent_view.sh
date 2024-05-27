
while true; do
    # 사용자가 product를 입력할 때마다, 현재 시간을 score로 zadd 하겠다.
    echo "원하는 상품 입력 또는 나가기(exit)"
    read product # 사용자 입력 값을 product로 받겠다
    if [ "$product" == "exit" ]; then
        echo "나갑니다."
        break
    fi
    timestamp=$(date +%s) #현재시간 시분초를 초 단위로
    redis-cli zadd recent:products $timestamp $product
done
echo "사용자의 최근 본 상품 목록 5개 : "
redis-cli zrevrange recent:products 0 4




