#!/usr/bin/env python3
"""
use the timeit module to figure out 
what is the best way to do something specific 
as part of a larger program
"""

__appname__ = '[timeitme.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

##############################################################################
# loops vs. list comprehensions: which is faster?
##############################################################################

iters = 1000000

import timeit

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

##############################################################################
# loops vs. the join method for strings: which is faster?
##############################################################################

mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join
