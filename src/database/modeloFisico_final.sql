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
)AUTO_INCREMENT = 1000;

INSERT INTO usuario (nome, sobrenome, email, senha) values 
('Sid', 'Pimentinha', 'sid@gmail.com', 'JP2005ma');

-- Criaando a tabela endereco
CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    bairro VARCHAR(75) NOT NULL,
    logradouro VARCHAR(75) NOT NULL,
    complemento VARCHAR(75) NULL,
    cep CHAR(9) NOT NULL,
    fkUsuario INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

INSERT INTO endereco (nome, estado, cidade, bairro, logradouro, complemento, cep, fkUsuario)
VALUES 
('Casa das Flores', 'FH', 'Cidade Felicidade', 'Bairro Primavera', 'Rua das Flores', NULL, '12345-678', 1000),
('Residência Estrela', 'SE', 'Cidade Aurora', 'Bairro Luz Celestial', 'Avenida dos Sonhos', 'Bloco B, Apto 302', '98765-432', 1000);

select * from endereco;

-- Criando a tabela ambiente
CREATE TABLE ambiente (
    idAmbiente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    fkEndereco INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

INSERT INTO ambiente (nome, fkEndereco) values
('Cozinha das Flores', 1),
('Sala das Flores', 1),
('Quarto Patrick', 2);

select * from ambiente;

-- Criando a tabela obras
CREATE TABLE obras (
    idObras INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipoTinta VARCHAR(45) NOT NULL,
    descricao VARCHAR(150) NULL,
    fkAmbiente INT NOT NULL,
    FOREIGN KEY (fkAmbiente) REFERENCES ambiente(idAmbiente)
);

INSERT INTO obras (nome, tipoTinta, descricao, fkAmbiente) values
('Belissima', 'Oleo', 'Bonita demias', 1),
('Monalisa', 'Oleo', 'Bonita demias', 1),
('Monalisa', 'Oleo', 'Bonita demias', 3),
('Monalisa', 'Oleo', 'Bonita demias', 3),
('Monalisa', 'Oleo', 'Bonita demias', 3),
('Noite Estrelada', 'Acrilica', 'Ta noited demais', 2),
('O grito', 'Guache', 'Gritod emais', 2),
('Ecce Mocho', 'Oleo', 'Ta feio edmais', 1),
('Sapo Cururu', 'Guache', 'Vish amria', 1);

select * from obras
order by idObras;

-- Criando a tabela sensor
CREATE TABLE sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(45) NULL,
    fkObras INT NOT NULL,
    FOREIGN KEY (fkObras) REFERENCES obras(idObras)
);

INSERT INTO sensor (estado, fkObras) values 
('Ativo', 1),
('Ativo', 2),
('Ativo', 3),
('Ativo', 4),
('Ativo', 5),
('Ativo', 6),
('Ativo', 7),
('Ativo', 8),
('Ativo', 9);

select * from sensor;

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

INSERT INTO leituras (dht11_umidade, dht11_temperatura, ldr_lux, fkSensor)
VALUES 
(55.30, 21, 450.00, 1),
(55.30, 23.75, 450.00, 1),
(44, 20, 50, 2),
(44, 20, 50, 3),
(44, 20, 50, 4),
(44, 20, 50, 5),
(61.00, 21.85, 465.75, 6),
(56.80, 23.40, 455.60, 7),
(59.10, 22.50, 472.80, 8),
(57.50, 23.20, 460.00, 9);

