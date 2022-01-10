
import sys
import pandas as pd
import os
import numpy as np

if len(sys.argv) == 0:
    exit()
else:
    readfile = pd.read_csv(sys.argv[1])

def TreeHeight(degrees,distance):
    radians = degrees * np.pi / 180
    height = distance * np.tan(radians)
    return(height)
        
readfile["Tree.Height.m"] = TreeHeight(readfile["Angle.degrees"], readfile["Distance.m"])

name = os.path.splitext(os.path.basename(sys.argv[1]))[0]

readfile.to_csv("../results/"+name+"_treeheight.csv", sep=" ", index=False)
