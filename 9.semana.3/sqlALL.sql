select * from usuario;
select * from tipousuario;
insert into usuario (Rut, Nombre, Apellido, Email, Password, NUmCelular, tipousuario_idtipousuario) values ('132365450','Elsa','Pato','e@p.cl','12345','9323232', 1);
insert into usuario (Rut, Nombre, Apellido, Email, Password, NUmCelular, tipousuario_idtipousuario) values ('132641208','Alan','Brito','a@b.cl','23456','8231456', 2);
insert into usuario (Rut, Nombre, Apellido, Email, Password, NUmCelular, tipousuario_idtipousuario) values ('138889998','Armando','Casas','a@c.cl','22356','77231456', 1);
insert into usuario (Rut, Nombre, Apellido, Email, Password, NUmCelular, tipousuario_idtipousuario) values ('130001112','Man','Aty','m@a.cl','12345','8882226', 2);
insert into usuario (Rut, Nombre, Apellido, Email, Password, NUmCelular, tipousuario_idtipousuario) values ('151112225','Tulio','Triviño','t@t.cl','12345','77555666', 2);


drop database agenda;
delete from tipousuario where idtipousuario > 1;
insert into tipousuario (nombre) values ('proveedor');
insert into tipousuario (nombre) values ('cliente');



SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema agenda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema agenda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agenda` DEFAULT CHARACTER SET utf8 ;
USE `agenda` ;

-- -----------------------------------------------------
-- Table `agenda`.`tipoUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`tipoUsuario` ;

CREATE TABLE IF NOT EXISTS `agenda`.`tipoUsuario` (
  `idTipoUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Rut` INT(9) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `NumCelular` VARCHAR(45) NOT NULL,
  `tipoUsuario_idTipoUsuario` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_tipoUsuario1_idx` (`tipoUsuario_idTipoUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_tipoUsuario1`
    FOREIGN KEY (`tipoUsuario_idTipoUsuario`)
    REFERENCES `agenda`.`tipoUsuario` (`idTipoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Comuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Comuna` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Comuna` (
  `idComuna` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `Comuna` VARCHAR(45) NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  `Region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idComuna`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Sucursal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Sucursal` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `NombreSuc` VARCHAR(45) NOT NULL,
  `Comuna_idComuna` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_Sucursal_Comuna1_idx` (`Comuna_idComuna` ASC) VISIBLE,
  CONSTRAINT `fk_Sucursal_Comuna1`
    FOREIGN KEY (`Comuna_idComuna`)
    REFERENCES `agenda`.`Comuna` (`idComuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Reserva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Reserva` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Reserva` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Hora` TIME NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Sucursal_idSucursal` INT NOT NULL,
  PRIMARY KEY (`idReserva`, `Sucursal_idSucursal`),
  INDEX `fk_Reserva_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Reserva_Sucursal1_idx` (`Sucursal_idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `agenda`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Sucursal1`
    FOREIGN KEY (`Sucursal_idSucursal`)
    REFERENCES `agenda`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Servicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Servicio` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Servicio` (
  `idServicio` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Disponibilidad` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idServicio`),
  INDEX `fk_Servicio_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Servicio_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `agenda`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Horario` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Horario` (
  `idHorario` INT NOT NULL AUTO_INCREMENT,
  `Disponibilidad` TINYINT NULL,
  `reserva` TINYINT NULL,
  `Sucursal_idSucursal` INT NOT NULL,
  PRIMARY KEY (`idHorario`, `Sucursal_idSucursal`),
  INDEX `fk_Horario_Sucursal1_idx` (`Sucursal_idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_Horario_Sucursal1`
    FOREIGN KEY (`Sucursal_idSucursal`)
    REFERENCES `agenda`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Reserva_has_Servicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Reserva_has_Servicio` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Reserva_has_Servicio` (
  `Reserva_idReserva` INT NOT NULL,
  `Servicio_idServicio` INT NOT NULL,
  PRIMARY KEY (`Reserva_idReserva`, `Servicio_idServicio`),
  INDEX `fk_Reserva_has_Servicio_Servicio1_idx` (`Servicio_idServicio` ASC) VISIBLE,
  INDEX `fk_Reserva_has_Servicio_Reserva1_idx` (`Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_has_Servicio_Reserva1`
    FOREIGN KEY (`Reserva_idReserva`)
    REFERENCES `agenda`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_has_Servicio_Servicio1`
    FOREIGN KEY (`Servicio_idServicio`)
    REFERENCES `agenda`.`Servicio` (`idServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda`.`Sucursal_has_Servicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenda`.`Sucursal_has_Servicio` ;

CREATE TABLE IF NOT EXISTS `agenda`.`Sucursal_has_Servicio` (
  `Sucursal_idSucursal` INT NOT NULL,
  `Servicio_idServicio` INT NOT NULL,
  PRIMARY KEY (`Sucursal_idSucursal`, `Servicio_idServicio`),
  INDEX `fk_Sucursal_has_Servicio_Servicio1_idx` (`Servicio_idServicio` ASC) VISIBLE,
  INDEX `fk_Sucursal_has_Servicio_Sucursal1_idx` (`Sucursal_idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_Sucursal_has_Servicio_Sucursal1`
    FOREIGN KEY (`Sucursal_idSucursal`)
    REFERENCES `agenda`.`Sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_has_Servicio_Servicio1`
    FOREIGN KEY (`Servicio_idServicio`)
    REFERENCES `agenda`.`Servicio` (`idServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