select dht11_temperatura from leituras
order by 1 desc; 

	-- Criando view para aumentar a velocidade de resposta do endereço
	create view vw_select_enderecos as
	select 
    e.fkUsuario as idUsuario,
    e.idEndereco as id,
    e.nome,
    e.logradouro as rua,
    e.cep,
    count(distinct a.idAmbiente) as qtd_ambientes,
    count(o.idObras) as qtd_obras,
    max(case 
            when o.tipoTinta = 'Acrilica' then 
            case 
				when 
					(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) 
					or (l.dht11_umidade >= 40 and l.dht11_umidade <= 60) 
					or (l.ldr_lux <= 50) 
            then 0 else 1 end
            -- -----------------------------------------------------
		   when o.tipoTinta = 'Oleo' 
           then 
				case 
					when
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) 
						or (l.dht11_umidade >= 40 and l.dht11_umidade <= 45) 
						or (l.ldr_lux <= 200) 
			then 0 else 1 end
            -- -----------------------------------------------------
            else 
				case 
					when 
						(l.dht11_temperatura >= 19 and l.dht11_temperatura <= 21) 
						or (l.dht11_umidade >= 45 and l.dht11_umidade <= 55) 
						or (l.ldr_lux <= 50) 
            then 0 else 1 end
	end) as situacao
	from endereco as e
	join ambiente as a on 
	a.fkEndereco = e.idEndereco
	join obras as o 
	on o.fkAmbiente = a.idAmbiente
	join sensor as s 
	on s.fkObras = o.idObras
	join leituras as l 
	on l.fkSensor = s.idSensor 
	group by e.idEndereco, e.nome, e.logradouro, e.cep
	order by situacao desc;
    
	-- View 
    select id, nome, rua, cep, qtd_ambientes, qtd_obras, situacao 
    from vw_select_enderecos
    where idUsuario = 1000;
    
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Criando view para aumentar a velocidade de resposta do ambientes
    
	create view vw_select_ambiente as
	select e.fkUsuario as idUsuario,
    a.idAmbiente as id,
	a.nome,
	count(o.idObras) as qtd_obras,
	sum(case 
				when o.tipoTinta = 'Acrilica' then 
				case 
					when 
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) 
						or (l.dht11_umidade >= 40 and l.dht11_umidade <= 60) 
						or (l.ldr_lux <= 50) 
				then 0 else 1 end
				-- -----------------------------------------------------
			   when o.tipoTinta = 'Oleo' 
			   then 
					case 
						when
							(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) 
							or (l.dht11_umidade >= 40 and l.dht11_umidade <= 45) 
							or (l.ldr_lux <= 200) 
				then 0 else 1 end
				-- -----------------------------------------------------
				else 
					case 
						when 
							(l.dht11_temperatura >= 19 and l.dht11_temperatura <= 21) 
							or (l.dht11_umidade >= 45 and l.dht11_umidade <= 55) 
							or (l.ldr_lux <= 50) 
				then 0 else 1 end
		end) AS qtd_obras_perigo,
		max(case 
				when o.tipoTinta = 'Acrilica' then 
				case 
					when 
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) 
						or (l.dht11_umidade >= 40 and l.dht11_umidade <= 60) 
						or (l.ldr_lux <= 50) 
				then 0 else 1 end
				-- -----------------------------------------------------
			   when o.tipoTinta = 'Oleo' 
			   then 
					case 
						when
							(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) 
							or (l.dht11_umidade >= 40 and l.dht11_umidade <= 45) 
							or (l.ldr_lux <= 200) 
				then 0 else 1 end
				-- -----------------------------------------------------
				else 
					case 
						when 
							(l.dht11_temperatura >= 19 and l.dht11_temperatura <= 21) 
							or (l.dht11_umidade >= 45 and l.dht11_umidade <= 55) 
							or (l.ldr_lux <= 50) 
				then 0 else 1 end
		end) as situacao
	from obras as o
	join ambiente as a
	on a.idAmbiente = o.fkAmbiente
    join endereco as e
    on a.fkEndereco = e.idEndereco
	join sensor as s 
	on s.fkObras = o.idObras
	join leituras as l 
	on l.fkSensor = s.idSensor
	group by a.idAmbiente;
    
    -- View 
    select id, nome, qtd_obras, qtd_obras_perigo, situacao
    from vw_select_ambiente
    where idUsuario = 1000;
    





