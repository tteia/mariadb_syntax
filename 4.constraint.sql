-- not null 조건 추가
alter table 테이블명 modify  column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- author.id에 제약조건 추가 시 fk로 인해 문제가 발생한다면?
-- fk 먼저 제거 이후에 author.id에 제약조건 추가
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
alter table post drop foreign key post_author_fk;
-- 삭제된 제약 조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

-- uuid
alter table post add column user_id;

-- unique 제약 조건
alter table author modify column email varchar(255) uniquep;

-- on delete cascade 테스트 -> 부모 테이블의 id를 수정하면 수정이 안됨 ! 부모의 id가 수정되면 자식도 함께 변경되도록 해줌 : cascade;
-- delete : 삭제 가능 / update : 수정 가능
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;


-- 실습 delete => set null, update cascade;
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;