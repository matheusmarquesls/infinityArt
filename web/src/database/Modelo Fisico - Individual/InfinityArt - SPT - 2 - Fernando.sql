create schema if not exists InfinityArt_DB;
use InfinityArt_DB;

create table cliente(
idCliente int auto_increment,
nome varchar(45) not null,
sobrenome varchar(45) not null,

constraint PK_Cliente primary key (idCliente)
);

create table usuario(
idUsuario int auto_increment,
fkCliente int,
email varchar(100) not null,
senha varchar(45) not null, 

constraint FK_Cliente_Usuario foreign key (fkCliente) references cliente(idCliente),
constraint PK_Usuario primary key (idUsuario, fkCliente),
constraint UK_Email_Senha unique (email, senha)
);

create table endereco(
idEndereco int auto_increment,
fkCliente int,
nome varchar(45),
estado char(2),
cidade varchar(45),
bairro varchar(45),
logradouro varchar(45),
complemento varchar(75),
cep char(9),

constraint FK_Cliente_Endereco foreign key (fkCliente) references cliente(idCliente),
constraint PK_Endereco primary key (idEndereco, fkCliente)
);

create table ambiente(
idAmbiente int auto_increment,
fkEndereco int,
nome varchar(45),
descricao varchar(200),
qntdObras int,

constraint FK_Endereco_Ambiente foreign key (fkEndereco) references endereco(idEndereco),
constraint PK_Ambiente primary key (idAmbiente, fkEndereco)
);

create table acervo(
idAcervo int auto_increment,
nome varchar(45),
descricao varchar(200),
fkAmbiente int,

constraint PK_Acervo primary key (idAcervo),
constraint FK_Ambiente_Acervo foreign key (fkAmbiente) references ambiente(idAmbiente)
);

create table pintura (
idPintura int auto_increment,
nome varchar(45),
tipoTinta varchar(20),
descricao varchar(200),
fkAcervo int,

constraint PK_Pintura primary key (idPintura),
constraint FK_Acervo_Pintura foreign key (fkAcervo) references acervo(idAcervo),
constraint CK_tipoTinta_Pintura check (tipoTinta = "oleo" or "guache" or "acrilica")
);

create table sensores(
idSensores int auto_increment,
tipo varchar(7),
dtInstalacao date,
fkAmbiente int,

constraint PK_Sensores primary key (idSensores),
constraint FK_Ambiente_Sensores foreign key (fkAmbiente) references ambiente(idAmbiente),
constraint CK_Tipo_Sensores check (tipo = "DHT11-U" or "DHT11-T" or "LDR")
);

create table leitura_sensores(
sequenciaLeitura int auto_increment,
fkSensores int,
dht11_Temperatura decimal(10,2),
dht11_Umidade decimal(10,2),
ldr_Lux decimal(10,2),
dtLeitura datetime,

constraint FK_Sensores_LeituraSensores foreign key (fkSensores) references sensores(idSensores),
constraint PK_LeituraSensores primary key (sequenciaLeitura, fkSensores)
);

show full tables;
drop database InfinityArt_DB;





