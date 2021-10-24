#!/usr/bin/env python3
"""
The function has a written-in error. *pdb* was used to detect the bug. 
"""

__appname__ = '[debugme.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"


def buggyfunc(x):
    """Function contains an error"""
    y = x
    for i in range(x):
        #Fix the bug with except and try
        try: 
            y = y-1
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work; x = {x}; y = {y}")
        else:
            print(f"OK; x = {x}; y = {y}, z = {z};")
    return z

buggyfunc(20)