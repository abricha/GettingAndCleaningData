##Author
abricha

##Credit

This data set was produced based on the Human Activity Recognition Using Smartphones Dataset initially produced by:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.<br>
Smartlab - Non Linear Complex Systems Laboratory <br>
DITEN - Università degli Studi di Genova.<br>
Via Opera Pia 11A, I-16145, Genoa, Italy.<br>
activityrecognition@smartlab.ws<br>
www.smartlab.ws

## Experiment (description taken from the original data set)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 


### The original data
The original data set:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) 

The input files to produce a tidy data set based on the original data set:

- train/X_train.txt: this file contains all the measures captured for each subject in the "train" population while performing the 6  activities       
- train/y_train.txt: this file contains the activity label id's that identifyduring which activity the measures were captured for a particular subject in the train population         
- train/subject_train.txt: this file contains the subject id's in the "train" population that performed the activities mentioned above
- test/X_test.txt: this file contains all the measures captured for each subject in the "test" population while performing the 6  activities          
- test/y_test.txt: this file contains the activity label id's that identifyduring which activity the measures were captured for a particular subject in the "test" population        
- test/subject_test.txt: his file contains the subject id's in the "test" population that performed the activities mentioned above     
- features.txt: This file contains the names of the measures captured. This file is critical to understand the data found in the X_train.txt and X_test.txt as these two files contain the measures and the features.txt file indicates what the measure actually is.              

Note: in the input files, 561 observations were captured for each subject performing an activity, multiple times.

### The tidy data set
The tidy data set was produced through the run_analysis.R script that reads in the input files mentioned above and performs a series of transformations:


