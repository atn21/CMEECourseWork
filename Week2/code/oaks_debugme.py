#!/usr/bin/env python3

"""
Debug by writing doctests, where the bug prevents oaks from being found
"""

__appname__ = '[oaks_debugme.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

#imports
import csv
import sys
import doctest
import re

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Querrcus robur')
    False
    >>> is_an_oak('Quercus robur')
    True
    >>> is_an_oak('Quercuss robur')
    False
    """
    return True if re.search(r"\bquercus\b", name, re.IGNORECASE) else False

def main(argv): 
    """
    Opens and reads TestOaksData.csv, opens JustOaksData.csv for writing
    Only if species in TestOaksData.csv are from the genus "Quercus" are 
    included in JustOaksData.csv.
    """
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    next(f, None)
    csvwrite = csv.writer(g)
    csvwrite.writerow(['Genus', 'Species'])
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])
    f.close()
    g.close()

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

#run doctest
doctest.testmod()