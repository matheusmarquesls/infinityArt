create database infinityartDefinitivo;
use infinityartDefinitivo;

create table cliente( 
idCliente int primary key auto_increment,
nome varchar (45),
sobrenome varchar (45)

);

create table usuario(
idCadastro int primary key auto_increment,
email varchar(45),
senha varchar (45),
fkcliente int,
constraint fkcliente foreign key (fkcliente) references cliente(idCliente)
);

create table endereco(
idEndereco int primary key auto_increment,
nome varchar(45),
estado char (2),
cidade varchar (45),
bairro varchar (45),
lougrado varchar (45),
complemento varchar (45),
cep char(9),
fkcliente int,
constraint fkcliente foreign key (fkcliente) references cliente(idCliente)
);
create table ambiente(
idAmbiente int primary key auto_increment,
nome varchar (45),
qtdObras int,
tipoObras varchar (85),
descricao varchar(150),
fkendereco int,
constraint fkendereco foreign key (fkendereco) references endereco(idEndereco)
);
create table sensores (
idSensores int primary key auto_increment,
nome varchar (45),
tipo varchar (45),
dtInstalacao date,
fkAmbiente int,
constraint fkAmbiente foreign key (fkAmbiente) references ambiente(idAmbiente)
);

create table leitura_sensores(
sequencia_leitura int primary key auto_increment,
dht11_temperatura decimal (10,2),
dht11_umidade decimal (10,2),
ldr_lux decimal (10,2),
dtLeitura datetime,
fkSensor int,
constraint fksensor foreign key (fkSensor) references sensores (idSensores)
);

create table acervo (
idAcervo int primary key auto_increment,
nome varchar (45),
descricao varchar(200),
fkAmbiente int,
constraint fkAmbiente foreign key (fkAmbiente) references ambiente (idAmbiente)
);

create table pintura (
idPintura int primary key auto_increment,
nome varchar (45),
tipoTinta varchar(45),
descricao varchar (45),
fkAcervo int,
constraint fkAcervo foreign key (fkAcervo) references Acervo (idAcervo)
);