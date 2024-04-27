-- Criando Database InfinityArt
create database infinityArt;

-- Usando InfinityArt
use infinityArt;


-- Criando tabela Cliente de acordo com o Modelo Lógico
create table Cliente(
idCliente int auto_increment,
nome varchar (45),
sobrenome varchar (45),
primary key (idCliente));

-- Criando tabela Cadastro de acordo com o Modelo Lógico
create table Cadastro(
idCadastro int auto_increment,
fkCliente int,
email varchar (90),
senha varchar (50),
primary key (idCadastro),
constraint fkCliente_cadastro foreign key (fkCliente) references Cliente (idCliente))
auto_increment = 1000;

-- Criando tabela Endereco de acordo com o Modelo Lógico
create table Endereco (
idEndereco int,
fkCliente int,
nome varchar (45),
estado char (2),
cidade varchar (45),
bairro varchar (45),
complemento varchar (45),
cep char (9),
primary key (idEndereco),
constraint fkCliente_endereco foreign key (fkCliente) references Cliente (idCliente))
auto_increment = 2000;

-- Criando tabela Ambiente de acordo com o Modelo Lógico
create table Ambiente (
idAmbiente int auto_increment,
fkEndereco int,
nome varchar (45),
qtdObras int,
tipoObras varchar (85),
descricao varchar (150),
primary key (idAmbiente),
constraint fkEndereco foreign key (fkEndereco) references Endereco (idEndereco))
auto_increment = 200;

-- Criando tabela Sensores de acordo com o Modelo Lógico
create table Sensores(
idSensores int auto_increment,
fkAmbiente int,
nome varchar (45),
tipo varchar (45),
dtInstalacao date,
primary key (idSensores),
constraint fkAmbiente_sensores foreign key (fkAmbiente) references Ambiente (idAmbiente))
auto_increment = 500;

/*Criando tabela leitura_sensores que receberá os dados captados pelos 
sensores instalados nos ambientes*/
create table leitura_sensores(
idLeitura_sensores int auto_increment,
fkSensor int,
dht11_temperatura decimal (10,2),
dht11_umidade decimal (10,2),
ldr_lux decimal (10,2),
dtLeitura datetime,
primary key (idLeitura_sensores),
constraint fkSensor foreign key (fkSensor) references Sensores (idSensores))
auto_increment = 10000;

-- Criando tabela Acervo de acordo com o Modelo Lógico
create table Acervo (
idAcervo int auto_increment,
fkAmbiente int,
nome varchar (45),
descricao varchar (200),
primary key (idAcervo),
constraint fkAmbiente_acervo foreign key (fkAmbiente) references Ambiente(idAmbiente))
auto_increment = 5000;

-- Criando tabela Pintura de acordo com o Modelo Lógico
create table Pintura (
idPintura int auto_increment,
fkAcervo int,
nome varchar (45),
tipoTinta varchar (45),
descricao varchar (100),
primary key (idPintura),
constraint fkAcervo foreign key (fkAcervo) references Acervo (idAcervo))
auto_increment = 8000;





















