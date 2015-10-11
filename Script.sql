-- MySQL Script generated by MySQL Workbench
-- 10/10/15 15:58:58
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema OutGuat
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OutGuat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OutGuat` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `OutGuat` ;

-- -----------------------------------------------------
-- Table `OutGuat`.`TipoEstablecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`TipoEstablecimiento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Establecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Establecimiento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idTipoEstablecimiento` INT NOT NULL,
  PRIMARY KEY (`id`, `idTipoEstablecimiento`),
  INDEX `fk_Establecimiento_TipoEstablecimiento_idx` (`idTipoEstablecimiento` ASC),
  CONSTRAINT `fk_Establecimiento_TipoEstablecimiento`
    FOREIGN KEY (`idTipoEstablecimiento`)
    REFERENCES `OutGuat`.`TipoEstablecimiento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Atributo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Atributo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(128) NOT NULL,
  `dimension` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`HotelAtributo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`HotelAtributo` (
  `id` INT NOT NULL,
  `Establecimiento_id` INT NOT NULL,
  `Establecimiento_TipoEstablecimiento_id` INT NOT NULL,
  `Atributo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_HotelAtributo_Establecimiento1_idx` (`Establecimiento_id` ASC, `Establecimiento_TipoEstablecimiento_id` ASC),
  INDEX `fk_HotelAtributo_Atributo1_idx` (`Atributo_id` ASC),
  CONSTRAINT `fk_HotelAtributo_Establecimiento1`
    FOREIGN KEY (`Establecimiento_id` , `Establecimiento_TipoEstablecimiento_id`)
    REFERENCES `OutGuat`.`Establecimiento` (`id` , `idTipoEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HotelAtributo_Atributo1`
    FOREIGN KEY (`Atributo_id`)
    REFERENCES `OutGuat`.`Atributo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Valor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Valor` (
  `idEstablecimiento` INT NOT NULL,
  `idAtributo` INT NOT NULL,
  `cantidad` INT NULL,
  `valor` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`idAtributo`, `idEstablecimiento`),
  INDEX `fk_Valor_Establecimiento1_idx` (`idEstablecimiento` ASC),
  INDEX `fk_Valor_Atributo1_idx` (`idAtributo` ASC),
  CONSTRAINT `fk_Valor_Establecimiento1`
    FOREIGN KEY (`idEstablecimiento`)
    REFERENCES `OutGuat`.`Establecimiento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Valor_Atributo1`
    FOREIGN KEY (`idAtributo`)
    REFERENCES `OutGuat`.`Atributo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Dimension` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Servicio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Calificacion` (
  `idEstablecimiento` INT NOT NULL,
  `idServicio` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `punteo` MEDIUMINT(9) NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idEstablecimiento`, `idServicio`, `idUsuario`),
  INDEX `fk_HotelServicio_Establecimiento1_idx` (`idEstablecimiento` ASC),
  INDEX `fk_HotelServicio_Servicio1_idx` (`idServicio` ASC),
  INDEX `fk_Calificacion_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_HotelServicio_Establecimiento1`
    FOREIGN KEY (`idEstablecimiento`)
    REFERENCES `OutGuat`.`Establecimiento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HotelServicio_Servicio1`
    FOREIGN KEY (`idServicio`)
    REFERENCES `OutGuat`.`Servicio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calificacion_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `OutGuat`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`TipoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`TipoUsuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idTipoUsuario` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(128) NULL,
  `edad` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  `genero` TINYINT(4) NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `idTipoUsuario`),
  INDEX `fk_Usuario_TipoUsuario1_idx` (`idTipoUsuario` ASC),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`idTipoUsuario`)
    REFERENCES `OutGuat`.`TipoUsuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Reservas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idEstablecimiento` INT NOT NULL,
  `idAtributo` INT NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prereservas_Usuario1_idx` (`idUsuario` ASC),
  INDEX `fk_Reservas_Valor1_idx` (`idAtributo` ASC, `idEstablecimiento` ASC),
  CONSTRAINT `fk_Prereservas_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `OutGuat`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservas_Valor1`
    FOREIGN KEY (`idAtributo` , `idEstablecimiento`)
    REFERENCES `OutGuat`.`Valor` (`idAtributo` , `idEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Calificacion` (
  `idEstablecimiento` INT NOT NULL,
  `idServicio` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `punteo` MEDIUMINT(9) NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idEstablecimiento`, `idServicio`, `idUsuario`),
  INDEX `fk_HotelServicio_Establecimiento1_idx` (`idEstablecimiento` ASC),
  INDEX `fk_HotelServicio_Servicio1_idx` (`idServicio` ASC),
  INDEX `fk_Calificacion_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_HotelServicio_Establecimiento1`
    FOREIGN KEY (`idEstablecimiento`)
    REFERENCES `OutGuat`.`Establecimiento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HotelServicio_Servicio1`
    FOREIGN KEY (`idServicio`)
    REFERENCES `OutGuat`.`Servicio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calificacion_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `OutGuat`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`HotelDimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`HotelDimension` (
  `id` INT NOT NULL,
  `Establecimiento_id` INT NOT NULL,
  `Establecimiento_TipoEstablecimiento_id` INT NOT NULL,
  `Dimension_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_HotelDimension_Establecimiento1_idx` (`Establecimiento_id` ASC, `Establecimiento_TipoEstablecimiento_id` ASC),
  INDEX `fk_HotelDimension_Dimension1_idx` (`Dimension_id` ASC),
  CONSTRAINT `fk_HotelDimension_Establecimiento1`
    FOREIGN KEY (`Establecimiento_id` , `Establecimiento_TipoEstablecimiento_id`)
    REFERENCES `OutGuat`.`Establecimiento` (`id` , `idTipoEstablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HotelDimension_Dimension1`
    FOREIGN KEY (`Dimension_id`)
    REFERENCES `OutGuat`.`Dimension` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OutGuat`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OutGuat`.`Comentario` (
  `id` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `idEstablecimiento` INT NOT NULL,
  `idServicio` INT NOT NULL,
  `comentario` VARCHAR(128) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comentario_Calificacion1_idx` (`idEstablecimiento` ASC, `idServicio` ASC, `idUsuario` ASC),
  CONSTRAINT `fk_Comentario_Calificacion1`
    FOREIGN KEY (`idEstablecimiento` , `idServicio` , `idUsuario`)
    REFERENCES `OutGuat`.`Calificacion` (`idEstablecimiento` , `idServicio` , `idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;