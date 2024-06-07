drop database if exists infinity_art;
CREATE DATABASE if not exists infinity_art;

use infinity_art;

-- Criando a tabela usuario
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(90) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    fkFuncionario INT null,
    FOREIGN KEY (fkFuncionario) REFERENCES usuario(id)
);

-- Criaando a tabela endereco
CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    complemento VARCHAR(45),
    cep CHAR(9) NOT NULL,
    fkUsuario INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(id)
);

-- Criando a tabela ambiente
CREATE TABLE ambiente (
    idAmbiente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    qtdObras INT NOT NULL,
    endereco INT NOT NULL,
    FOREIGN KEY (endereco) REFERENCES endereco(idEndereco)
);

-- Criando a tabela obras
CREATE TABLE obras (
    idObras INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    tipoTinta VARCHAR(45) NOT NULL,
    descricao VARCHAR(150),
    ambiente INT NOT NULL,
    FOREIGN KEY (ambiente) REFERENCES ambiente(idAmbiente)
);

-- Criando a tabela sensor
CREATE TABLE sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(45) NOT NULL,
    obras INT NOT NULL,
    FOREIGN KEY (obras) REFERENCES obras(idObras)
);

-- Criando a tabela leituras
CREATE TABLE leituras (
    sequenciaLeitura INT AUTO_INCREMENT PRIMARY KEY,
    dht11_umidade DECIMAL(10,2) NOT NULL,
    dht11_temperatura DECIMAL(10,2) NOT NULL,
    ldr_lux DECIMAL(10,2) NOT NULL,
    dataLeitura DATETIME NOT NULL,
    sensor INT NOT NULL,
    FOREIGN KEY (sensor) REFERENCES sensor(idSensor)
);

select * from usuario;