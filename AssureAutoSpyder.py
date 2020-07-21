#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 21 10:41:24 2020

@author: simplon
"""


import pandas as pd
import sqlalchemy
import uuid
import re
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://simplon:Simplon123*@localhost:3306/AssureAuto')

CL_NOM = str.upper(input("Entrez votre nom : "))
print(CL_NOM)
CL_PRENOM = str.upper(input('Entrez votre prenom:'))
print(CL_PRENOM)
CL_TEL = input('Entrez votre numero de telephone:')
while not re.match("^[0-9]{10}$",CL_TEL):
    print('veuillez entrer un numero a 10 chiffres.')
    CL_TEL = input('Entrez votre numero de telephone:')
CL_ID =pd.read_sql_query('select max(Cl_ID) from Clients',engine)
CL_ID = CL_ID.iloc[0,0] + 1 
print('ID du client')
print(CL_ID)
CL_code_postal = input("Entrez votre code postale:")
while not re.match("^[0-9]{5}$", CL_code_postal):
    print("Veuillez entrer que des chiffres pour votre code postal")
    CL_code_postal = input("Entrez votre code postale:")
CL_VILLE = str(input('Entrez votre ville:'))

engine.execute('INSERT INTO Clients (Cl_ID, Cl_Prenom, Cl_Nom, Cl_Tel, Cl_Codepostale, Cl_ville)VALUES (%s, "%s","%s","%s","%s","%s");' %(CL_ID, CL_PRENOM, CL_NOM, CL_TEL, CL_code_postal, CL_VILLE))

Co_ID = pd.read_sql_query('select max(Co_ID) from Contrat',engine)
Co_ID = Co_ID.iloc[0,0] + 1 
print('ID du contrat')
print(Co_ID)
Co_Nom = str.upper(input("Entrez votre nom : "))
Co_Type = "Tout risques"
Co_Date = "Now()"
Co_Num = input('Entrez votre numero de contrat')
while not re.match("^[0-9]{5}$", Co_Num):
    print("Veuillez entrer que des chiffres pour votre numero de contrat")
    Co_Num = input("Entrez votre numero de contrat :")
Co_Bonus = '40%%'
Co_Malus = '0'
Co_Clients_FK = CL_ID
Co_Agence_FK = 1
Co_Ve_FK = 2346

engine.execute('INSERT INTO Contrat(Co_ID, Co_Nom, Co_Type, Co_Date, Co_Num, Co_Bonus, Co_Malus, Co_Clients_FK, Co_Agence_FK, Co_Ve_FK) VALUES (%s,"%s","%s", CURDATE(),%s,"%s","%s",%s,%s,%s);' %(Co_ID,Co_Nom,Co_Type,Co_Num,Co_Bonus,Co_Malus,Co_Clients_FK,Co_Agence_FK,Co_Ve_FK))
