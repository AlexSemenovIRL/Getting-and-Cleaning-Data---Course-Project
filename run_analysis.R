rm(list = ls())
library(data.table)
setwd("C:/Users/asemenov/Desktop/Getting and Cleaning Data - Course Project")
filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")}  
if (!file.exists("UCI HAR Dataset")) {unzip(filename)}

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
my_features <- read.table("UCI HAR Dataset/features.txt")
my_features[,2] <- as.character(my_features[,2])

# Get mean and standard deviation from the data
NeededFeatures <- grep(".*mean.*|.*std.*", my_features[,2])
NeededFeatures.names <- my_features[NeededFeatures,2]
NeededFeatures.names = gsub('-mean', 'Mean', NeededFeatures.names)
NeededFeatures.names = gsub('-std', 'Std', NeededFeatures.names)
NeededFeatures.names <- gsub('[-()]', '', NeededFeatures.names)

# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[NeededFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[NeededFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge datasets and add labels
MasterData <- rbind(train, test)
names(MasterData) <- c("subject", "activity", NeededFeatures.names)

# turn activities & subjects into factors
MasterData$activity <- factor(MasterData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
MasterData$subject <- as.factor(MasterData$subject)

MasterData.melted <- melt(MasterData, id = c("subject", "activity"))
MasterData.mean <- dcast(MasterData.melted, subject + activity ~ variable, mean)

write.table(MasterData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
