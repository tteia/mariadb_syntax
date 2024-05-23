# local 에서 sql 덤프 파일 생성
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql

# dump 파일을 github에 업로드.
# 우분투에서 mariadb 설치
sudo apt-get install mariadb-server
# mariadb 서버 시작
sudo systemctl start mariadb
# mariadb 접속
sudo mariadb -u root -p

