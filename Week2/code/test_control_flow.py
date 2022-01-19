#!/usr/bin/env python3

"""Based on control_flow.py with added doctest."""

__appname__ = '[test_control_flow.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

#imports
import sys
import doctest #Import doctest module

#functions
def even_or_odd(x=0):
    """Find whether a number x is even or odd.
      
    >>> even_or_odd(10)
    '10 is Even!'
    
    >>> even_or_odd(5)
    '5 is Odd!'
    
    whenever a float is provided, then the closest integer is used:    
    >>> even_or_odd(3.2)
    '3 is Odd!'
    
    in case of negative numbers, the positive is taken:    
    >>> even_or_odd(-2)
    '-2 is Even!'
    
    """
    #Define function to be tested
    if x % 2 == 0:
        return "%d is Even!" % x
    return "%d is Odd!" % x

def main(argv): 
    """provide fucntions with arguments"""
    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod() # To run with embedded tests