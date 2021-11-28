#!/usr/bin/env python
# coding: utf-8

# In[168]:


import pandas as pd


# In[169]:


data = pd.read_csv("../data/LogisticGrowthData.csv")
print("Loaded {} columns.".format(len(data.columns.values)))


# In[170]:


print(data.columns.values)


# In[171]:


pd.read_csv("../data/LogisticGrowthMetaData.csv")


# In[173]:


data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)


# In[183]:


len(data.ID.unique())


# In[184]:


pt = data[["ID","Time","PopBio"]]


# In[185]:


import numpy as np


# In[186]:


pt['ID'] = pd.factorize(pt.ID)[0]+1


# In[187]:


pt = pt[pt['Time']  > 0 ]
pt = pt[pt['PopBio']  > 0 ]
pt = pt.groupby(['ID']).filter(lambda x: len(x) > 4)
(pt<0).sum()


# In[188]:


pt['Log_PopBio'] = np.log(pt['PopBio'])


# In[189]:


pt


# In[190]:


pt.to_csv('../data/test_data.csv') 

