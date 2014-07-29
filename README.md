#README.md
==============

This is repo for Getting and Cleaning Data course project.

It consists of 3 files - this readme, codebook file with variable name mapping and explaining, script file main.r with function for cleaning and saving data - main() and also function for reading serialized dataset.
      I prefer to explain how my code works inside of my code file through comments (i believe it is much more comfortable for readers), so here i put just few general notes:
* I assume raw data already extracted, and for function main() you need specify folder where raw data extracted and also a path, where script should put serialized tidy data
* For 2) item in demands list i simply assume, that all variable names, contains "mean" and "std" substring are what we need.
* Tidy data, returned by main() represents a list with two elements [Activity, Subject] - matrices with labeled dims, contained  averaged data respectively by Activity type and num of a Subject. 
* I had to put this, mostly different tables, into one list, cause of Coursera uploader limits, i also forced to append a .txt extension for in-fact .gz files =)

##Note after beginning of peer evaluation
I looked to others peers works and understood, that my vision of 6) item in demands list is completely different from what i've seen in others works. Maybe i should been ask a question on forum about meaning of this item, but let me explain my reasoning. I assume that Subject, Activity - is qualitive variables, others are quantitive variables, but they are all **VARIABLES**. And when you've been asked to average **ALL VARIABLES** for each Subject and each Activity, it means exactly what i did - averaging data for all quantitive variables divided by one of qualitive variables and just ignoring the other qualitive variable(imho, ignoring in case of qualitive variable is averaging, because for qualitive variables *averaging* or *dividing* operation makes no sense). 
