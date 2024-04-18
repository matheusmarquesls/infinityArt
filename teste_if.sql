create database teste01;
use teste01;
create table teste(
id int primary key auto_increment,
dht11_umidade  int, 
dht11_temperatura  int, 
luminosidade int,
dtMedida datetime not null default current_timestamp
);

drop table teste;

select * from teste;