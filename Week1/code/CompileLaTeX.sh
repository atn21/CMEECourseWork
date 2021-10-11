#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: combine .tex and .bib into a single .pdf

# Save output as .pdf file
# Arguments: 1 (.tex file)
# Date: Oct 2021

fbname=$(basename "$1" .tex)
if [ -z "$fbname" ] 
then 
    echo 'Missing inputs please enter a .tex file'
    exit 0 
fi

echo "Creating pdf with bibliography included"
pdflatex $fbname
bibtex $fbname
pdflatex $fbname
pdflatex $fbname
mv $fbname.pdf ../results
evince ../results/$fbname.pdf &

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

exit

