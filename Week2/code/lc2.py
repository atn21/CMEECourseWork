# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

def rainmore100(hundred):
    if hundred > 100:
        return hundred

def rainless50(fifty):
    if fifty < 50:
        return fifty

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
greater_than_100_compre = [r for r in rainfall if rainmore100(r[1])]
print(greater_than_100_compre)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 
less_than_50_compre = [r for r in rainfall if rainless50(r[1])]
print(less_than_50_compre)

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 
greater_than_100_loop = []
less_than_50_loop = []
for r in rainfall:
    if rainmore100(r[1]):
	    greater_than_100_loop.append(r)
    if rainless50(r[1]):
	    less_than_50_loop.append(r)
print(greater_than_100_loop)
print(less_than_50_loop)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

