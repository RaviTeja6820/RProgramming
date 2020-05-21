#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# set path of working directory
path <- getwd()

#load libraries

library(dplyr)
library(data.table)

# Load activity labels + features

activityLabels <- fread(file = file.path(path, "UCI HAR Dataset/activity_labels.txt"), col.names = c("activity_id", "activity"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), col.names = c("feature_id", "features"))
featuresNeeded <- grep("(mean|std)", features[, features])
allNames <- features[featuresNeeded, features]
allNames <- gsub('[()]', '', allNames)

# Load train datasets

trainX <- fread(file = file.path(path, "UCI HAR Dataset/train/X_train.txt"))
trainX <- trainX[, featuresNeeded, with = FALSE]
setnames(trainX, colnames(trainX), allNames)
trainingActivity <- fread(file = file.path(path, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
subjectNum <- fread(file = file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("Subject_Num"))
trainX <- cbind(subjectNum, trainingActivity, trainX)

# Load test datasets

testX <- fread(file = file.path(path, "UCI HAR Dataset/test/X_test.txt"))
testX <- testX[, featuresNeeded, with = FALSE]
setnames(testX, colnames(testX), allNames)
testActivity <- fread(file = file.path(path, "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
testSubject <- fread(file = file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("Subject_Num"))
testX <- cbind(testSubject, testActivity, testX)

# merge data

combinedData <- rbind(trainX, testX)

# modify the combined data 

combinedData[["Activity"]] <- factor(combinedData[, Activity], levels = activityLabels[["activity_id"]], labels = activityLabels[["activity"]])
combinedData[["Subject_Num"]] <- as.factor(combinedData[, Subject_Num])

# Melt and Dcast data 

combined <- combinedData
combinedMelt <- melt(combined, id = c("Subject_Num", "Activity"), measure.vars = c(3:ncol(combined)))
combinedCast <- dcast(combinedMelt, Subject_Num + Activity ~ variable, fun.aggregate = mean)

# Result Average Data for each Subject and Activity

tidyData <- combinedCast
