#!/usr/bin/env python3

"""
Takes DNA sequences as input from a csv file and aligns two DNA sequences. 
The best alignment, along with its corresponding score is then saved in 
align_seqs_results.txt in the results/ directory. 
"""

__appname__ = '[align_seqs.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

#import some mods
import sys
import csv

#open and read csv file
read_seq = []
with open("../data/align_seqs_data.csv", "r") as myfile:
    process_csv = csv.reader(myfile)
    for row in process_csv:
        read_seq.append(row[0])

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(read_seq[0])
l2 = len(read_seq[1])
if l1 >= l2:
    s1 = read_seq[0]
    s2 = read_seq[1]
else:
    s1 = read_seq[1]
    s2 = read_seq[0]
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                # * means matched base and - means base not matched
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)

#save output in resutls/
with open("../results/align_seqs_results.txt", "w") as done:
    done.write("Best alignment: " + str(my_best_align) + "\n" + 
    "Best score: " + str(my_best_score))

def main(argv):
    return my_best_align, my_best_score

if __name__ == '__main__':
    status = main(sys.argv)
    sys.exit(status)