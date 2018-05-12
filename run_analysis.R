# Load packages needed
library(dplyr)
library(tidyr)
library(reshape2)

## Step 1 - Merge the test and training data sets

# Read in Data -- assuming zip file saved in it's own sub-directory
X_test <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

activity_labels <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")

features <- read.table("~/Coursera/Getting and Cleaning Data/UCI HAR Dataset/features.txt")

# Merge training and test data sets

test <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)

merged_dat <- rbind(test, train, all = TRUE)

## Step 2 - Assign descriptive variable names

names(merged_dat) <- c("subjectID", "activitylevel", as.character(features$V2))

## Step 3 - Assign descriptive activity names to the activity levels 1-6

activity_labels <- rename(activity_labels, activitylevel = V1, activityname = V2) 
merged_dat <- merge(activity_labels, merged_dat)

## Step 4: Extract only the mean and standard deviation for each measurement

# Assuming based on the ReadMe that mean and st dev measurements are those columns denoted by "mean()" and "stdev()", respectively

DF <- merged_dat[,c(2,3,grep("std|mean\\(", names(merged_dat)))]

## Step 5: Create tidy data set 

# Put dataset into long form using "gather" from tidyr package
DF <- gather(DF, Measurement, value = Value, -activityname, -subjectID)

# Use tapply to get average of each variable for each activity and each subject.
summary <- with(DF, tapply(Value, list(subjectID, activityname, Measurement), mean))

## Step 6: Create tidy dataset and write to a text file 

# Put data back into long form using 'melt' function from reshape2 package

tidy <- melt(summary)
names(tidy) <- c("subjectID", "activityname", "measurement", "value")

# Write to text file
write.table(tidy, "tidy.txt", row.names = FALSE, col.names = TRUE)