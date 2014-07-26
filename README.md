#README.md
        This is repo for Getting and Cleaning Data course project. 
        It consists of 3 files - this readme, codebook file with variable name mapping and explaining, script file main.r with function for cleaning and saving data - main() and also function for reading serialized dataset.
      I prefer to explain how my code works inside of my code file through comments (i believe it is much more comfortable for readers), so here i put just few general notes:
      * I assume raw data already extracted, and for function main() you need specify folder where raw data extracted and also a path, where script should put serialized tidy data
      * For 2) item in demands list i simply assume, that all variable names, contains "mean" and "std" substring are what we need.
      * Tidy data represents a list with two elements [Activity, Subject] - matrices with labeled dims, contained  averaged data respectively by Activity type and num of a Subject. 
      * I had to put this, mostly different tables, into one list, cause of Coursera uploader limits, i also forced to append a .txt extension for in-fact .gz files =)
