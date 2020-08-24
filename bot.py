#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 11:08:12 2020

@author: simplon
"""


import random

question_depart= ["Comment allez vous?",
                  "Pourquoi venez vous me parler?",
                  "Comment s'est passée votre journée?"]

mot_clé= ["père","mère","copain","copine","maman","papa","amie","ami"]

reponse_depart=["Comment va votre %s?","La relation avec votre %s vous pose t-elle problème?",
                "Pourquoi pensez-vous en ce moment a votre %s" ]

reponse_autre=["Pouquoi me posez vous cette question","Oseriez vous poser cette question à un humain?",
               "Je ne peux malheureusement pas répondre à votre question "]

reponse_fin=["J'entend bien","Je sens une pointe de regret","Est ce une bonne nouvelle?","Oui, c'est ça le problème",
             "Pensez vous ce que vous dites?","Hum...il se peut"]

listeMotTriste= ["mort","accident","morte","bléssé","pleure","pleurer",
                 "tristesse","enterement"]

liste_exclamation=["vous avez l'air d'apprecier votre %s","vous avez l'air de bonne humeur"]

depart= random.randint(0,len(question_depart)-1)

reponse= input(question_depart[depart])
while reponse != "":
    for mot in mot_clé:
        if reponse.find(mot)!=-1:
            if reponse.find("!")!=-1:
                 depart = random.randint(0,len(liste_exclamation)-1)
                 reponse = input(liste_exclamation[depart]%(mot))
            else: 
                
                depart = random.randint(0,len(reponse_depart)-1)
                reponse = input(reponse_depart[depart]%(mot))
    if reponse.find("?")!=-1:
        depart = random.randint(0,len(reponse_autre)-1)
        reponse = input(reponse_autre[depart])
    
    else: 
        depart = random.randint(0,len(reponse_fin)-1)
        reponse = input(reponse_fin[depart])
        
                
