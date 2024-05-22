create table author(id int auto_increment, name varchar(255), email varchar(255) not null, 
password varchar(255), created_time datetime default current_timestamp, primary key(id), unique(email));


create table post(id int auto_increment, title varchar(255) not null,
)