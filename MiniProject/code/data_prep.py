#!/usr/bin/env python3

"""
Data Wrangling for Population growth data. 
"""

__appname__ = '[data_prep.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

#import mods
import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings("ignore")

#import data
data = pd.read_csv("../data/LogisticGrowthData.csv")

#read data
print("Loaded {} columns.".format(len(data.columns.values)))
print(data.columns.values)
pd.read_csv("../data/LogisticGrowthMetaData.csv")

#set unique ID
data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)

#check how many data sets
len(data.ID.unique())

#filter to only essential columns
pt = data[["ID","Time","PopBio"]]


#set wordy ID to numeric ID
pt['ID'] = pd.factorize(pt.ID)[0]+1

#remove negative values and subsets with length less than 5
pt = pt[pt['Time']  > 0 ]
pt = pt[pt['PopBio']  > 0 ]
pt = pt.groupby(['ID']).filter(lambda x: len(x) > 4)
(pt<0).sum()

#calculate natural log
pt['Log_PopBio'] = np.log(pt['PopBio'])

#save to csv
pt.to_csv('../data/test_data.csv') 