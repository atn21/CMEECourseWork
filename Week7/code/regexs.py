

import re

my_string = "a given string"

#Find a space in the string:
match = re.search(r'\s', my_string)
print(match)

#To see the match, use:
match.group()

#find numbers in the string:
match = re.search(r'\d', my_string)
print(match)

#To know whether a pattern was matched, we can use an if:
MyStr = 'an example'

match = re.search(r'\w*\s', MyStr) #find chracter that is followed by white space

if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')    

#some more regexes
match = re.search(r'2' , "it takes 2 to tango")
match.group()

match = re.search(r'\d' , "it takes 2 to tango")
match.group()

match = re.search(r'\d.*' , "it takes 2 to tango")
match.group()

match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group()

match = re.search(r'\s\w*$', 'once upon a time')
match.group()

#directly returning the matched group 
# (by directly appending .group() to the result).
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()
re.search(r'^\w*.*\s', 'once upon a time').group() # 'once upon a '

#*, +, and { } are all “greedy”: They repeat the previous regex token as many times as possible.
#As a result, they may match more text than you want. 
#To make it non-greedy and terminate at the first found instance of a pattern, use ?:
re.search(r'^\w*.*?\s', 'once upon a time').group()

#To further illustrate greediness in regexes, let’s try matching an HTML tag:
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()

#Because + is greedy, we can make + “lazy” and output will be just <EM>
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

#put an extra \ before . to be able to find a literal .
re.search(r'\d*\.?\d*','1432.75+60.22i').group()
#A couple more examples:
re.search(r'[AGTC]+', 'the sequence ATTCGT').group()
re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()

# look for email addresses in a string
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and \
    ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+", MyStr) #[\w\s] ensures that any combination of word characters and spaces is found.
match.group()

#make the email address part of the regex more robust:
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()

# group regex patterns
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and \
    ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()

# without grouping regex
match.group(0)

#group regex patterns into meaningful blocks using parentheses
match = re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)",MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))

#re.search() find the first match for a pattern. 
#re.findall() find all the matches of a pattern, 
# returns all matches as a list of strings, 
# with each string representing one match.
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) 
for email in emails:
    print(email)

#apply regex searches to whole file
f = open('../../Week2/Data/TestOaksData.csv', 'r')
found_oaks = re.findall(r"Q[\w\s].*\s", f.read()) #f.read() returns the whole text of a file in a single string. Also, the file is closed after reading.
found_oaks

#use re.findall() to find multiple matches
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"

found_matches = re.findall(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+)", MyStr)
found_matches

for item in found_matches:
    print(item)

#extracting text from a web page
import urllib3  

conn = urllib3.PoolManager() # open a connection
r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/') 
webpage_html = r.data #read in the webpage's contents

#This is returned as bytes (not strings).
type(webpage_html)

#So decode it (remember, the default decoding that this method applies is utf-8):
My_Data  = webpage_html.decode()
#print(My_Data)

#Let’s extract all the names of academics:
pattern = r"Dr\s+\w+\s+\w+"
regex = re.compile(pattern) # example use of re.compile(); you can also ignore case  with re.IGNORECASE 
for match in regex.finditer(My_Data): # example use of re.finditer()
    print(match.group())

#replace text:
New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
# print(New_Data)