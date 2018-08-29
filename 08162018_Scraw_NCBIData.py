#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 25 11:24:41 2018

@author: imb-n420-cll
"""
#Through R, prepare medgen ID list, without duplicate

import csv
import requests
from bs4 import BeautifulSoup
import pandas as pd
import time

IDS = '08012018_DiseaseIDS.csv'
IDSFile =  open(IDS)
IDSRead = csv.reader(IDSFile)
IDSlist_raw = list(IDSRead)
IDSlist=[None] * (len(IDSlist_raw)-1)
for i in range(1, len(IDSlist_raw)):
  IDSlist[(i-1)] = IDSlist_raw[i][0]

IDSFrame_raw = {'ID':[None]*len(IDSlist), 'Name':[None]*len(IDSlist), 'Synonym':[None]*len(IDSlist), 'Note':[None]*len(IDSlist)}
IDSFrame = pd.DataFrame(IDSFrame_raw)

medgen_url =  'https://www.ncbi.nlm.nih.gov/medgen/?term='
medgen_url_rep = 'https://www.ncbi.nlm.nih.gov/medgen/'

# Because some of medgen ID linked to more than one result, after first test the loop, found six of ID in our list
# has this problem. And First test of loop do not be saved
# Directly seperate the ID to second loop 

medgen_rescue = [20, 232, 594, 712, 777, 885]
medgen_replace = ['2881', '82769', '343087','370651','416688', '468639' ]

#Use loop to screw down detail information and extract information by using BeautifulSoup
#Use Pandas to save table

for i in range(0,(len(IDSlist))):
    if  i in medgen_rescue:
        URL = medgen_url_rep + medgen_replace[medgen_rescue.index(i)]
        response = requests.get(URL)
        soup = BeautifulSoup(response.content, "html.parser")
        IDSFrame['ID'][i] = IDSlist[i]
        IDSFrame['Name'][i]=soup.div.find(attrs = "MedGenTitleText").text
        IDSFrame['Synonym'][i]=soup.table.tr.text
        IDSFrame['Note'][i]=soup.title.text
    else:
        URL = medgen_url + IDSlist[i]
        response = requests.get(URL)
        soup = BeautifulSoup(response.content, "html.parser")
        if soup.title.text == 'No items found - MedGen - NCBI':
            IDSFrame['ID'][i] = IDSlist[i]
            IDSFrame['Name'][i]='NA'
            IDSFrame['Synonym'][i]='NA'
            IDSFrame['Note'][i]='Not Found'
        else:
           IDSFrame['ID'][i] = IDSlist[i]
           IDSFrame['Name'][i]=soup.div.find(attrs = "MedGenTitleText").text
           IDSFrame['Synonym'][i]=soup.table.tr.text
           IDSFrame['Note'][i]=soup.title.text
time.sleep(5)

IDSFrame.to_csv('/work/Bioinformatic_Project/ID_Detail.csv', index=False)

## Region Down here is for testing

response = requests.get("https://www.ncbi.nlm.nih.gov/medgen/?term=CN000492")
soup = BeautifulSoup(response.content, "html.parser")

#print(soup.prettify())

print(soup.find_all("meta").find("name"))
print(soup.find("table", name="keywords").text)
test = soup.find("table", attrs="medgenTable").string
