#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: master MiniProject script that runs everything
# Arguments: none
# Date: Dec 2021

# run exploration.py
python3 -W ignore data_prep.py

# run model fitting and analysis script
Rscript --no-echo model_fitting.R 

# compile LaTeX file
latexmk -pdf
mv miniproject.pdf ../results
latexmk -C
rm *.bbl

echo -e "!!!!!!!!ANALYSIS COMPLETE!!!!!!!"