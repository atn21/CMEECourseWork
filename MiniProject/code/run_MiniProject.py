import pandas as pd
import scipy as sc
import matplotlib.pylab as pl
import seaborn as sns

data = pd.read_csv("../data/LogisticGrowthData.csv")
print("Loaded {} columns.".format(len(data.columns.values)))
print(data.columns.values)
pd.read_csv("../data/LogisticGrowthMetaData.csv")
data.head()