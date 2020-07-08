CREATE TABLE IF NOT EXISTS Clients(

    Cl_ID INT NOT NULL PRIMARY KEY,
    Cl_Prenom VARCHAR(30) NOT NULL,
    Cl_Nom VARCHAR(30) NOT NULL,
	Cl_TeL VARCHAR(15) NOT NULL,
	Cl_Adresse VARCHAR(200),
    Cl_Codepostale VARCHAR (10) NOT NULL,
    Cl_Ville VARCHAR (50) NOT NULL CHECK(Cl_Ville ='CANNES'));

CREATE TABLE IF NOT EXISTS Contrat(
	Co_ID INT NOT NULL PRIMARY KEY,
	Co_Nom VARCHAR(30) NOT NULL,
	Co_Type VARCHAR(100) NOT NULL,
	Co_Date DATE NOT NULL,
	Co_Num VARCHAR(100) NOT NULL,
	Co_Bonus VARCHAR(30) NOT NULL,
	Co_Malus VARCHAR(30) NOT NULL,
	Co_Clients_FK INT NOT NULL,
	FOREIGN KEY (Co_Clients_FK) REFERENCES Clients (Cl_ID));

INSERT INTO Clients (Cl_ID, Cl_Prenom, Cl_Nom, Cl_Tel, Cl_Adresse, Cl_Codepostale, Cl_Ville) VALUES
   (1, 'Juliette', 'Gard', '0620265448', '4 Chemin debouze', '06400', 'Cannes'),
   (2, 'Gerard', 'Placard', '0658721580', '90 Avenue Chantalclerc', '06400', 'Cannes'),
   (3, 'Jackson', 'Sugard', '0789512631', '61 Route de vilain', '06400', 'Cannes');
   
   
INSERT INTO Contrat (Co_ID, Co_Date, Co_Nom, Co_Type, Co_Num, Co_Bonus, Co_Malus, Co_Clients_FK) VALUES
(1, '2012/10/25', 'Gard', 'Tout risque', '1458796', '50', '0', 1),
(2, '2010/09/06', 'Placard', 'Tiers', '1548673', '25', '0', 2),
(3, '2018/08/22', 'Sugar', 'Tout risque', '1974523', '0', '10', 3);
