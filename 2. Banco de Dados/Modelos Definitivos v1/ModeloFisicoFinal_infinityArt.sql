create database if not exists infinityArt;
use infinityArt;

create table cliente (
idCliente int auto_increment,
nome varchar(45),
sobrenome varchar(45),
primary key (idCliente)
) auto_increment = 100;

insert into cliente values
(default, 'Denyel', 'Henry');

create table usuario(
idCadastro int auto_increment,
fkCliente int,
email varchar(100),
senha varchar(20),
constraint fk_user_cliente foreign key (fkCliente) references cliente(idCliente),
primary key (idCadastro, fkCliente)
);

insert into usuario values
(default, 100, 'denyel@gmail.com', '0900');

create table endereco (
idEndereco int auto_increment,
fkCliente int,
nome varchar(45),
estado char(2),
cidade varchar(45),
bairro varchar(45),
lougradouro varchar(45),
complemento varchar(45),
cep char(9),
constraint fk_end_cliente foreign key (fkCliente) references cliente(idCliente),
primary key (idEndereco, fkCliente)
);

insert into endereco values
(default, '100', 'Casa', 'RJ', 'XXX', 'XXX', 'XXX', 'XXX', '123456789');

create table ambiente (
idAmbiente int auto_increment,
fkEndereco int,
nome varchar(45),
qtdObras int,
descricao varchar(150),
constraint fk_end_amb foreign key (fkEndereco) references endereco(idEndereco),
primary key (idAmbiente, fkEndereco)
) auto_increment = 1000;

<<<<<<< HEAD:ModeloFisicoFinal_infinityArt.sql
insert into ambiente values 
(default, 1, 'Quarto', 34, 'Meu quarto');

=======
insert into ambiente values
(default, 1, 'Quarto', 34, 'Meu quarto');
>>>>>>> ae68464d27711b4e02a8a48211dea4d406244b51:ModeloFisico_Final.sql

create table sensor (
idSensor int auto_increment,
nome varchar(45),
tipo varchar(45),
dtInstalacao date,
fkAmbiente int,
constraint fk_sensor_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
primary key (idSensor)
);

<<<<<<< HEAD:ModeloFisicoFinal_infinityArt.sql
insert into sensor values 
(default, 'DHT11', 'Temperatura & Umidade', '2005-01-01', 1000), 
(default, 'LDR', 'Luminosidade', '2005-01-01', 1000); 

create table leitura_dht11 (
=======
insert into sensor values
(default, 'DHT11_U', 'Umidade', '2005-01-01', 1000),
(default, 'DHT11_T', 'Temp', '2005-01-01', 1000),
(default, 'LDR', 'Lux', '2005-01-01', 1000);

create table leitura_temp (
>>>>>>> ae68464d27711b4e02a8a48211dea4d406244b51:ModeloFisico_Final.sql
sequenciaLeitura int auto_increment,
fkSensor int,
dht11_umidade decimal(10,2),
dht11_temperatura decimal(10,2),
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_temp foreign key (fkSensor) references sensor(idSensor),
primary key (sequenciaLeitura, fkSensor)
);

create table leitura_ldr (
sequenciaLeitura int auto_increment,
fkSensor int,
ldr_lux decimal(10,2),
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_lux foreign key (fkSensor) references sensor(idSensor),
primary key (sequenciaLeitura, fkSensor)
);

create table acervo (
idAcervo int auto_increment,
nome varchar(45),
descricao varchar(200),
fkAmbiente int,
constraint fk_acervo_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
primary key (idAcervo)
) auto_increment = 10;

create table pintura (
idPintura int auto_increment,
nome varchar(45),
tipoTinta varchar(45),
descricao varchar(100),
fkAcervo int,
constraint fk_pint_acer foreign key (fkAcervo) references acervo(idAcervo),
primary key (idPintura)
)