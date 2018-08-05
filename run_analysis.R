## Download the data.
if(!file.exists("./data")){dir.create("./data")}
   fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(fileUrl,destfile="./data/Dataset.zip")
## Unzip dataSet to /data directory
   unzip(zipfile="./data/Dataset.zip",exdir="./data")

## 1. Merges the training and the test sets to create one data set.
## Reading trainings tables
   x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
   y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
   subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
## Reading testing tables
   x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
   y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
   subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
## Reading feature vector
   features <- read.table('./data/UCI HAR Dataset/features.txt')
## Reading activity labels
   activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
   colNames <- colnames(setAllInOne)
   mean_and_std <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
                 )
   setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names.
   setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
   secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
   write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
