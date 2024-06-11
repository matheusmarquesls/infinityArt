create database infinityArt;
use infinityArt;

create table cliente (
idCliente int auto_increment,
nome varchar(45),
sobrenome varchar(45),
primary key (idCliente)
) auto_increment = 100;

create table usuario(
idCadastro int auto_increment,
fkCliente int,
email varchar(100),
senha varchar(20),
constraint fk_user_cliente foreign key (fkCliente) references cliente(idCliente),
primary key (idCadastro, fkCliente)
);

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

create table ambiente (
idAmbiente int auto_increment,
fkEndereco int,
nome varchar(45),
qtdObras int,
tipoObras varchar(45),
descricao varchar(150),
constraint fk_end_amb foreign key (fkEndereco) references endereco(idEndereco),
primary key (idAmbiente, fkEndereco)
) auto_increment = 1000;


create table sensor (
idSensor int auto_increment,
nome varchar(45),
tipo varchar(45),
dtInstalacao date,
fkAmbiente int,
constraint fk_sensor_amb foreign key (fkAmbiente) references ambiente(idAmbiente),
primary key (idSensor)
);

create table leitura_temp (
sequenciaLeitura int auto_increment,
fkSensor int,
dht11_temperatura decimal(10,2),
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_let foreign key (fkSensor) references sensor(idSensor),
primary key (sequenciaLeitura, fkSensor)
);

create table leitura_umi (
sequenciaLeitura int auto_increment,
fkSensor int,
dht11_umidade decimal(10,2),
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_let foreign key (fkSensor) references sensor(idSensor),
primary key (sequenciaLeitura, fkSensor)
);

create table leitura_lux (
sequenciaLeitura int auto_increment,
fkSensor int,
ldr_lux decimal(10,2),
dtLeitura datetime not null default current_timestamp,
constraint fk_sensor_let foreign key (fkSensor) references sensor(idSensor),
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
);

