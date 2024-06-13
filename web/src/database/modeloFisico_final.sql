-- DROP DATABasE IF EXISTS infinity_art;

CREATE DATABasE IF NOT EXISTS infinity_art;
USE infinity_art;

-- Criando a tabela usuario
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(90) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL
)AUTO_INCREMENT = 1000;

INSERT INTO usuario (nome, sobrenome, email, senha) values 
('Frizza', 'Sptech', 'frizza@gmail.com', 'JP2005ma'),

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

-- Criando a tabela ambiente
CREATE TABLE ambiente (
    idAmbiente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    fkEndereco INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

INSERT INTO ambiente (nome, fkEndereco) values
('Cozinha das Flores', 1),
('Sala das Flores', 1);

-- Criando a tabela obras
CREATE TABLE obras (
    idObras INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipoTinta VARCHAR(45) NOT NULL,
    fkAmbiente INT NOT NULL,
    FOREIGN KEY (fkAmbiente) REFERENCES ambiente(idAmbiente)
);

INSERT INTO obras (nome, tipoTinta, fkAmbiente) values
-- Frizza
('Belissima', 'Oleo', 'Bonita demias', 1),
('Belissima', 'Oleo', 'Bonita demias', 1);

-- Criando a tabela sensor
CREATE TABLE sensor (
    idSensor INT PRIMARY KEY,
    estado VARCHAR(45) NULL,
    FOREIGN KEY (idSensor) REFERENCES obras(idObras)
);

INSERT INTO sensor (estado, idSensor) values 
('Ativo', 1),
('Ativo', 2);

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

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Seleção dos Endereços de um determinado cliente
    
	create view vw_select_enderecos as
	select 
    e.fkUsuario as idUsuario,
    e.idEndereco as id,
    e.nome,
    e.logradouro as rua,
    e.cep,
    count(distinct a.idAmbiente) as qtd_ambientes,
    count(distinct o.idObras) as qtd_obras,
    max(case when o.tipoTinta = 'Acrilica' 
				then 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1 
							when
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 40 and l.dht11_umidade <= 60) or 
						(l.ldr_lux <= 50) 
							then 0 
							else 1 
							end
				-- -----------------------------------------------------
			when o.tipoTinta = 'Oleo' 
			   	then 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1
							when
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 40 and l.dht11_umidade <= 45) or 
						(l.ldr_lux <= 200) 
							then 0 
							else 1
							end
				-- -----------------------------------------------------
			else 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1 
							when
						(l.dht11_temperatura >= 19 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 45 and l.dht11_umidade <= 55) or 
						(l.ldr_lux <= 50) 
							then 0 
							else 1 
							end
		end) as situacao
	from endereco as e
	left join ambiente as a on a.fkEndereco = e.idEndereco
	left join obras as o on o.fkAmbiente = a.idAmbiente
	left join sensor as s on s.idSensor = o.idObras
	left join leituras as l on l.fkSensor = s.idSensor 
	group by e.idEndereco, e.nome, e.logradouro, e.cep
	order by situacao desc;
    
    select id, nome, rua, cep, qtd_ambientes, qtd_obras, situacao 
    from vw_select_enderecos
    where idUsuario = 1000;
    
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Seleção dos Ambientes de um determinado cliente
    
	create view vw_select_ambientes as
	select e.fkUsuario as idUsuario,
    e.idEndereco as endereco,
    a.idAmbiente as id,
	a.nome,
	count(distinct o.idObras) as qtd_obras,
		max(case when o.tipoTinta = 'Acrilica' 
				then 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1 
							when
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 40 and l.dht11_umidade <= 60) or 
						(l.ldr_lux <= 50) 
							then 0 
							else 1 
							end
				-- -----------------------------------------------------
			when o.tipoTinta = 'Oleo' 
			   	then 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1
							when
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 40 and l.dht11_umidade <= 45) or 
						(l.ldr_lux <= 200) 
							then 0 
							else 1
							end
				-- -----------------------------------------------------
			else 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1 
							when
						(l.dht11_temperatura >= 19 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 45 and l.dht11_umidade <= 55) or 
						(l.ldr_lux <= 50) 
							then 0 
							else 1 
							end
		end) as situacao 
	from ambiente as a
	left join obras as o on a.idAmbiente = o.fkAmbiente
    left join endereco as e on a.fkEndereco = e.idEndereco
	left join sensor as s on s.idSensor = o.idObras
	left join leituras as l on l.fkSensor = s.idSensor
	group by a.idAmbiente;
    
    select id, nome, qtd_obras, situacao
    from vw_select_ambientes
    where idUsuario = 1000 and endereco = 1;
    
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Seleção das Obras de um determinado cliente

