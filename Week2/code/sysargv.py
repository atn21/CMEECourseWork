#!/usr/bin/env python3

"""
argv - 'argument variable' in python
"""
__appname__ = '[sysargv.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

#import
import sys

#functions
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))