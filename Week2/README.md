# Week 2 Coursework 

## Contents
* code: contains the python programs of this week. Find detailed content list below. 
* data: contains the data for the programs. Find detailed content list below.
* results: contains the output of the programs. Currently empty. 
* sandbox: contains miscellaneous files generated when testing the code. Nothing important.

## Requirements

Python 3.8.10

Python Modules: 
* pickle
* re
* csv
* sys
* doctest

## List of scripts
### 1. basic_io1.py

Open test.txt from Week2/sandbox and loop through all lines in the file.

### 2. basic_io2.py

Uses a for loop to write numbers 0-99 into a .txt file with a new line between each number.

### 3. basic_io3.py

Save files for later use with **pickle**.

### 4. basic_csv.py

Reads and writes .csv files. File content is printed as a list, stating species name after each row. Some rows from the original file is written into a different csv. 

### 5. cfexercises1.py

Mathematical functions with different conditionals. Main function test all mathematical functions on sample arguments.

### 6. loops.py

A .py script to practice various for and while loops.

### 7. cfexercises2.py

Contain loops and conditionals.

### 8. oaks.py

Finds taxa that are oak trees from a list of species using list comprehension and loops.

### 9. scope.py

Demonstrate the difference between global and local variable.

### 10. boilerplate.py

A basic boilerplate python program.

### 11. using_name.py

The special __name__ variable is set to have a value __main__, so that the file is usable as a script as well as an importable module.

### 12. sysargv.py

Assigns different variables to **sys.argv**.

### 13. control_flow.py

Shows the use of control statements, example arguments are also included.

### 14. lc1.py

Contains list comprehensions and loops to print different attributes of birds.

### 15. lc2.py

Contains list comprehensions and loops to identify months with high and low rainfall.

### 16. dictionary.py

Populates a dictionary called taxa_dic derived from taxa the list so that it maps order names to sets of taxa.

### 17. tuple.py

Data in the bird tuple are printed into separate list using loop.

### 18. test_control_flow.py

Based on control_flow.py with added doctest.

### 19. debugme.py

The function has a written-in error. *pdb* was used to detect the bug. 

### 20. align_seqs.py

Takes DNA sequences as input from a csv file and aligns two DNA sequences. The best alignment, along with its corresponding score is then saved in the results/ directory.

### 21. align_seqs_fasta.py

Takes the DNA sequences from two (user input or default) fasta files and saves the best alignment along with the corresponding score in a single text file.

### 22. align_seqs_better.py

Takes the DNA sequences from two (user input or default) files and saves all alignment with the highest score into a text file.

### 23. oaks_debugme_grp.py

A bug prevents oaks from being found. The program is then debuged with doctest.

## Author

An Nguyen

## Licensing

None

