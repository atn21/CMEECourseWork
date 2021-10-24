 #!/usr/bin/env python3

"""Turn the script into a module and added test arguments"""

__appname__ = '[cfexercises1.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.2'
__license__ = "None"

import sys

def foo_1(x=0):
    return x ** 0.5

def foo_2(x=0, y=0):
    if x > y:
        return x
    return y

def foo_3(x=0, y=0, z=0):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x=0):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x=0): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x=0): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo_1(6))
    print(foo_2(4,5))
    print(foo_3(1,2,3))
    print(foo_4(7))
    print(foo_5(9))
    print(foo_6(8))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)