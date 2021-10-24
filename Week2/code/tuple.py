#!/usr/bin/env python3

"""
Data in the bird tuple are printed into separate list using loop. 
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