1. merges the measures data from the "train" and "test" populations
2. merge the subject data from the "train" and "test" populations
3. merge the activity labels ids from the "train" and "test" populations
4. assign names to all columns in the data frame. The names of the measures come from the features.txt file while the additional "subject" and "activity" columns were assigned a name manually through the script. The combined data looks something likes at this point: (image by David Hood, a TA in the "getting and cleaning data" course on Coursera) ![](https://coursera-forum-screenshots.s3.amazonaws.com/d3/2e01f0dc7c11e390ad71b4be1de5b8/Slide2.png)
5. The activity label id's(1 through 6) were replaced in by more descriptive labels (WALKING for 1, WALKING_UPSTAIRS for 2, WALKING_DOWNSTAIRS for 3, SITTING for 4, STANDING for 5, and LAYING for 6). 
6. extract from the master data set the standard deviation and mean measures
	- standard deviation variables are identified by "std()"
	- mean variables are identified by "mean()"
6. rename the variable names to names more english-like:
	- stripping out all special characters (, - ()) 
	- replacing acronyms with complete names:
	- "Acc" is replaced by "Accelerometer" 
	- "Gyro" is replaced by "Gyroscope"
	- "Mag" is replaced by "Magnitude"
	- "t" in the beginning of each variable name is replaced by "time" referring to time series
	- "f" in the beginning of each variable is replaced by "frequency"
	- remove duplicate of the word "body" from variable names. some variables had ...bodybody...
	- the X at the end of the variable name is replaced by XAxis
	- the Y at the end of the variable name is replaced by YAxis
	- The Z at the end of the variable name is replaced by ZAxis
	- use camel case in naming convention because some variable names were very long making it difficult for the eye to read a 25 character long lowercase string.
6. calculate the mean for each standard deviation and mean measure for each subject and activity.  

#### Data dictionary

| Variable Name                               	| Source Measure                  	| Description                                                                                                                                                                                    	|   	|
|---------------------------------------------	|---------------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|---	|
| subject                                     	|                                 	| Identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.                                                                                           	|   	|
| activity                                    	|                                 	| The activity the subject was performing while measures were taken. Values are WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAITS, SITTING, STANDING, LAYING                                         	|   	|
| timeBodyAccelerometerMeanXAxis              	| tBodyAcc-means of()-X           	| Mean of the time domain means of body acceleration signals captured from the smartphone accelerometer X axis                                                                                   	|   	|
| timeBodyAccelerometerMeanYAxis              	| tBodyAcc-means of()-Y           	| Mean of the time domain means of body acceleration siganls captured from the smartphone accelerometer Y axis                                                                                   	|   	|
| timeBodyAccelerometerMeanZAxis              	| tBodyAcc-means of()-Z           	| Mean of the time domain means of body acceleration signals captured from the smartphone accelerometer Z axis and derived in the time domain                                                    	|   	|
| timeBodyAccelerometerStdXAxis               	| tBodyAcc-std()-X                	| Mean of the time domain standard deviations of body acceleration signals captured from the smartphone accelerometer X axis                                                                     	|   	|
| timeBodyAccelerometerStdYAxis               	| tBodyAcc-std()-Y                	| Mean of the time domain standard deviations of body acceleration signals captured from the smartphone accelerometer Y axis                                                                     	|   	|
| timeBodyAccelerometerStdZAxis               	| tBodyAcc-std()-Z                	| Mean of the time domain standard deviations of body acceleration signals captured from the smartphone accelerometer Z axis                                                                     	|   	|
| timeGravityAccelerometerMeanXAxis           	| tGravityAcc-means of()-X        	| Mean of the time domain means of gravity acceleration signals captured from the smartphone accelerometer X Axis                                                                                	|   	|
| timeGravityAccelerometerMeanYAxis           	| tGravityAcc-means of()-Y        	| Mean of the time domain means of gravity acceleration signals captured from the smartphone accelerometer Y Axis                                                                                	|   	|
| timeGravityAccelerometerMeanZAxis           	| tGravityAcc-means of()-Z        	| Mean of the means of time domain gravity acceleration signals captured from the smartphone accelerometer Z Axis                                                                                	|   	|
| timeGravityAccelerometerStdXAxis            	| tGravityAcc-std()-X             	| Mean of the time domain standard deviations of gravity acceleration signals captured from the smartphone accelerometer X Axis                                                                  	|   	|
| timeGravityAccelerometerStdYAxis            	| tGravityAcc-std()-Y             	| Mean of the time domain standard deviations of gravity acceleration signals captured from the smartphone accelerometer Y Axis                                                                  	|   	|
| timeGravityAccelerometerStdZAxis            	| tGravityAcc-std()-Z             	| Mean of the time domain standard deviations of gravity acceleration signals captured from the smartphone accelerometer Z Axis                                                                  	|   	|
| timeBodyAccelerometerJerkMeanXAxis          	| tBodyAccJerk-means of()-X       	| Mean of the time domain means of body jerk signals obtained by deriving in time domain the smartphone accelerometer acceleration signals on X axis                                             	|   	|
| timeBodyAccelerometerJerkMeanYAxis          	| tBodyAccJerk-means of()-Y       	| Mean of the time domain means of body jerk signals obtained by deriving in time domain the smartphone accelerometer acceleration signals on y axis                                             	|   	|
| timeBodyAccelerometerJerkMeanZAxis          	| tBodyAccJerk-means of()-Z       	| Mean of the time domain means of body jerk signals obtained by deriving in time domain smartphone accelerometer acceleration signals on Z axis                                                 	|   	|
| timeBodyAccelerometerJerkStdXAxis           	| tBodyAccJerk-std()-X            	| Mean of the time domain standard deviations of body jerk signals obtained by deriving in time domain the smartphone accelerometer acceleration signals on X axis                               	|   	|
| timeBodyAccelerometerJerkStdYAxis           	| tBodyAccJerk-std()-Y            	| Mean of the time domain standard deviations of body jerk signals obtained by deriving in time domain the smartphone accelerometer acceleration signals on y axis                               	|   	|
| timeBodyAccelerometerJerkStdZAxis           	| tBodyAccJerk-std()-Z            	| Mean of the time domain standard deviations of body jerk signals obtained by deriving in time domain the smartphone accelerometer acceleration signals on Z axis                               	|   	|
| timeBodyGyroscopeMeanXAxis                  	| tBodyGyro-means of()-X          	| Mean of the time domain means of angular body velocity captured from the smartphone gyroscope X axis                                                                                           	|   	|
| timeBodyGyroscopeMeanYAxis                  	| tBodyGyro-means of()-Y          	| Mean of the time domain means of angular body velocity captured from the smartphone gyroscope Y axis                                                                                           	|   	|
| timeBodyGyroscopeMeanZAxis                  	| tBodyGyro-means of()-Z          	| Mean of the time domain means of angular body velocity captured from the smartphone gyroscope Z axis                                                                                           	|   	|
| timeBodyGyroscopeStdXAxis                   	| tBodyGyro-std()-X               	| Mean of the time domain standard deviations of angular body velocity captured from the smartphone gyroscope X axis                                                                             	|   	|
| timeBodyGyroscopeStdYAxis                   	| tBodyGyro-std()-Y               	| Mean of the time domain standard deviations of angular body velocity captured from the smartphone gyroscope Y axis                                                                             	|   	|
| timeBodyGyroscopeStdZAxis                   	| tBodyGyro-std()-Z               	| Mean of the time domain standard deviations  of angular body velocity captured from the smartphone gyroscope Z axis                                                                            	|   	|
| timeBodyGyroscopeJerkMeanXAxis              	| tBodyGyroJerk-means of()-X      	| Mean of the time domain means  of body angular velocity jerk signals obtained by deriving in time domain the smartphone gyroscope angular velocity on X axis                                   	|   	|
| timeBodyGyroscopeJerkMeanYAxis              	| tBodyGyroJerk-means of()-Y      	| Mean of the time domain means  of body angular velocity jerk signals obtained by deriving in time domain the smartphone gyroscope angular velocity on Y axis                                   	|   	|
| timeBodyGyroscopeJerkMeanZAxis              	| tBodyGyroJerk-means of()-Z      	| Mean of the time domain means  of body angular velocity jerk signals obtained by deriving in time domain the smartphone gyroscope angular velocity on Z axis                                   	|   	|
| timeBodyGyroscopeJerkStdXAxis               	| tBodyGyroJerk-std()-X           	| Mean of the time domain standard deviations  of body angular velocity jerk signals obtained by deriving in time domain the smartphone gyroscope angular velocity on X axis                     	|   	|
| timeBodyGyroscopeJerkStdYAxis               	| tBodyGyroJerk-std()-Y           	| Mean of the time domain standard deviations  of body angular velocity jerk signals obtained by deriving in time domain the smartphone gyroscope angular velocity on Y axis                     	|   	|
| timeBodyGyroscopeJerkStdZAxis               	| tBodyGyroJerk-std()-Z           	| Mean of the time domain standard deviations  of body angular velocity jerk signals obtained by deriving in time domain the smartphone gyroscope angular velocity on Z axis                     	|   	|
| timeBodyAccelerometerMagnitudeMean          	| tBodyAccMag-means of()          	| Mean of the time domain means  of body magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                                            	|   	|
| timeBodyAccelerometerMagnitudeStd           	| tBodyAccMag-std()               	| Mean of the time domain standard deviations  of body magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                              	|   	|
| timeGravityAccelerometerMagnitudeMean       	| tGravityAccMag-means of()       	| Mean of the time domain means  of gravity magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                                         	|   	|
| timeGravityAccelerometerMagnitudeStd        	| tGravityAccMag-std()            	| Mean of the time domain standard deviations  of gravity magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                           	|   	|
| timeBodyAccelerometerJerkMagnitudeMean      	| tBodyAccJerkMag-means of()      	| Mean of the time domain means  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the accelerometer acceleration signals                    	|   	|
| timeBodyAccelerometerJerkMagnitudeStd       	| tBodyAccJerkMag-std()           	| Mean of the time domain standard deviations  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the accelerometer acceleration signals      	|   	|
| timeBodyGyroscopeMagnitudeMean              	| tBodyGyroMag-means of()         	| Mean of the time domain means  of body magnitude signals calculated using the Euclidean norm from the smartphone gyroscope angular velocity signals                                            	|   	|
| timeBodyGyroscopeMagnitudeStd               	| tBodyGyroMag-std()              	| Mean of the time domain standard deviations  of body magnitude signals calculated using the Euclidean norm from the smartphone gyroscope angular velocity signals                              	|   	|
| timeBodyGyroscopeJerkMagnitudeMean          	| tBodyGyroJerkMag-means of()     	| Mean of the time domain means  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the gyroscope angular velocity signals                    	|   	|
| timeBodyGyroscopeJerkMagnitudeStd           	| tBodyGyroJerkMag-std()          	| Mean of the time domain standard deviations  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the gyroscope angular velocity signals      	|   	|
| frequencyBodyAccelerometerMeanXAxis         	| fBodyAcc-means of()-X           	| Mean of the frequency domain means  of body acceleration signals captured from the smartphone accelerometer X axis                                                                             	|   	|
| frequencyBodyAccelerometerMeanYAxis         	| fBodyAcc-means of()-Y           	| Mean of the frequency domain means  of body acceleration siganls captured from the smartphone accelerometer Y axis                                                                             	|   	|
| frequencyBodyAccelerometerMeanZAxis         	| fBodyAcc-means of()-Z           	| Mean of the frequency domain means  of body acceleration siganls captured from the smartphone accelerometer Z axis                                                                             	|   	|
| frequencyBodyAccelerometerStdXAxis          	| fBodyAcc-std()-X                	| Mean of the frequency domain standard deviations  of body acceleration signals captured from the smartphone accelerometer X axis                                                               	|   	|
| frequencyBodyAccelerometerStdYAxis          	| fBodyAcc-std()-Y                	| Mean of the frequency domain standard deviations  of body acceleration siganls captured from the smartphone accelerometer Y axis                                                               	|   	|
| frequencyBodyAccelerometerStdZAxis          	| fBodyAcc-std()-Z                	| Mean of the frequency domain standard deviations  of body acceleration siganls captured from the smartphone accelerometer Z axis                                                               	|   	|
| frequencyBodyAccelerometerJerkMeanXAxis     	| fBodyAccJerk-means of()-X       	| Mean of the frequency domain means of body jerk signals obtained by deriving in frequency domain the smartphone accelerometer acceleration signals on X axis                                   	|   	|
| frequencyBodyAccelerometerJerkMeanYAxis     	| fBodyAccJerk-means of()-Y       	| Mean of the frequency domain means of body jerk signals obtained by deriving in frequency domain the smartphone accelerometer acceleration signals on Y axis                                   	|   	|
| frequencyBodyAccelerometerJerkMeanZAxis     	| fBodyAccJerk-means of()-Z       	| Mean of the frequency domain means of body jerk signals obtained by deriving in frequency domain the smartphone accelerometer acceleration signals on Z axis                                   	|   	|
| frequencyBodyAccelerometerJerkStdXAxis      	| fBodyAccJerk-std()-X            	| Mean of the frequency domain standard deviations of body jerk signals obtained by deriving in frequency domain the smartphone accelerometer acceleration signals on X axis                     	|   	|
| frequencyBodyAccelerometerJerkStdYAxis      	| fBodyAccJerk-std()-Y            	| Mean of the frequency domain standard deviations of body jerk signals obtained by deriving in frequency domain the smartphone accelerometer acceleration signals on Y axis                     	|   	|
| frequencyBodyAccelerometerJerkStdZAxis      	| fBodyAccJerk-std()-Z            	| Mean of the frequency domain standard deviations of body jerk signals obtained by deriving in frequency domain the smartphone accelerometer acceleration signals on Z axis                     	|   	|
| frequencyBodyGyroscopeMeanXAxis             	| fBodyGyro-means of()-X          	| Mean of the frequency domain means of angular body velocity captured from the smartphone gyroscope X axis                                                                                      	|   	|
| frequencyBodyGyroscopeMeanYAxis             	| fBodyGyro-means of()-Y          	| Mean of the frequency domain means of angular body velocity captured from the smartphone gyroscope Y axis                                                                                      	|   	|
| frequencyBodyGyroscopeMeanZAxis             	| fBodyGyro-means of()-Z          	| Mean of the frequency domain means of angular body velocity captured from the smartphone gyroscope Z axis                                                                                      	|   	|
| frequencyBodyGyroscopeStdXAxis              	| fBodyGyro-std()-X               	| Mean of the frequency domain standard deviations of angular body velocity captured from the smartphone gyroscope X axis                                                                        	|   	|
| frequencyBodyGyroscopeStdYAxis              	| fBodyGyro-std()-Y               	| Mean of the frequency domain standard deviations of angular body velocity captured from the smartphone gyroscope Y axis                                                                        	|   	|
| frequencyBodyGyroscopeStdZAxis              	| fBodyGyro-std()-Z               	| Mean of the frequency domain standard deviations of angular body velocity captured from the smartphone gyroscope Z axis                                                                        	|   	|
| frequencyBodyAccelerometerMagnitudeMean     	| fBodyAccMag-means of()          	| Mean of the frequency domain means  of body magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                                       	|   	|
| frequencyBodyAccelerometerMagnitudeStd      	| fBodyAccMag-std()               	| Mean of the frequency domain standard deviations  of body magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                         	|   	|
| frequencyBodyAccelerometerJerkMagnitudeMean 	| fBodyBodyAccJerkMag-means of()  	| Mean of the frequency domain means  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the accelerometer acceleration signals               	|   	|
| frequencyBodyAccelerometerJerkMagnitudeStd  	| fBodyBodyAccJerkMag-std()       	| Mean of the frequency domain standard deviations  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the accelerometer acceleration signals 	|   	|
| frequencyBodyGyroscopeMagnitudeMean         	| fBodyBodyGyroMag-means of()     	| Mean of the frequency domain means  of body magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                                       	|   	|
| frequencyBodyGyroscopeMagnitudeStd          	| fBodyBodyGyroMag-std()          	| Mean of the frequency domain standard deviations  of body magnitude signals calculated using the Euclidean norm from the smartphone accelerometer acceleration signals                         	|   	|
| frequencyBodyGyroscopeJerkMagnitudeMean     	| fBodyBodyGyroJerkMag-means of() 	| Mean of the frequency domain means  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the accelerometer acceleration signals               	|   	|
| frequencyBodyGyroscopeJerkMagnitudeStd      	| fBodyBodyGyroJerkMag-std()      	| Mean of the frequency domain standard deviations  of body jerk magnitude signals obtained by calculating the magnitude of the jerk signals derived from the accelerometer acceleration signals 	|   	|