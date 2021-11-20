#!/usr/bin/env python3

"""
use scipy and numpy for statistics in python. use matplotlib to plot graphs
"""

__appname__ = '[LV1.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p

def dCR_dt(pops, t=0):
    """
    this function returns the growth rate of consumer 
    and resource population at any given time step
    """
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    return np.array([dRdt, dCdt])

# assign some parameter values
r = 1.
a = 0.1 
z = 1.5
e = 0.75

#Define the time vector; let’s integrate from time point 0 to 15, using 1000 sub-divisions of time:
t = np.linspace(0, 15, 1000)

#Set the initial conditions for the two populations (10 resources and 5 consumers per unit area), 
# and convert the two into an array (because our dCR_dt function take an array as input).

R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])

#Now numerically integrate this system forward from those starting conditions:
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops

#chech what is infodict
type(infodict)

# check what’s in infodict
infodict.keys()

#check if integration was successful
infodict['message']

#plot Consumer-Resource population dynamics over time
f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resource density') 
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
f1.savefig('../results/LV_model1.pdf') #Save figure

#plot Consumer vs Resource density
f2 = p.figure()
p.plot(pops[:,0], pops[:,1], 'r-') 
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
f2.savefig('../results/LV_model2.pdf') #Save figure