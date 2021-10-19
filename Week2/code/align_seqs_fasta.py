#!/usr/bin/env python3

import sys

if len(sys.argv) == 3:
    with open(sys.argv[1], "r") as sfile1:
        seq1 = sfile1.readlines()
        seq1 = [line.rstrip() for line in seq1]
    with open(sys.argv[2], "r")  as sfile2:
        seq2 = sfile2.readlines()
        seq2 = [line.rstrip() for line in seq2]
else:
    with open("../../Week1/data/407228412.fasta", "r") as dfile1:
        seq1 = dfile1.readlines()
        seq1 = [line.rstrip() for line in seq1]
    with open("../../Week1/data/407228326.fasta", "r") as dfile2:
        seq2 = dfile2.readlines()
        seq2 = [line.rstrip() for line in seq2]

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"
    return score
    return matched

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i , s2 # think about what this is doing!
        my_best_score = z 

with open("../../Week2/results/align_seqs__fasta_results.txt", "w") as done:
    done.write("Best score: " + str(my_best_score) + "\n" + 
    "Best align: " + str(my_best_align))