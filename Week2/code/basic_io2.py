#!/usr/bin/env python3

"""
uses a for loop to write numbers 0-99 into a .txt file 
with a new line between each number
"""
__appname__ = '[basic_io2.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'

#############################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end

f.close()
