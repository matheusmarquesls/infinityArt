create database infinityArt;
use infinityArt;

create table cliente (
idCliente int auto_increment,
nome varchar(45) not null,
sobrenome varchar(45) not null,
primary key (idCliente)
) auto_increment = 100;

insert into cliente values
(default, 'Claudio', 'Frizzarini');

create table usuario(
idCadastro int auto_increment,
fkCliente int,
email varchar(100) not null,
senha varchar(20) not null,
constraint fk_user_cliente foreign key (fkCliente) references cliente(idCliente),
primary key (idCadastro, fkCliente)
);

insert into usuario values
(default, 100, 'frizza@sptech.school', '1234');

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
(default, '100', 'Casa', 'RJ', 'XXX', 'XXX', 'XXX', 'XXX', '123456789'),
(default, '100', 'Galeria', 'SP', 'XXX', 'XXX', 'XXX', 'XXX', '987654321');

create table ambiente (
idAmbiente int auto_increment,
fkEndereco int,
nome varchar(45) not null,
qtdObras int,
tipoTinta varchar(45),
descricao varchar(150),
constraint fk_end_amb foreign key (fkEndereco) references endereco(idEndereco),
primary key (idAmbiente, fkEndereco)
) auto_increment = 1000;

insert into ambiente values
(default, 1, 'Sala', 12, 'Acrilíca, Guache', 'Sala de Jantar'),
(default, 2, 'Sessão 1', 34, 'Óleo', 'Exposição contemporânea');

create table sensor (
idSensor int auto_increment,
fkAmbiente int,
fkEndereco int,
nome varchar(45) not null,
tipo varchar(45) not null,
dtInstalacao date,
constraint fk_sensor_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
constraint fk_sensor_end foreign key (fkEndereco) references endereco(idEndereco),
primary key (idSensor, fkAmbiente, fkEndereco)
);

insert into sensor values

-- Sensores do endereco 1 ambiente 1

(1, 1000, 1, 'DHT11', 'Temperatura & Umidade', '2005-01-01'),
(2, 1000, 1, 'LDR', 'Luminosidade', '2005-01-01'),

-- Sensores do endereco 2 ambiente 1

(1, 1001, 2, 'DHT11', 'Temperatura & Umidade', '2005-01-01'),
(2, 1001, 2, 'LDR', 'Luminosidade', '2005-01-01');

create table leitura_dht11 (
fkSensor int,
fkAmbiente int,
fkEndereco int,
sequenciaLeitura int auto_increment,
dht11_umidade decimal(10,2) not null,
dht11_temperatura decimal(10,2) not null,
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_dht11 foreign key (fkSensor) references sensor(idSensor),
constraint fk_sensor_dht11_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
constraint fk_sensor_dht11_end foreign key (fkEndereco) references endereco(idEndereco),
primary key (sequenciaLeitura),
unique key (fkSensor, fkAmbiente, fkEndereco, sequenciaLeitura)
);

create table leitura_ldr (
fkSensor int,
fkAmbiente int,
fkEndereco int,
sequenciaLeitura int auto_increment,
ldr_lux decimal(10,2) not null,
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_ldr foreign key (fkSensor) references sensor(idSensor),
constraint fk_sensor_ldr_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
constraint fk_sensor_ldr_end foreign key (fkEndereco) references endereco(idEndereco),
primary key (sequenciaLeitura),
unique key (fkSensor, fkAmbiente, fkEndereco, sequenciaLeitura)
);