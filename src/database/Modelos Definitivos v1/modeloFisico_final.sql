DROP DATABASE IF EXISTS infinity_art;

CREATE DATABASE IF NOT EXISTS infinity_art;
USE infinity_art;

-- Criando a tabela usuario
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(90) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    fkFuncionario INT NULL,
    FOREIGN KEY (fkFuncionario) REFERENCES usuario(idUsuario)
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
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- Criando a tabela ambiente
CREATE TABLE ambiente (
    idAmbiente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    fkEndereco INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

-- Criando a tabela obras
CREATE TABLE obras (
    idObras INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    tipoTinta VARCHAR(45) NOT NULL,
    descricao VARCHAR(150) NULL,
    fkAmbiente INT NOT NULL,
    FOREIGN KEY (fkAmbiente) REFERENCES ambiente(idAmbiente)
);

-- Criando a tabela sensor
CREATE TABLE sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(45) NULL,
    fkObras INT NOT NULL,
    FOREIGN KEY (fkObras) REFERENCES obras(idObras)
);

-- Criando a tabela leituras
CREATE TABLE leituras (
    sequenciaLeitura INT AUTO_INCREMENT,
    dht11_umidade DECIMAL(10,2) NOT NULL,
    dht11_temperatura DECIMAL(10,2) NOT NULL,
    ldr_lux DECIMAL(10,2) NOT NULL,
    dataLeitura DATETIME DEFAULT NOW() NOT NULL,
    fkSensor INT NOT NULL,
    PRIMARY KEY (sequenciaLeitura, fkSensor),
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);