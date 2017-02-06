# Problem Statement

This is a Course Project for Getting and Cleaning Data Course. 
The task was to create one R script that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data for the project can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
and should be saved in the current working directory.

# Solution

This repo contains following files: run_analysis.R, CodeBook.md

## run_analysis.R 
The file contains script representing the solution and doing the following steps:

1. Reads the source data from the current working directory.
2. Changes duplicated feature names since it causes an error in selecting columns.
3. Merges all the data into one big data set with descriptive variable names. 
4. Selects columns corresponding to mean and standard deviation measurement searching them by name mask.
5. Creates the **data_average** data set with mean values of the columns grouped by activity and subject and writes it into the data_average.txt file. 

Prior to running the script the run_analysis.R file should be saved in the current working directory and the dplyr package should be installed:
```
install.packages("dplyr")
```
The result is data_average.txt file.

## CodeBook.md
The file contains the description of the data set varibles in the data_average.txt file.


