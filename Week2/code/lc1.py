#!/usr/bin/env python3

"""
(1) Write three separate list comprehensions that create three different
lists containing the latin names, common names and mean body masses for
each species in birds, respectively. 
(2) Now do the same using conventional loops (you can choose to do this 
before 1 !). 
"""

__appname__ = '[lc1.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )
#Three separate list comprehensions that create three different
#lists containing the latin names, common names and mean body masses for
#each species in birds, respectively. 

#list comprehension for latin names
latin_compre = [b[0] for b in birds]
print(latin_compre)

#list comprehension for common names
common_compre = [b[1] for b in birds]
print(common_compre)

#list comprehension for mean body mass
mean_compre = [b[2] for b in birds]
print(mean_compre)

#A super loop for creating three different lists containing the latin 
# names, common names and mean body masses for each species in birds, 
# respectively.
latin_loop = []
common_loop = []
mean_loop = []
for b in birds:
    latin_loop.append(b[0])
    common_loop.append(b[1])
    mean_loop.append(b[2]) 
print(latin_loop)
print(common_loop)
print(mean_loop)