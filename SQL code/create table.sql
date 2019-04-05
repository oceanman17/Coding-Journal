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
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `DepartmentID` INT NOT NULL,
  `Department Name` VARCHAR(45) NULL,
  PRIMARY KEY (`DepartmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `CategoryID` INT NOT NULL,
  `Category Name` VARCHAR(45) NULL,
  `Department_DepartmentID` INT NOT NULL,
  PRIMARY KEY (`CategoryID`),
  INDEX `fk_Category_Department1_idx` (`Department_DepartmentID` ASC) VISIBLE,
  CONSTRAINT `fk_Category_Department1`
    FOREIGN KEY (`Department_DepartmentID`)
    REFERENCES `mydb`.`Department` (`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specials` (
  `ID` INT NOT NULL,
  `Begin Date` DATE NULL,
  `End Date` DATE NULL,
  `Discount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Items` (
  `ItemID` INT NOT NULL,
  `ItemName` VARCHAR(45) NULL,
  `Price` DECIMAL(10,2) NULL,
  `Measure` VARCHAR(45) NULL,
  `Origin Country` VARCHAR(45) NULL,
  `Manufacture` VARCHAR(45) NULL,
  `Shelf life (days)` INT NULL,
  `Category_CategoryID` INT NOT NULL,
  `Specials_ID` INT NULL,
  PRIMARY KEY (`ItemID`),
  INDEX `fk_Items_Category1_idx` (`Category_CategoryID` ASC) VISIBLE,
  INDEX `fk_Items_Specials1_idx` (`Specials_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Items_Category1`
    FOREIGN KEY (`Category_CategoryID`)
    REFERENCES `mydb`.`Category` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Items_Specials1`
    FOREIGN KEY (`Specials_ID`)
    REFERENCES `mydb`.`Specials` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `AddressID` INT NOT NULL,
  `unit number` VARCHAR(45) NULL,
  `Zip code` INT NULL,
  `Street` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `Country` VARCHAR(45) NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Store` (
  `Store_ID` INT NOT NULL,
  `Address` VARCHAR(45) NULL,
  `workday` VARCHAR(45) NULL,
  `Address_AddressID` INT NOT NULL,
  PRIMARY KEY (`Store_ID`),
  INDEX `fk_Store_Address1_idx` (`Address_AddressID` ASC) VISIBLE,
  CONSTRAINT `fk_Store_Address1`
    FOREIGN KEY (`Address_AddressID`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `UserID` INT NOT NULL,
  `FName` VARCHAR(45) NULL,
  `Lname` VARCHAR(45) NULL,
  `Gender` VARCHAR(45) NULL,
  `DOB` DATE NULL,
  `Zip Code` INT NULL,
  `Email` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  `Store_Store_ID` INT NOT NULL,
  `Address_AddressID` INT NOT NULL,
  PRIMARY KEY (`UserID`),
  INDEX `fk_Customers_Store1_idx` (`Store_Store_ID` ASC) VISIBLE,
  INDEX `fk_Customers_Address1_idx` (`Address_AddressID` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Store1`
    FOREIGN KEY (`Store_Store_ID`)
    REFERENCES `mydb`.`Store` (`Store_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_Address1`
    FOREIGN KEY (`Address_AddressID`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shopping List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shopping List` (
  `ID` INT NOT NULL,
  `List Name` VARCHAR(45) NULL,
  `Creation Date` DATE NULL,
  `Customers_UserID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Shopping List_Customers1_idx` (`Customers_UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Shopping List_Customers1`
    FOREIGN KEY (`Customers_UserID`)
    REFERENCES `mydb`.`Customers` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Items_has_Shopping List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Items_has_Shopping List` (
  `Items_ItemID` INT NOT NULL,
  `Shopping List_ID` INT NOT NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`Items_ItemID`, `Shopping List_ID`),
  INDEX `fk_Items_has_Shopping List_Shopping List1_idx` (`Shopping List_ID` ASC) VISIBLE,
  INDEX `fk_Items_has_Shopping List_Items_idx` (`Items_ItemID` ASC) VISIBLE,
  CONSTRAINT `fk_Items_has_Shopping List_Items`
    FOREIGN KEY (`Items_ItemID`)
    REFERENCES `mydb`.`Items` (`ItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Items_has_Shopping List_Shopping List1`
    FOREIGN KEY (`Shopping List_ID`)
    REFERENCES `mydb`.`Shopping List` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `AccountID` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NULL,
  `User Name` VARCHAR(45) NULL,
  `Join Date` DATE NULL,
  `Customers_UserID` INT NOT NULL,
  PRIMARY KEY (`AccountID`),
  INDEX `fk_Account_Customers1_idx` (`Customers_UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Account_Customers1`
    FOREIGN KEY (`Customers_UserID`)
    REFERENCES `mydb`.`Customers` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Card` (
  `Card Number` INT NOT NULL,
  `Card Expiration Date` DATE NULL,
  `CVV` INT NULL,
  `First Name` VARCHAR(45) NULL,
  `Last Name` VARCHAR(45) NULL,
  `Billing Address` VARCHAR(45) NULL,
  `Card Type` VARCHAR(45) NULL,
  `Address_AddressID` INT NOT NULL,
  PRIMARY KEY (`Card Number`),
  INDEX `fk_Card_Address1_idx` (`Address_AddressID` ASC) VISIBLE,
  CONSTRAINT `fk_Card_Address1`
    FOREIGN KEY (`Address_AddressID`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Card_has_Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Card_has_Account` (
  `Card_Card Number` INT NOT NULL,
  `Account_AccountID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Card_Card Number`, `Account_AccountID`),
  INDEX `fk_Card_has_Account_Account1_idx` (`Account_AccountID` ASC) VISIBLE,
  INDEX `fk_Card_has_Account_Card1_idx` (`Card_Card Number` ASC) VISIBLE,
  CONSTRAINT `fk_Card_has_Account_Card1`
    FOREIGN KEY (`Card_Card Number`)
    REFERENCES `mydb`.`Card` (`Card Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Card_has_Account_Account1`
    FOREIGN KEY (`Account_AccountID`)
    REFERENCES `mydb`.`Account` (`AccountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Items_has_Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Items_has_Store` (
  `Items_ItemID` INT NOT NULL,
  `Store_Store_ID` INT NOT NULL,
  PRIMARY KEY (`Items_ItemID`, `Store_Store_ID`),
  INDEX `fk_Items_has_Store_Store1_idx` (`Store_Store_ID` ASC) VISIBLE,
  INDEX `fk_Items_has_Store_Items1_idx` (`Items_ItemID` ASC) VISIBLE,
  CONSTRAINT `fk_Items_has_Store_Items1`
    FOREIGN KEY (`Items_ItemID`)
    REFERENCES `mydb`.`Items` (`ItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Items_has_Store_Store1`
    FOREIGN KEY (`Store_Store_ID`)
    REFERENCES `mydb`.`Store` (`Store_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (100,'Food');
INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (200,'Kitchen & Dining');
INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (300,'Beauty & Personal Care');
INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (400,'Fashion');
INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (500,'Electronics');
INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (600,'Bedding');
INSERT INTO `Department` (`DepartmentID`,`Department Name`) VALUES (700,'Automotive');

INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (101,'seafood',100);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (102,'vegetable',100);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (201,'Travel & To-Go Drinkware',200);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (202,'Commuter & Travel Mugs',200);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (401,'Men\'s Fashion',400);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (402,'Women\'s Fashion',400);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (301,'Hair Styling',300);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (302,'Facial Care',300);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (501,'Televisions',500);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (502,'Computers & Accessories',500);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (601,'Sheets & Pillowcase',600);
INSERT INTO `Category` (`CategoryID`,`Category Name`,`Department_DepartmentID`) VALUES (701,'Car accessories',700);

INSERT INTO `Shopping List` (`ID`,`List Name`,`Creation Date`,`Customers_UserID`) VALUES (31,'fancy food','2018-01-02',8008135);
INSERT INTO `Shopping List` (`ID`,`List Name`,`Creation Date`,`Customers_UserID`) VALUES (32,'my favourite','2018-03-04',1234567);
INSERT INTO `Shopping List` (`ID`,`List Name`,`Creation Date`,`Customers_UserID`) VALUES (33,'super','2018-01-09',8881888);
INSERT INTO `Shopping List` (`ID`,`List Name`,`Creation Date`,`Customers_UserID`) VALUES (34,'tasty','2018-07-04',8000008);
INSERT INTO `Shopping List` (`ID`,`List Name`,`Creation Date`,`Customers_UserID`) VALUES (35,'love','2018-06-06',8008135);
INSERT INTO `Shopping List` (`ID`,`List Name`,`Creation Date`,`Customers_UserID`) VALUES (36,'Want','2018-04-01',1234567);

INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (1,'Kens Oyster',5,'1ounces','USA','Kens Seafood Company',4,101,NULL);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (2,'Carolina Water bottle',8,'1 unit','USA','Carolina Int. Co.',10000000,201,100);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (3,'Carrot',1,'lb','USA','Cindy\'s Farm',5,102,103);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (4,'Sebastian Boots',30,'unit','Austria','Fischbach Co., Ltd',10000000,401,102);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (5,'Colin Hair Gel',6,'unit','China','Pan\'s Int. Co.',365,301,101);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (6,'Xinyun 4K Super-thin TV',1000,'unit','China','Tang Dynasty Co.',10000000,501,NULL);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (7,'Ying Pillow Case',5,'unit','China','Yang Co.',10000000,601,104);
INSERT INTO `Items` (`ItemID`,`ItemName`,`Price`,`Measure`,`Origin Country`,`Manufacture`,`Shelf life (days)`,`Category_CategoryID`,`Specials_ID`) VALUES (8,'Motor Oil',12,'Unit','Germany','Advance Auto Parts',10000000,701,NULL);

INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (12345678,'2021-08-01',111,'Cecil','Newton','1 Rich Way','Visa',20);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (55555555,'2020-07-01',222,'Chuck','Chucky','3 Main Street','Visa',21);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (22222222,'2019-01-01',344,'Dom','Brady','5 Patriot Way','Mastercard',22);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (33455425,'2021-03-01',478,'Score','Waterfall','3 Water Trail','Mastercard',23);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (35154365,'2021-09-01',909,'Genghis','Khan','1 Europe Road','American Express',24);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (58324292,'2020-03-23',123,'Cecil','Newton','1 Rich Way','Visa',25);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (43501238,'2023-04-27',345,'Chuck','Chucky','3 Main Street','Visa',26);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (23409582,'2020-08-23',567,'Dom','Brady','5 Patriot Way','Mastercard',27);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (19384234,'2019-01-03',231,'Score','Waterfall','3 Water Trail','Mastercard',28);
INSERT INTO `Card` (`Card Number`,`Card Expiration Date`,`CVV`,`First Name`,`Last Name`,`Billing Address`,`Card Type`,`Address_AddressID`) VALUES (86394234,'2019-12-31',986,'Genghis','Khan','1 Europe Road','American Express',29);

INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (20,'27a',27106,'Woody Drive','Asheville','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (21,'808',28430,'Psycho Path','Deremmah','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (22,'45',57204,'Wake Road','Dekab','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (23,'12',45091,'Forest Drive','Denots','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (24,'56e',59382,'Hollow Oaks','Detsaw','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (25,'23',27408,'Main Drive','Greensboro','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (26,'354',27516,'Lee Street','Asheboro','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (27,'462d',21453,'Main Street','Asheville','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (28,'352',27401,'Left Street','Dekab','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (29,'343',12345,'Right Road','Denots','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (30,'526',52466,'Oak Trail','Greensboro','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (31,'76357',11223,'Shallow Trail','Greensboro','USA');
INSERT INTO `Address` (`AddressID`,`unit number`,`Zip code`,`Street`,`City`,`Country`) VALUES (32,'34',23355,'Deep Road','Winston-Salem','USA');

INSERT INTO `Specials` (`ID`,`Begin Date`,`End Date`,`Discount`) VALUES (100,'2018-10-04','2018-11-04',0.15);
INSERT INTO `Specials` (`ID`,`Begin Date`,`End Date`,`Discount`) VALUES (101,'2018-06-27','2018-07-27',0.3);
INSERT INTO `Specials` (`ID`,`Begin Date`,`End Date`,`Discount`) VALUES (102,'2018-05-17','2018-06-17',0.5);
INSERT INTO `Specials` (`ID`,`Begin Date`,`End Date`,`Discount`) VALUES (103,'2018-11-03','2018-11-30',0.2);
INSERT INTO `Specials` (`ID`,`Begin Date`,`End Date`,`Discount`) VALUES (104,'2018-11-25','2018-12-31',0.1);

INSERT INTO `Store` (`Store_ID`,`workday`,`Address_AddressID`) VALUES (6,'7',31);
INSERT INTO `Store` (`Store_ID`,`workday`,`Address_AddressID`) VALUES (7,'7',32);
INSERT INTO `Store` (`Store_ID`,`workday`,`Address_AddressID`) VALUES (8,'5',33);
INSERT INTO `Store` (`Store_ID`,`workday`,`Address_AddressID`) VALUES (9,'6',34);
INSERT INTO `Store` (`Store_ID`,`workday`,`Address_AddressID`) VALUES (10,'7',35);

INSERT INTO `Customers` (`UserID`,`FName`,`Lname`,`Gender`,`DOB`,`Zip Code`,`Email`,`Phone`,`Store_Store_ID`,`Address_AddressID`) VALUES (8008135,'Scam','Newton','Male','1969-8-15',27408,'coolguy@yahoo.com','3364045555',6,20);
INSERT INTO `Customers` (`UserID`,`FName`,`Lname`,`Gender`,`DOB`,`Zip Code`,`Email`,`Phone`,`Store_Store_ID`,`Address_AddressID`) VALUES (1234567,'Chuck','Chucky','Female','1975-9-1',27516,'coolerguy@yahoo.com','9191234567',7,21);
INSERT INTO `Customers` (`UserID`,`FName`,`Lname`,`Gender`,`DOB`,`Zip Code`,`Email`,`Phone`,`Store_Store_ID`,`Address_AddressID`) VALUES (8881888,'Dom','Brady','Male','2000-10-11',27106,'sickguy@yahoo.com','3363356780',8,22);
INSERT INTO `Customers` (`UserID`,`FName`,`Lname`,`Gender`,`DOB`,`Zip Code`,`Email`,`Phone`,`Store_Store_ID`,`Address_AddressID`) VALUES (8000008,'Score','Waterfall','Female','1982-4-1',27106,'wttf@gmail.com','8882265543',9,23);
INSERT INTO `Customers` (`UserID`,`FName`,`Lname`,`Gender`,`DOB`,`Zip Code`,`Email`,`Phone`,`Store_Store_ID`,`Address_AddressID`) VALUES (6669999,'Genghis','Khan','Male','1962-8-12',27408,'rulerofworld@gmail.com','1110000001',10,24);

INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (1,6);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (2,6);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (3,6);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (4,7);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (5,7);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (6,8);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (7,9);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (8,9);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (1,7);
INSERT INTO `Items_has_Store` (`Items_ItemID`,`Store_Store_ID`) VALUES (1,10);

INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111111','YingYing','CN001','2018-01-01',8008135);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111112','YunYun','CC002','2017-03-03',1234567);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111113','MaxMax','DB003','2015-05-05',8881888);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111114','Colcol','SW004','2018-02-02',8000008);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111115','SebSeb','GK005','2014-07-07',6669999);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111116','ASDFS','SK006','2016-07-23',8008135);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111117','PSFJG','PK007','2014-09-23',8008135);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111118','VASDK','SG008','2015-01-01',8881888);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111119','WEGKS','RM009','2016-04-04',8000008);
INSERT INTO `Account` (`AccountID`,`Password`,`User Name`,`Join Date`,`Customers_UserID`) VALUES ('111120','ASDIK','QK010','2011-01-30',6669999);

INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (12345678,'111111');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (55555555,'111112');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (22222222,'111113');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (33455425,'111114');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (35154365,'111115');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (58324292,'111116');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (43501238,'111117');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (23409582,'111112');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (33455425,'111119');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (22222222,'111120');
INSERT INTO `Card_has_Account` (`Card_Card Number`,`Account_AccountID`) VALUES (35154365,'111112');

INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (1,31,12);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (2,31,2);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (1,32,4);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (5,33,2);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (4,33,4);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (3,34,3);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (3,35,1);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (7,36,1);
INSERT INTO `Items_has_Shopping List` (`Items_ItemID`,`Shopping List_ID`,`Quantity`) VALUES (6,36,3);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;