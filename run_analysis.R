library(dplyr)

# Unzip the zip file
if(!file.exists("./UCI HAR Dataset")) {
    print("Unzipping ....")
    unzip(zipfile = "./getdata_projectfiles_UCI HAR Dataset.zip")
} else {
    print("The zip file already has been unzipped")
}


# Reading the data 

# Path of dataset
pathdataset <- file.path(getwd(),"UCI HAR Dataset") 

# X train dataset
Xtrain <- read.table(file.path(pathdataset,"train","X_train.txt"), header = FALSE)
Ytrain = read.table(file.path(pathdataset, "train", "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(pathdataset, "train", "subject_train.txt"),header = FALSE)

# Y train dataset
Xtest = read.table(file.path(pathdataset, "test", "X_test.txt"),header = FALSE)
Ytest = read.table(file.path(pathdataset, "test", "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(pathdataset, "test", "subject_test.txt"),header = FALSE)

# Features and activityLabels
features = read.table(file.path(pathdataset, "features.txt"),header = FALSE)
activityLabels = read.table(file.path(pathdataset, "activity_labels.txt"),header = FALSE)




# 4.-Appropriately labels the data set with descriptive variable names. 
# Tagging the test and train data set, and activity labels
colnames(Xtrain) <- features[,2]
colnames(Ytrain) = "activityId"
colnames(subject_train) = "subjectId"
colnames(Xtest) = features[,2]
colnames(Ytest) = "activityId"
colnames(subject_test) = "subjectId"
colnames(activityLabels) <- c('activityId','activityType')


# 1.- Merges the training and the test sets to create one data set.

# Concatenating vertically the train train 
merge_train <- cbind(Ytrain,subject_train,Xtrain)
# Concatenating vertically the test data
merge_test <- cbind(Ytest,subject_test,Xtest)
# merging the two merged (merge_train and merge_test) data horizontally
merge_data <- rbind(merge_train,merge_test)


# 2.- Extracts only the measurements on the mean and standard deviation for each measurement. 

# Getting the columns names of merge_data
colNames <- colnames(merge_data)

# Getting the indexes of column variable names with mean ad standar deviation
# and theirs respective activityId and subjectId
indexes_mean_sd = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean" , colNames) | grepl("std" , colNames))

mean_sd_measurements <- merge_data[,indexes_mean_sd]


# 3.- Uses descriptive activity names to name the activities in the data set

merge_mean_sd_measurement <- merge(mean_sd_measurements, activityLabels, by="activityId", all.x = TRUE)


# 5.- From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.

# Building the new tidy data set
avgTidySet <- merge_mean_sd_measurement %>%
    group_by(subjectId, activityId) %>%
    summarise_all(funs(mean))

# Saving the new tidy dataset
write.table(TidyData, "TidyData.txt", row.name=FALSE)
