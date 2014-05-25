
library(reshape2)

if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
    stop("was expecting HAR Dataset folder or zip file")
  } else {
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  }
}
###########################################################################################
#1. This section merges the training and the test sets to create one data set.
###########################################################################################
#Read in the data files
x.train    <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
y.train    <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
subj.train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)

x.test     <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
y.test     <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
subj.test  <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)

features   <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE, header=FALSE)  

#merge the train and test subject id's into one single data frame
df.subject  <- data.frame()
df.subject  <- rbind(df.subject, subj.train)
df.subject  <- rbind(df.subject, subj.test)

#merge the train and test activity id's into one single data frame
df.activity <- data.frame()
df.activity <- rbind(df.activity, y.train)
df.activity <- rbind(df.activity, y.test)

#merge the train and test measures into one single data frame
df          <- data.frame()
df          <- rbind(df,x.train)
df          <- rbind(df, x.test)

#add two columns to the measures data frames containing subject and activity id's. Now we have all data merged into one master df.
df          <- cbind(df,df.subject)
df          <- cbind(df, df.activity)
names(df)   <- c(features$V2, "subject", "activity")

############################################################################################
#2- Extracts only the measurements on the mean and standard deviation for each measurement. 
############################################################################################
features.sub    <- grep("[Ss][Tt][Dd]\\(|[Mm][Ee][Aa][Nn]\\(", names(df), value=TRUE) #make a vector of all col names including mean or std strings
df              <- df[, c(features.sub, "subject","activity")]                        #subset the master df and take only columns with measures names
                                                                                      #std/mean + subject and activity cols
############################################################################################
#3- Uses descriptive activity names to name the activities in the data set
############################################################################################
df$activity[df$activity==1] <- "WALKING"             #assign the string "walking" to each activity id equal to 1
df$activity[df$activity==2] <- "WALKING_UPSTAIRS"
df$activity[df$activity==3] <- "WALKING_DOWNSTAIRS"
df$activity[df$activity==4] <- "SITTING"
df$activity[df$activity==5] <- "STANDING"
df$activity[df$activity==6] <- "LAYING"
df$activity  <-as.factor(df$activity)                #As part of tidy data rules, set string values as factors

############################################################################################
#4- Appropriately labels the data set with descriptive activity names. 
############################################################################################
names(df) <- sub("^t","time", names(df))                      #Replace the t in beginnig of var to "time"
names(df) <- sub("^f","frequency", names(df))                 #Replace the f in beginning of var to "frequency"
names(df) <- gsub("[Bb]ody[Bb]ody","Body", names(df))         #Remove the word body duplicates in the same var
names(df) <- gsub("[Aa]cc","Accelerometer", names(df))          #Replace acc with Accelerator
names(df) <- gsub("[Mm]ag","Magnitude", names(df))            #Replace mag with Magnitude
names(df) <- gsub("[Gg]yro","Gyroscope",names(df))            #Replace gyro with Gyroscope
names(df) <- gsub("\\-(\\w?)", "\\U\\1", names(df), perl=T)   #Remove dash and camel case the next letter
names(df) <- gsub("\\)|\\(", "", names(df))                   #Remove parentheses
names(df) <- gsub("X$", "XAxis", names(df))                   #Replace the X at end of var with XAxis
names(df) <- gsub("Y$", "YAxis", names(df))                   #Replace the Y at end of var with YAxis
names(df) <- gsub("Z$", "ZAxis", names(df))                   #Replace the z at end of var with ZAxis


############################################################################################
#5- calculating the mean for each activity and each subject 
############################################################################################
tmp    <-melt(df, id.vars=c("subject", "activity"))                        #melt the wide data frame and keep subject and activity as ID's
df     <-dcast(tmp, subject + activity ~ variable, fun.aggregate=mean)     #cast the long data frame back into wide while taking the mean of each measure

############################################################################################
#6- writing the tidy data to a text file
############################################################################################
write.table(df, file="./UCI HAR Dataset/tidy.data.txt", sep ="\t")          #Write the tidy data set to a txt file

