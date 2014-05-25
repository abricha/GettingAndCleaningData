### Overview

The run_analysis.R script is developed with the purpose to read in the data  captured through acceleromator and gyroscope sensors in the Samsung Galaxy II phone captured for various activities (walking, walking upstairs, waling downstairs, sitting, laying, laying for some 30 subjects. The script reads in in the UCI HAR Dataset, merge it, extract the mean and stand deviation measures, transforms it, and finally produces a tidy data set in an output file.
The data set can be found in:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) 


### Assumptions
The script first looks for a directory named UCI HAR Dataset to read in the data and if not found, it will look for the getdata_projectfiles_UCI HAR Dataset.zip file and unzip it. If neither the directory nor the zip file is found, the script will error out with an informative message.The script is expected to be run in a working directory containing the UCI HAR Dataset directory.

### Required packages
The "reshape2" package is required for this script to run. This package includes the melt() and dcast() functions used in the script to manipulate the data and make it tidy.

### Reading the necessary files for the analysis
The script will read in the following files into separate data frames:

- UCI HAR Dataset/train/X_train.txt         (file containing 561 measures of the training set)
- UCI HAR Dataset/train/y_train.txt         (file containing the activity label id's of the training set)
- UCI HAR Dataset/train/subject_train.txt   (file containing the subjects' id's in the training set)
- UCI HAR Dataset/test/X_test.txt           (file containing 561 measures of the test set)
- UCI HAR Dataset/test/y_test.txt           (file containing the activity label id's of the test set)
- UCI HAR Dataset/test/subject_test.txt     (file containing the subjects' id's in the test set)
- UCI HAR Dataset/features.txt              (file containing the 561 variable names for the 561 measures) 


### Merging the data frames into one master data frame
1. merge the subject id's data frames into one data frame using rbind
2. merge the activity id's data frames into one data frame using rbind
3. merge the measures data frames into one data frame using rbind
4. finally merge the data frames in #1,2,3 into one master data frame using cbind
5. the last step is to name the columns in the master data set by assigning the variable names in the features.txt to the measures and assigning "subject" to the column containing the subject id's and assigning "activity" to the column containing the activity id's.

The resulting master data frame has one column containing the subject id's, one column containing the activity label id's and some 561 columns containing measures. each row represents 561 measures taken for one subject during a particular activity. Note: rows are not unique; the same measures are captured for the same subject and the same activity multiple times.

### Extract only the mean and standard deviation for each measurement
The script grabs the mean and standard deviation for each measure using regular expressions. The script will look for the literals "std" and "mean" both in upper and lower case followed by the bracket metacharacters "()". In essence, the list of all variable names containing mean(), std() with all or some of the letters in upper/lowercase would be stored in a new vector. This new vector is then used to subset the master data frame while keeping the subject and activity columns.

### Use descriptive activity names to name the activities in the data set
The script replaces the activity label id's (1 through 6) by explicit descriptive names and then sets the "activity" column values to factors as recommended for tidy data sets.

- activity label id = 1 is replaced by the string "WALKING"
- activity label id = 2 is replaced by the string "WALKING_UPSTAIRS"
- activity label id = 3 is replaced by the string "WALKING_DOWNSTAIRS"
- activity label id = 4 is replaced by the string "SITTING"
- activity label id = 5 is replaced by the string "STANDING"
- activity label id = 6 is replaced by the string "LAYING"

### Appropriately labels the data set with descriptive activity names.
The following steps are taken to make the variable names english-like and more descriptive. I used CamelCase (uppercase the first letter in every subsequent word to make names more easily readable. example: "timeGravityAcceleratorMagnitudeStd" instead of "timegravityacceleratormagnitudestd"

1. Replace the t in beginning of a measure variable (feature) to "time"
1. Replace the f in beginning of a measure variable (feature) to "frequency"
1. Remove the word body duplicates in the same var
1. Replace acc with Accelerometer
1. Replace mag with Magnitude
1. Replace gyro with Gyroscope
1. Remove dash and CamelCase the next letter
1. Remove parentheses
1. Replace the X at end of the variable name with XAxis
1. Replace the Y at end of the variable name with YAxis
1. Replace the z at end of the variable name with ZAxis


### Calculate the mean for each measure for each activity and each subject 

1. using the melt function, tscript melts the shrinked data set into long format with 4 columns: subject, activity, variable, values. The variable column contains all measures and the values column contains the value for each measure/subject/activity
1. using the dcast function, the script calculates the mean and aggregates it of each measure/subject/activity and turns the data frame back into wide format to end up with a tidy data frame with 180 rows. Each row contains the mean of each measure aggregated for each subject and activity.

### Write the tidy data set to a text file tab delimited
Finally, the script writes the tidy data frame into a text file called tidy.data.txt that is tab delimited and is placed within the UCI HAR Dataset directory.
