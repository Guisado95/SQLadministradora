// Script para o exercício administradora de condomínios.
  // INACABADO
  // necessário revisar chaves primárias e estrangeiras das tabelas unidade, aluguel, propriedade. Repensar o modelo e a forma de especificação, se será por CP serial ou CP composta... enfim

CREATE TABLE administradora (
	cnpj CHAR(14) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	cep CHAR(10) NOT NULL,
	bairro VARCHAR(20) NOT NULL,
	numero VARCHAR(5) NOT NULL,
	logradouro VARCHAR(100) NOT NULL
 ); 

 CREATE TABLE telefone_administradora (
	id SERIAL PRIMARY KEY,
	numero VARCHAR(20) NOT NULL,
	administradora_cnpj CHAR(14) REFERENCES administradora (cnpj) ON DELETE CASCADE	
 );

 CREATE TABLE condominio (
	codigo SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	administradora_cnpj CHAR(14) REFERENCES administradora (cnpj) ON DELETE CASCADE,
	cep CHAR(10) NOT NULL,
	bairro VARCHAR(20) NOT NULL,
	numero VARCHAR(5) NOT NULL,
	logradouro VARCHAR(100)
 );

 CREATE TABLE unidade (
	numero VARCHAR(5),
	bloco VARCHAR(2) NOT NULL,
	condominio_codigo INTEGER REFERENCES condominio (codigo) ON DELETE CASCADE,
  PRIMARY KEY (numero, condominio_codigo)
 );

 CREATE TABLE pessoa (
	cpf VARCHAR(14) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL
 );

 CREATE TABLE email_pessoa (
	codigo SERIAL PRIMARY KEY,
	email VARCHAR(50) NOT NULL,
	pessoa_cpf VARCHAR(14) REFERENCES pessoa (cpf) ON DELETE CASCADE
 );

 CREATE TABLE telefone_pessoa (
	codigo SERIAL PRIMARY KEY,
	numero VARCHAR(15) NOT NULL,
	pessoa_cpf VARCHAR(14) REFERENCES pessoa (cpf) ON DELETE CASCADE
 );

 CREATE TABLE aluguel (
	codigo SERIAL PRIMARY KEY,
	unidade_numero VARCHAR(5) REFERENCES unidade (numero) ON DELETE CASCADE,
	pessoa_cpf VARCHAR(14) REFERENCES pessoa (cpf) ON DELETE CASCADE,
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	CHECK (data_inicio < data_fim)
 );

 CREATE TABLE propriedade (
	codigo SERIAL PRIMARY KEY,
	unidade_numero VARCHAR(5) REFERENCES unidade (numero) ON DELETE CASCADE,
	pessoa_cpf VARCHAR(14) REFERENCES pessoa (cpf) ON DELETE CASCADE
 );

INSERT INTO administradora (cnpj, nome, email, cep, bairro, numero, logradouro) VALUES 
  ('44031555000176', 'Otero Imoveis', 'oteroimoveis@email.com', '97208-180', 'Parque Coelho', '140', 'Av. Rio Grande'),
  ('82944828000162', 'Porto Imoveis', 'portoimoveis@email.com', '99205-160', 'Centro', '980', 'Av Presidente Vargas');

SELECT * FROM administradora;

INSERT INTO telefone_administradora (numero, administradora_cnpj) VALUES 
  ('(51) 99999-9999', '44031555000176'),
  ('(11) 88888-8888', '82944828000162'),
  ('(25) 77777-7777', '82944828000162');

SELECT numero FROM telefone_administradora WHERE administradora_cnpj = '44031555000176';
SELECT numero FROM telefone_administradora WHERE administradora_cnpj = '82944828000162';

INSERT INTO condominio (nome, administradora_cnpj, cep, bairro, numero, logradouro) VALUES 
	('Anedota', '44031555000176', '11111-111', 'Vila Mimosa', '550', 'Rua Darcy Ribeiro'),
	('Vila Moura', '44031555000176', '22222-222', 'Navegantes', '878', 'Rua Beira-Mar'),
	('Marinheiros', '82944828000162', '33333-333', 'Marinheiros', '990', 'Rua Miraflores');

INSERT INTO unidade (numero, bloco, condominio_codigo) VALUES 
	('25', '2B', 1),
	('33', '3H', 1),
	('12', '1A', 2),
	('11', '1A', 2),
	('10', '1A', 2),
	('11', '2B', 3),
	('12', '2C', 3);









