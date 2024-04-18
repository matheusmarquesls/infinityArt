create database infinityArt;
use infinityArt;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema infinityart
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Sobrenome` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `idEndereco_Cliente` INT NOT NULL AUTO_INCREMENT,
  `fkCliente` INT NOT NULL,
  `Estado` VARCHAR(45) NULL,
  `Cidade` VARCHAR(45) NULL,
  `Bairro` VARCHAR(45) NULL,
  `Logradouro` VARCHAR(45) NULL,
  `Complemento` VARCHAR(45) NULL,
  `CEP` INT NULL,
  PRIMARY KEY (`idEndereco_Cliente`, `fkCliente`),
  INDEX `fk_Endereco_Cliente_idx` (`fkCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Cliente`
    FOREIGN KEY (`fkCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ambiente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ambiente` (
  `idAmbiente` INT NOT NULL AUTO_INCREMENT,
  `fkCliente` INT NOT NULL,
  `fkEndereco` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `qntdObras` INT NULL,
  `Descricao` VARCHAR(200) NULL,
  PRIMARY KEY (`idAmbiente`, `fkCliente`, `fkEndereco`),
  INDEX `fk_Ambiente_Endereco1_idx` (`fkEndereco` ASC) VISIBLE,
  INDEX `fk_Ambiente_Cliente1_idx` (`fkCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Ambiente_Endereco1`
    FOREIGN KEY (`fkEndereco`)
    REFERENCES `mydb`.`Endereco` (`fkCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ambiente_Cliente1`
    FOREIGN KEY (`fkCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sensores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sensores` (
  `idSensores` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NULL,
  `dtInstalacao` DATE NULL,
  `Ambiente_idAmbiente` INT NOT NULL,
  PRIMARY KEY (`idSensores`),
  INDEX `fk_Sensores_Ambiente1_idx` (`Ambiente_idAmbiente` ASC) VISIBLE,
  CONSTRAINT `fk_Sensores_Ambiente1`
    FOREIGN KEY (`Ambiente_idAmbiente`)
    REFERENCES `mydb`.`Ambiente` (`idAmbiente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Leitura_Sensores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Leitura_Sensores` (
  `Sequencia_Leitura` INT NOT NULL AUTO_INCREMENT,
  `fkSensor` INT NOT NULL,
  `dtLeitura` DATETIME NOT NULL,
  `dth11_temperatura` FLOAT NULL,
  `dht11_umidade` FLOAT NULL,
  `ldr_lux` FLOAT NULL,
  PRIMARY KEY (`Sequencia_Leitura`, `fkSensor`, `dtLeitura`),
  INDEX `fk_Leitura_Sensores_Sensores1_idx` (`fkSensor` ASC) VISIBLE,
  CONSTRAINT `fk_Leitura_Sensores_Sensores1`
    FOREIGN KEY (`fkSensor`)
    REFERENCES `mydb`.`Sensores` (`idSensores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acervo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acervo` (
  `idAcervo` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Descricao` VARCHAR(200) NULL,
  `Tipos_Pintura` VARCHAR(45) NULL,
  `Ambiente_idAmbiente` INT NOT NULL,
  PRIMARY KEY (`idAcervo`),
  INDEX `fk_Acervo_Ambiente1_idx` (`Ambiente_idAmbiente` ASC) VISIBLE,
  CONSTRAINT `fk_Acervo_Ambiente1`
    FOREIGN KEY (`Ambiente_idAmbiente`)
    REFERENCES `mydb`.`Ambiente` (`idAmbiente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pintura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pintura` (
  `idPintura` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `fkAcervo` INT NULL,
  PRIMARY KEY (`idPintura`),
  INDEX `fk_Pintura_Acervo1_idx` (`fkAcervo` ASC) VISIBLE,
  CONSTRAINT `fk_Pintura_Acervo1`
    FOREIGN KEY (`fkAcervo`)
    REFERENCES `mydb`.`Acervo` (`idAcervo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cadastro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cadastro` (
  `idcadastro` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Email` VARCHAR(90) NOT NULL,
  `Senha` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`),
  CONSTRAINT `fk_cadastro_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
