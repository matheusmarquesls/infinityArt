create database if not exists InfinityArt;
use InfinityArt;

create table cliente(
idCliente int primary key auto_increment,
nome varchar(45),
sobrenome varchar(45)
);

create table usuario(
idCadastro int primary key,
email varchar(90) not null,
senha varchar(50) not null,
fkCliente int,
constraint fk_cliente foreign key (fkCliente) references cliente(idCliente)
);

create table endereco(
idEndereco int primary key auto_increment,
email varchar(90) not null,
estado char(2),
cidade varchar(45),
bairro varchar(45),
logradouro varchar(45),
complemento varchar(45),
cep char(9),
fkCliente int,
constraint fk_EnderecoCliente foreign key (fkCliente) references cliente(idCliente)
);

create table ambiente(
idAmbiente int primary key auto_increment,
nome varchar(45),
qtdObras int,
descricao varchar(150),
fkEndereco int,
constraint fk_endereco foreign key (fkEndereco) references endereco(idEndereco)
);

create table sensores(
idSensores int primary key auto_increment,
nome varchar(45),
tipo varchar(45),
dtInstalacao date,
fkAmbiente int,
tipo varchar(45),
constraint chk_tipo_sensor check(tipo in('DHT11','LDR')),
constraint fk_ambiente foreign key (fkAmbiente) references ambiente(idAmbiente)
);

create table leitura_sensores(
sequencia_leitura int primary key auto_increment,
dht11_temperatura decimal(10,2),
dht11_umidade decimal(10,2),
ldr_lux decimal(10,2),
dt_leitura datetime not null,
fkSensor int,
constraint fk_sensor foreign key(fkSensor) references sensores(idSensores)
);

create table acervo(
idAcervo int primary key auto_increment,
nome varchar(45),
descricao varchar(200),
fkAmbiente int,
constraint fk_ambiente foreign key(fkAmbiente) references ambiente(idAmbiente)
);

create table pintura(
idPintura int primary key auto_increment,
nome varchar(45),
tipoTinta varchar(45),
descricao varchar(45),
constraint chk_tipo_tinta check(tipoTinta in('Guache','Acrílica','Óleo')),
fkAcervo int,
constraint fk_acervo foreign key (fkAcervo) references acervo(idAcervo)
);

