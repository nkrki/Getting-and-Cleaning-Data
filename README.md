# Getting-and-Cleaning-Data

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Files in this repo
README.md - Steps in the code
CodeBook.md - Variables Description
run_analysis.R - R code

run_analysis.R Steps
Set file url and setting the working directory
Check if the file exists and if not, downloading and unzipping it
Read Test Data and  column bind to get complete set
Read Train Data and column bind to get complete set; row bind both training and test data
Reading features, extracting only mean and std; then reading those rows in data
Reading Activity Labels and merging it with Mean and Std Data
Setting Column Names close to Standards
Taking Mean and Writing to a Separate File to submit a Tidy File
