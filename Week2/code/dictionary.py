#!/usr/bin/env python3

"""
Script populates a dictionary called taxa_dic derived from taxa so 
that it maps order names to set of taxa.
"""

__appname__ = '[dictionary.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

## Imports ##
import sys


taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

def dict(x=taxa):
        taxa_dic = {}
        for n,t in x:
                if t in taxa_dic:
                        taxa_dic[t].append(n)
                else:
                        taxa_dic[t] = [n]
        print(taxa_dic)

def main(argv):
        dict(taxa)
        return 0

if (__name__ == "__main__"):
        status = main(sys.argv)
        sys.exit(status)