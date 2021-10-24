#!/usr/bin/env python3

"""
__name__ == '__main__':
The special __name__ variable is set to have a value __main__, so that 
the file is usable as a script as well as an importable module.
"""

__appname__ = '[using_name.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

#functions

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is: " + __name__)