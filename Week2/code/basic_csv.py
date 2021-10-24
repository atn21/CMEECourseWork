#!/usr/bin/env python3

"""
Reads and writes .csv files. File content is printed as a list, 
stating species name after each row. Some rows from the original file 
is written into a different csv. 
"""

__appname__ = '[basic_csv.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

import csv

# Read a file containing:
# 'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
with open('../data/testcsv.csv','r') as f:
    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("The species is", row[0])

# write a file containing only species name and Body mass
with open('../data/testcsv.csv','r') as f:
    with open('../data/bodymass.csv','w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])