create view vw_select_obras
as
select a.idAmbiente as id_ambiente,
o.idObras as id,
o.nome,
o.tipoTinta as tipo_tinta, 
		max(case when o.tipoTinta = 'Acrilica' 
				then 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1
							when
							(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) or 
							(l.dht11_umidade >= 40 and l.dht11_umidade <= 60) or 
							(l.ldr_lux <= 50) 
							then 0
							else 1 
							end
				-- -----------------------------------------------------
			when o.tipoTinta = 'Oleo' 
			   	then 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1
							when
						(l.dht11_temperatura >= 18 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 40 and l.dht11_umidade <= 45) or 
						(l.ldr_lux <= 200) 
							then 0
							else 1
							end
				-- -----------------------------------------------------
			else 
				case when l.dht11_temperatura is null or l.dht11_umidade is null or l.ldr_lux is null then -1
							when
						(l.dht11_temperatura >= 19 and l.dht11_temperatura <= 21) or 
						(l.dht11_umidade >= 45 and l.dht11_umidade <= 55) or 
						(l.ldr_lux <= 50) 
							then 0 
							else 1 
							end
		end) as situacao 
		from obras o
        left join ambiente as a on a.idAmbiente = o.fkAmbiente
		left join sensor as s on s.idSensor = o.idObras
		left join leituras as l on l.fkSensor = s.idSensor
		group by a.idAmbiente, o.idObras;

select id, nome, tipo_tinta, situacao 
from vw_select_obras 
where id_ambiente = 4
order by situacao desc;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Seleção da quantidade de obras e obras em perigo

select
count(distinct id) as kpi
from vw_select_obras 
where id_ambiente = 1

union all

select 
count(situacao) as kpi
from vw_select_obras 
where situacao = 1 and id_ambiente = 1;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DASHBOARD

-- Grafico DHT11

create view vw_grafico_dht as 
select l.dataLeitura as leitura,
l.fkSensor as id,
l.dht11_umidade as umid,
l.dht11_temperatura as temp
from leituras as l 
order by l.dataLeitura desc
limit 7;

select l.dataLeitura as leitura,
l.fkSensor as id,
l.dht11_umidade as umid,
l.dht11_temperatura as temp
from leituras as l 
order by l.dataLeitura desc
limit 7;

-- Grafico LDR

create view vw_grafico_ldr as 
select l.dataLeitura as leitura,
l.fkSensor as id,
l.ldr_lux as lux
from leituras as l 
order by l.dataLeitura desc
limit 7;

select l.dataLeitura as leitura,
l.fkSensor as id,
l.ldr_lux as lux
from leituras as l 
where l.fkSensor = 1
order by l.dataLeitura desc
limit 7;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- View para pegar os dados do Dia Atual

-- TEMPERATURA

create view vw_temp_dia_atual as
select 	o.tipoTinta as tipo_tinta,
		l.dataLeitura as dataL,
		o.idObras as id,
		sum(case when o.tipoTinta = 'Guache' 
			   then 
					case when l.dht11_temperatura < 19
						then 1 
						else 0 
						end
				-- -----------------------------------------------------
				else 
					case when l.dht11_temperatura < 18
						then 1 
						else 0 
						end
		end) as qtd_min_temp,
        sum(case when 
				l.dht11_temperatura > 21
			then 1 else 0 end) 
		as qtd_max_temp
        from leituras as l 
		join sensor as s on s.idSensor = l.fkSensor
		join obras as o on s.idSensor = o.idObras
        group by o.idObras, l.dataLeitura;

-- UMIDADE

create view vw_umid_dia_atual as
select 	o.tipoTinta as tipo_tinta,
		l.dataLeitura as dataL,
		o.idObras as id,
		sum(case when o.tipoTinta = 'Guache' 
			   	then 
					case when l.dht11_umidade < 45
						then 1 
						else 0
						end
				-- -----------------------------------------------------
				else 
					case when 
							l.dht11_umidade < 40
				then 1 else 0 end
		end) as qtd_min_umid,
        sum(case when o.tipoTinta = 'Acrilica' 
				then 
					case when l.dht11_umidade > 60
						then 1 
						else 0 
						end
				-- -----------------------------------------------------
			    when o.tipoTinta = 'Oleo' 
			   		then 
						case when l.dht11_umidade > 45
						then 1 
						else 0 
						end
				-- -----------------------------------------------------
				else 
						case when l.dht11_umidade > 55
						then 1 
						else 0 
						end
		end) as qtd_max_umid
        from leituras as l 
		join sensor as s on s.idSensor = l.fkSensor
		join obras as o on s.idSensor = o.idObras
		group by o.idObras, l.dataLeitura;
        
-- LUMINOSIDADE

