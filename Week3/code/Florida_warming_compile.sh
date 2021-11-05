#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: combine .tex and .bib into a single .pdf

# Save output as .pdf file
# Arguments: 1 (.tex file)
# Date: Oct 2021

#compile latex file
#pdflatex Florida_warming.tex
#bibtex Florida_warming
#pdflatex Florida_warming.tex
#pdflatex Florida_warming.tex
latexmk -pdf
latexmk -C

## Cleanup
#rm *.aux
#rm *.log
#rm *.bbl
#rm *.blg

exit

