#!/usr/bin/env python3

"""
converted the loop to a list comprehension, and replaced 
the .join with an explicit string concatenation to improve speed of profileme.py
"""

__appname__ = '[profileme2.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""


def my_squares(iters):
    """
    square the inputs
    """
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """
    concatenate inputs
    """
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """
    run my_squares and my_join
    """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")