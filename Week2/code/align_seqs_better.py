#!/usr/bin/env python3

"""
Takes the DNA sequences from two (user input or default) files
and saves all alignments with the highest score in a text file.
"""

__appname__ = '[align_seqs_better.py]'
__author__ = 'An (an.nguyen21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = ""

#imports
import sys
import pickle
import sys


def read_seq(userinput):
    """Take inputs"""
    with open(userinput, "r") as process:
        sequence = process.readlines()
        sequence = [line.rstrip('\n') for line in sequence[1:]]
        sequence = "".join(sequence)
    return sequence

#process user inputs
if len(sys.argv) == 3:
    seq1 = read_seq(sys.argv[1])
    seq2 = read_seq(sys.argv[2])

#if no user, process default files    
else:
    seq1 = read_seq("../../Week1/data/407228412.fasta")
    seq2 = read_seq("../../Week1/data/407228326.fasta")

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
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

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1
save = []

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z
        save.append((my_best_align, my_best_score))

#find all alignments with the highest score
max_align_score = max(s[1] for s in save)
max_align_seq = [seq[0] for seq in save if seq[1] == max_align_score]

#use pickle to save and load the best alignments
with open('../sandbox/pickleseq', 'wb') as f:
    pickle.dump(max_align_seq, f)
with open('../sandbox/pickleseq', 'rb') as f:
    best_alignment = pickle.load(f)

#save output in resutls/
with open("../results/align_seqs_better_results.txt", "w") as done:
    done.write("Best score: " + str(max_align_score) + "\n" +
    "Best alignment: " + "\n" + str(best_alignment))