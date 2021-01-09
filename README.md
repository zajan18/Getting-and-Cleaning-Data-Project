
# Getting-and-Cleaning-Data-Project

## Content

This repository contains the following files:
1. `README.md`
2. `run_analysis.R`
3. `TidyData.txt`
4. `codebook.md`

## Description

* `run_analysis.R`

This is the course project for Getting and Cleaning Data course from Coursera.

The R Script, `run_analysis.R`, does the following:

1. Download data from the web if it is not already in the working directory.

2. Load measurements data from the train and test text files and merge them.

3. Load the features (variable names for the measurements), and activity data.

4. Create a dataset of mean and std for each measurement.

5. Label the variables and the activity appropriately using features and activity data.

6. Create a tidy dataset, `TidyData.txt` to summarise the average of each variable for each subject and each activity.

* `TidyData.txt`

This is the output from the R Script, `run_analysis.R`, which shows the summary of the average of each variable for each subject and each activity from the data.

* `codebook.md`

This codebook summarises the data fields in the output `TidyData.txt`.
