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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Store` (
  `StoreID` INT NOT NULL,
  `City` VARCHAR(45) NULL,
  `Road` VARCHAR(45) NULL,
  `ZipCode` INT NULL,
  PRIMARY KEY (`StoreID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lane` (
  `LaneID` INT NOT NULL,
  `Store_StoreID` INT NOT NULL,
  PRIMARY KEY (`LaneID`, `Store_StoreID`),
  INDEX `fk_Lane_Store1_idx` (`Store_StoreID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cashier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cashier` (
  `CashierID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `SupervisorID` INT NOT NULL,
  PRIMARY KEY (`CashierID`),
  INDEX `fk_Cashier_Cashier1_idx` (`SupervisorID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `TransactionID` BIGINT(20) NOT NULL,
  `Store_StoreID` INT NOT NULL,
  `Cashier_CashierID` INT NOT NULL,
  `TransactionDateTime` DATETIME NULL,
  PRIMARY KEY (`TransactionID`),
  INDEX `fk_Transaction_Store1_idx` (`Store_StoreID` ASC) VISIBLE,
  INDEX `fk_Transaction_Cashier1_idx` (`Cashier_CashierID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `CustomersID` INT NOT NULL,
  `Age` INT NULL,
  `ZipCode` INT NULL,
  PRIMARY KEY (`CustomersID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cards` (
  `CardID` BIGINT(20) NOT NULL,
  `Customers_CustomersID` INT NOT NULL,
  PRIMARY KEY (`CardID`),
  INDEX `fk_Cards_Customers1_idx` (`Customers_CustomersID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `CategoryID` VARCHAR(20) NOT NULL,
  `CategoryName` VARCHAR(45) NULL,
  PRIMARY KEY (`CategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SuperCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SuperCategory` (
  `SuperCategoryID` VARCHAR(20) NOT NULL,
  `SuperCategoryName` VARCHAR(45) NULL,
  `Category_CategoryID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`SuperCategoryID`),
  INDEX `fk_SuperCategory_Category1_idx` (`Category_CategoryID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Superdepartment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Superdepartment` (
  `SuperdepartmentID` VARCHAR(20) NOT NULL,
  `SuperdepartmentName` VARCHAR(45) NULL,
  PRIMARY KEY (`SuperdepartmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `DepartmentID` VARCHAR(20) NOT NULL,
  `DepartmentName` VARCHAR(45) NULL,
  `Superdepartment_SuperdepartmentID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`DepartmentID`),
  INDEX `fk_Department_Superdepartment1_idx` (`Superdepartment_SuperdepartmentID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `ItemID` BIGINT(20) NOT NULL,
  `ItemName` VARCHAR(100) NULL,
  `Size` DECIMAL(10,2) NULL,
  `UnitOfMeasure` VARCHAR(10) NULL,
  `SuperCategory_SuperCategoryID` VARCHAR(20) NOT NULL,
  `Department_DepartmentID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ItemID`),
  INDEX `fk_Item_SuperCategory1_idx` (`SuperCategory_SuperCategoryID` ASC) VISIBLE,
  INDEX `fk_Item_Department1_idx` (`Department_DepartmentID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Store_has_Cashier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Store_has_Cashier` (
  `Store_StoreID` INT NOT NULL,
  `Cashier_CashierID` INT NOT NULL,
  PRIMARY KEY (`Store_StoreID`, `Cashier_CashierID`),
  INDEX `fk_Store_has_Cashier_Cashier1_idx` (`Cashier_CashierID` ASC) VISIBLE,
  INDEX `fk_Store_has_Cashier_Store1_idx` (`Store_StoreID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lane_has_Cashier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lane_has_Cashier` (
  `Lane_LaneID` INT NOT NULL,
  `Lane_Store_StoreID` INT NOT NULL,
  `Cashier_CashierID` INT NOT NULL,
  PRIMARY KEY (`Lane_LaneID`, `Lane_Store_StoreID`, `Cashier_CashierID`),
  INDEX `fk_Lane_has_Cashier_Cashier1_idx` (`Cashier_CashierID` ASC) VISIBLE,
  INDEX `fk_Lane_has_Cashier_Lane1_idx` (`Lane_LaneID` ASC, `Lane_Store_StoreID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item_has_Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item_has_Transaction` (
  `Item_ItemID` BIGINT(20) NOT NULL,
  `Transaction_TransactionID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`Item_ItemID`, `Transaction_TransactionID`),
  INDEX `fk_Item_has_Transaction_Transaction1_idx` (`Transaction_TransactionID` ASC) VISIBLE,
  INDEX `fk_Item_has_Transaction_Item1_idx` (`Item_ItemID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction_has_Cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaction_has_Cards` (
  `Transaction_TransactionID` BIGINT(20) NOT NULL,
  `Cards_CardID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`Transaction_TransactionID`, `Cards_CardID`),
  INDEX `fk_Transaction_has_Cards_Cards1_idx` (`Cards_CardID` ASC) VISIBLE,
  INDEX `fk_Transaction_has_Cards_Transaction1_idx` (`Transaction_TransactionID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category_has_Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category_has_Department` (
  `Category_CategoryID` VARCHAR(20) NOT NULL,
  `Department_DepartmentID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Category_CategoryID`, `Department_DepartmentID`),
  INDEX `fk_Category_has_Department_Department1_idx` (`Department_DepartmentID` ASC) VISIBLE,
  INDEX `fk_Category_has_Department_Category1_idx` (`Category_CategoryID` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
