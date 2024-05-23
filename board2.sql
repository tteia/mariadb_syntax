create table author(id int auto_increment, name varchar(255), email varchar(255) not null, 
password varchar(255), created_time datetime default current_timestamp, primary key(id), unique(email));


create table post(id int auto_increment, title varchar(255) not null,
contents varchar(255), primary key(id));

create table author_address(id int auto_increment, country varchar(255), city varchar(255),
street varchar(255), author_id int not null,
primary key(id), unique(author_id), foreign key(author_id) references author(id) on delete cascade);

create table author_post(id int auto_increment primary key, author_id int not null,
post_id int not null, foreign key(author_id) references author(id),
foreign key(post_id) references post(id));


-- 데이터 삽입 해보기