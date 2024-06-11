CREATE DATABASE InfinityART;
USE InfinityART;


CREATE TABLE cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  sobrenome VARCHAR(45) NULL,
  PRIMARY KEY (idCliente));


CREATE TABLE endereco (
  idEndereco INT NOT NULL AUTO_INCREMENT,
  fkCliente INT NOT NULL,
  nome VARCHAR(45) NULL,
  estado CHAR(2) NULL,
  cidade VARCHAR(45) NULL,
  bairro VARCHAR(45) NULL,
  lougrado VARCHAR(45) NULL,
  complemento VARCHAR(45) NULL,
  cep CHAR(9) NULL,
  PRIMARY KEY (idEndereco, fkCliente),
  CONSTRAINT fk_Endereco_Cliente
    FOREIGN KEY (fkCliente)
    REFERENCES cliente (idCliente));

CREATE TABLE ambiente (
  idAmbiente INT NOT NULL AUTO_INCREMENT,
  fkEndereco INT NOT NULL,
  nome VARCHAR(45) NULL,
  qtdObras INT NULL,
  tipoObras VARCHAR(85) NULL,
  descricao VARCHAR(150) NULL,
  PRIMARY KEY (idAmbiente, fkEndereco),
    FOREIGN KEY (fkEndereco)
    REFERENCES endereco (fkCliente));

CREATE TABLE sensores (
  idSensores INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  tipo VARCHAR(45) NULL,
  dtInstalacao DATE NULL,
  fkAmbiente INT NOT NULL,
    FOREIGN KEY (fkAmbiente)
    REFERENCES mydb.ambiente (idAmbiente));

CREATE TABLE leitura_sensores (
  sequenciaLeitura INT NOT NULL AUTO_INCREMENT,
  fkSensor INT NOT NULL,
  dth11_temperatura DECIMAL(10,2) NULL,
  dht11_umidade DECIMAL(10,2) NULL,
  ldr_lux DECIMAL(10,2) NULL,
  dtLeitura DATETIME NOT NULL,
  PRIMARY KEY (Sequencia_Leitura, fkSensor),
    FOREIGN KEY (fkSensor)
    REFERENCES sensores (idSensores));


CREATE TABLE acervo (
  idAcervo INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  descricao VARCHAR(200) NULL,
  fkAmbiente INT NOT NULL,
    FOREIGN KEY (fkAmbiente)
    REFERENCES ambiente (idAmbiente));


CREATE TABLE pintura (
  idPintura INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  tipoTinta VARCHAR(45) NULL,
  descricao VARCHAR(45) NULL,
  fkAcervo INT NOT NULL,
    FOREIGN KEY (fkAcervo)
    REFERENCES acervo (idAcervo));

CREATE TABLE usuario (
  idCadastro INT NOT NULL,
  fkCliente INT NOT NULL,
  email VARCHAR(90) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  PRIMARY KEY (idCadastro, fkCliente),
    FOREIGN KEY (fkCliente)
    REFERENCES cliente (idCliente));

