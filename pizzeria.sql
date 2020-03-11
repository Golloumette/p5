-- MySQL Script generated by MySQL Workbench
-- Mon Mar  9 15:34:46 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
-- Base de donnée pour le focntionnement d'une site internet de OC PIZZA
-- 

-- -----------------------------------------------------
-- Schema Pizzeria
--
-- Base de donnée pour le focntionnement d'une site internet de OC PIZZA
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NULL,
  `complement_adresse` VARCHAR(100) NULL,
  `code_postal` VARCHAR(10) NULL,
  `ville` VARCHAR(200) NOT NULL,
  `telephone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`point_de_vente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`point_de_vente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `code_postal` VARCHAR(10) NULL,
  `ville` VARCHAR(200) NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`ingredient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `quantite` SMALLINT(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nom_ingredient_UNIQUE` (`nom` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`utilisateur` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `login` VARCHAR(10) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `pizzaiolo` TINYINT NOT NULL,
  `livreur` TINYINT NOT NULL,
  `responsable` TINYINT NOT NULL,
  `actif` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prix` DOUBLE NULL,
  `recette` TEXT(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza_has_ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza_has_ingredient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizza_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pizza_has_ingredient_ingredient1_idx` (`ingredient_id` ASC) ,
  INDEX `fk_pizza_has_ingredient_pizza_idx` (`pizza_id` ASC) ,
  CONSTRAINT `fk_pizza_has_ingredient_pizza`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `Pizzeria`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `Pizzeria`.`ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`stock` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `quantite` SMALLINT(100) NULL,
  `point_de_vente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stock_point_de_vente1_idx` (`point_de_vente_id` ASC) ,
  CONSTRAINT `fk_stock_point_de_vente1`
    FOREIGN KEY (`point_de_vente_id`)
    REFERENCES `Pizzeria`.`point_de_vente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`moyen_de_paiement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`moyen_de_paiement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `moyen` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mode_de_livraison` INT NULL,
  `dt_commande` TIMESTAMP NULL,
  `dt_prise_en_chage` TIMESTAMP NULL,
  `dt_debut_livreur` TIMESTAMP NULL,
  `dt_fin_livreur` TIMESTAMP NULL,
  `montant` DECIMAL NULL,
  `pizzaïolo_id` INT NOT NULL,
  `livreur_id` INT NOT NULL,
  `moyen_de_paiement_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `point_de_vente_id` INT NOT NULL,
  PRIMARY KEY (`id`, `client_id`),
  INDEX `fk_commande_utilisateur1_idx` (`pizzaïolo_id` ASC) ,
  INDEX `fk_commande_utilisateur2_idx` (`livreur_id` ASC) ,
  INDEX `fk_commande_moyen_de_paiement1_idx` (`moyen_de_paiement_id` ASC) ,
  INDEX `fk_commande_client1_idx` (`client_id` ASC) ,
  INDEX `fk_commande_point_de_vente1_idx` (`point_de_vente_id` ASC) ,
  CONSTRAINT `fk_commande_utilisateur1`
    FOREIGN KEY (`pizzaïolo_id`)
    REFERENCES `Pizzeria`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_utilisateur2`
    FOREIGN KEY (`livreur_id`)
    REFERENCES `Pizzeria`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_moyen_de_paiement1`
    FOREIGN KEY (`moyen_de_paiement_id`)
    REFERENCES `Pizzeria`.`moyen_de_paiement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `Pizzeria`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_point_de_vente1`
    FOREIGN KEY (`point_de_vente_id`)
    REFERENCES `Pizzeria`.`point_de_vente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`commande_has_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`commande_has_pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commande_id` INT NOT NULL,
  `pizza_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_commande_has_pizza_pizza1_idx` (`pizza_id` ASC) ,
  INDEX `fk_commande_has_pizza_commande1_idx` (`commande_id` ASC) ,
  CONSTRAINT `fk_commande_has_pizza_commande1`
    FOREIGN KEY (`commande_id`)
    REFERENCES `Pizzeria`.`commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `Pizzeria`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
