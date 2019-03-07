# GettingCleaningDataProject

## Purpose of this project
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set.

Analysis files
- CodeBook.md contains the details of the fields used in project
- run_analysis.R contains the script on downloading the data to creating a tidy data set

## Source

The source of the original data is located in the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Process:

Script run_analysis.R will download the original data, clean up, and produce a tidy data sets:

- Original data is downloaded to the directory and unzipped.
- Data files are read and assigned with readible field names.
- Two sets of data are created - TrainData and TestData - by combining the columns from different data files.
- TrainData and TestData will then be combined into a data set.
- The data set is then merged with the Activity Labels table by the Activity key.
- Column names for merged data is also renamed for easier understanding.
- Unncessary column is removed and columns are rearranged.
- Lastly, tidy data set is created in tidydata.txt file.
