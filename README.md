# Getting and Cleaning Data - Week 4 Course Project

Completed May 12, 2018

The purpose of this project is to prepare a tidy data set that can be used for later analysis.
This file describes the steps taken to achieve this goal. 

## Getting Started


The data for this project come from accelerometers from the Samsung Galaxy S smartphone collected from a group of 30 volunteers within an age bracket of 19-48 years.

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing the smartphone on their waist.
Using the phone's embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The data files and accompanying text files describing the experiment in more detail can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Set Info

The data set includes the following files: 

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 

Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using 
another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, 
fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

 
## Script Info

The dplyr, reshape2 and tidyr packages need to have been installed for this script to work.

### Step 1: Merge the training and test data

Read in all data sets listed above. 
Create 'test' and 'train' data sets by combining subject, y and X raw datasets using cbind() function.
Create 'merged_dat' data set by combining 'test' and 'train' using the rbind() function.
* test and train datasets had identical columns, so merging would be the equivalent of using rbind() *

### Step 2: Assign descriptive variable names

Using features.txt vector for variables coming from the X raw dataset.
Manually assigning "subjectID" and "activitylevel" to first two variables.

### Step 3: Assign descriptive activity names to the activity levels 1-6

By first renaming variables in activity_levels to both be more descriptive and to match the "activitylevel" variable in merged_dat to to aid in merging the two data sets
Then use merge to match up descriptive activity names to the activity levels
Only "activitylevel" variable is in both datasets so specifying "by" in the merge argument is unnecessary

### Step 4: Extract only the mean and standard deviation for each measurement

Using general expession for finding the strings "std" and "mean" immediately followed by "(" and keeping the subjectID and activityname columns

### Step 5: Take the average of each variable for each activity and each subject.

First using gather function to put the data into long form.
Then, using tapply with the factors equal to subjectID, activityname, and the name of the measurement


### Step 6: Create tidy dataset and write to a text file

tapply produces a list, so using melt from reshape2 to put the data back into long form.
