#!/usr/bin/env python3

"""
birds is a tuple of tuples of length three: latin name, common name, mass.
write a (short) script to print these on a separate line or 
output block by species 
"""

__appname__ = '[tuple.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

#loop through the list to print latin name, common name, mass
for b in birds:
    print("Latin name; " + b[0])
    print("Common name: " + b[1])
    print("Mass: " + str(b[2]) +"\n")
