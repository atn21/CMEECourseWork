#!/usr/bin/env python3

"""
Save files for later use with pickle
"""
__appname__ = '[basic_io3.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'


#############################
# STORING OBJECTS
#############################

#create a dictionary
my_dictionary = {"a key": 10, "another key": 11}

# To save an object (even complex) for later use
import pickle

f = open('../sandbox/testp.p','wb') ## note the b: accept binary files
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f = open('../sandbox/testp.p','rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)