create view vw_lux_dia_atual as
select 	o.tipoTinta as tipo_tinta,
		l.dataLeitura as dataL,
		o.idObras as id,
		0 as qtd_min_lux,
		sum(case when o.tipoTinta = 'Oleo' 
			   then 
					case when
							l.ldr_lux > 200
				then 1 else 0 end
				-- -----------------------------------------------------
				else 
					case when 
							l.ldr_lux > 50
				then 1 else 0 end
		end) as qtd_max_lux
        from leituras as l 
		join sensor as s on s.idSensor = l.fkSensor
		join obras as o on s.idSensor = o.idObras
        group by o.idObras, l.dataLeitura;
        
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Views para o calculo de Histórico Semanal

-- TEMPERATURA

create view vw_temp as
select 	l.fkSensor as id,
		weekday(dataLeitura) as dia_da_semana,
		sum(case when o.tipoTinta = 'Guache' 
			   then 
					case when l.dht11_temperatura < 19
						then 1 
						else 0 
						end
				-- -----------------------------------------------------
				else 
					case when l.dht11_temperatura < 18
						then 1 
						else 0 
						end
		end) as qtd_min_temp,
        sum(case when 
				l.dht11_temperatura > 21
			then 1 else 0 end) 
		as qtd_max_temp
        from leituras as l 
		join sensor as s on s.idSensor = l.fkSensor
		join obras as o on s.idSensor = o.idObras
        group by l.fkSensor, weekday(dataLeitura);

-- UMIDADE

create view vw_umid as
select 	l.fkSensor as id,	
		weekday(dataLeitura) as dia_da_semana,
		sum(case when o.tipoTinta = 'Guache' 
			   	then 
					case when l.dht11_umidade < 45
						then 1 
						else 0
						end
				-- -----------------------------------------------------
				else 
					case when 
							l.dht11_umidade < 40
				then 1 else 0 end
		end) as qtd_min_umid,
        sum(case when o.tipoTinta = 'Acrilica' 
				then 
					case when l.dht11_umidade > 60
						then 1 
						else 0 
						end
				-- -----------------------------------------------------
			    when o.tipoTinta = 'Oleo' 
			   		then 
						case when l.dht11_umidade > 45
						then 1 
						else 0 
						end
				-- -----------------------------------------------------
				else 
						case when l.dht11_umidade > 55
						then 1 
						else 0 
						end
		end) as qtd_max_umid
        from leituras as l 
		join sensor as s on s.idSensor = l.fkSensor
		join obras as o on s.idSensor = o.idObras
         group by l.fkSensor, weekday(dataLeitura);

-- LUMINOSIDADE

create view vw_lux as
select 	l.fkSensor as id,
		weekday(dataLeitura) as dia_da_semana,
		0 as qtd_min_lux,
		sum(case when o.tipoTinta = 'Oleo' 
			   then 
					case when
							l.ldr_lux > 200
				then 1 else 0 end
				-- -----------------------------------------------------
				else 
					case when 
							l.ldr_lux > 50
				then 1 else 0 end
		end) as qtd_max_lux
        from leituras as l 
		join sensor as s on s.idSensor = l.fkSensor
		join obras as o on s.idSensor = o.idObras
        group by l.fkSensor, weekday(dataLeitura);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT do histórico semanal usando as views

select 

    'Segunda-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 0 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 0 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 0 and id = 1) as limites_atingidos

union all

select 
    'Terça-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 1 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 1 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 1 and id = 1) as limites_atingidos

union all

select 
    'Quarta-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 2 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 2 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 2 and id = 1) as limites_atingidos

union all

select 
    'Quinta-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 3 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 3 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 3 and id = 1) as limites_atingidos

union all

select 
	
    'Sexta-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 4 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 4 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 4 and id = 1) as limites_atingidos

union all

select 
    'Sábado' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 5 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 5 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 5 and id = 1) as limites_atingidos

union all

select 
    'Domingo' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 6 and id = 1) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 6 and id = 1) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 6 and id = 1) as limites_atingidos;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Minimo e Maximo, utilizando a VIEW DO DIA ATUAL

select 
sum(qtd_min_lux) as minimo,
sum(qtd_max_lux) as maximo
from vw_lux_dia_atual
where id = 1 and date(dataL) = current_date()
union all
select 
sum(qtd_min_umid) as minimo,
sum(qtd_max_umid) as maximo
from vw_umid_dia_atual
where id = 1 and date(dataL) = current_date()
union all
select 
sum(qtd_min_temp) as minimo,
sum(qtd_max_temp) as maximo
from vw_temp_dia_atual
where id = 1 and date(dataL) = current_date();


-- KPIS DO DIA ATUAL

select sum(qtd_min_lux) + sum(qtd_max_lux) 
        as limite from vw_lux_dia_atual
        where id = 1 and date(dataL) = current_date()
    union all
        select sum(qtd_min_temp) + sum(qtd_max_temp) 
        as limite from vw_temp_dia_atual
        where id = 1 and date(dataL) = current_date()
    union all
        select sum(qtd_min_umid) + sum(qtd_max_umid) 
        as limite from vw_umid_dia_atual
        where id = 1 and date(dataL) = current_date();
        
        
