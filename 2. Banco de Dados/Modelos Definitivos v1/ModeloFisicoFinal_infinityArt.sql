create database infinityArt;
use infinityArt;

drop database infinityArt;

create table cliente (
idCliente int auto_increment,
nome varchar(45) not null,
sobrenome varchar(45) not null,
primary key (idCliente)
) auto_increment = 100;

insert into cliente values
(default, 'Denyel', 'Henry');

create table usuario(
idCadastro int auto_increment,
fkCliente int,
email varchar(100) not null,
senha varchar(20) not null,
constraint fk_user_cliente foreign key (fkCliente) references cliente(idCliente),
primary key (idCadastro, fkCliente)
);

insert into usuario values
(default, 100, 'denyel@gmail.com', '0900');

create table endereco (
idEndereco int auto_increment,
fkCliente int,
nome varchar(45) not null,
estado char(2) not null,
cidade varchar(45) not null,
bairro varchar(45) not null,
lougradouro varchar(45) not null,
complemento varchar(45),
cep char(9) not null,
constraint fk_end_cliente foreign key (fkCliente) references cliente(idCliente),
primary key (idEndereco, fkCliente)
);

insert into endereco values
(default, '100', 'Casa', 'RJ', 'XXX', 'XXX', 'XXX', 'XXX', '123456789');

create table ambiente (
idAmbiente int auto_increment,
fkEndereco int,
nome varchar(45) not null,
qtdObras int,
descricao varchar(150),
constraint fk_end_amb foreign key (fkEndereco) references endereco(idEndereco),
primary key (idAmbiente, fkEndereco)
) auto_increment = 1000;

insert into ambiente values
(default, 1, 'Quarto', 34, 'Meu quarto');

create table sensor (
idSensor int auto_increment,
nome varchar(45) not null,
tipo varchar(45) not null,
dtInstalacao date,
fkAmbiente int,
constraint fk_sensor_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
primary key (idSensor)
);

insert into sensor values
(default, 'DHT11', 'Temperatura & Umidade', '2005-01-01', 1000),
(default, 'LDR', 'Luminosidade', '2005-01-01', 1000);

create table leitura_dht11 (
sequenciaLeitura int auto_increment,
fkSensor int,
dht11_umidade decimal(10,2) not null,
dht11_temperatura decimal(10,2) not null,
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_temp foreign key (fkSensor) references sensor(idSensor),
primary key (sequenciaLeitura, fkSensor)
);

create table leitura_ldr (
sequenciaLeitura int auto_increment,
fkSensor int,
ldr_lux decimal(10,2) not null,
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_lux foreign key (fkSensor) references sensor(idSensor),
primary key (sequenciaLeitura, fkSensor)
);

create table acervo (
idAcervo int auto_increment,
nome varchar(45) not null,
descricao varchar(200),
fkAmbiente int,
constraint fk_acervo_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
primary key (idAcervo)
) auto_increment = 10;

create table pintura (
idPintura int auto_increment,
nome varchar(45) not null,
tipoTinta varchar(45) not null,
descricao varchar(100),
fkAcervo int,
constraint fk_pint_acer foreign key (fkAcervo) references acervo(idAcervo),
primary key (idPintura)
);