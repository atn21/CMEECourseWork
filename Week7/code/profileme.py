#!/usr/bin/env python3

"""
profile code to locate the sections of your code where speed bottlenecks are present
"""

__appname__ = '[profileme.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

def my_squares(iters):
    """
    square the inputs
    """
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """
    concatenate inputs
    """
    out = ''
    for i in range(iters):
        out += string.join(", ")
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