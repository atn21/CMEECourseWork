#!/usr/bin/env python3

"""Loops and conditionals"""

__appname__ = '[cfexercises2.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

# prints 4 hellos
for j in range(12):
    if j % 3 == 0:
        print('hello')

# prints 5 hellos
for j in range(15):
     if j % 5 == 3:
        print('hello')
     elif j % 4 == 3:
        print('hello')

# prints 5 hellos
z = 0
while z != 15:
    print('hello')
    z = z + 3

# prints 8 hellos
z = 12
while z < 100:
    if z == 31:
        for k in range(7):
            print('hello')
    elif z == 18:
        print('hello')
    z = z + 1