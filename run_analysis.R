# Peer graded assignment
# Tidy data

setwd("D:/Data Science/R-Data-Science-Study/Getting_Cleaning_Data/Week 4/Peer-greaded Assignment W4")

####################################################################
## Preparation operation
####################################################################

# Load packages
library(magrittr)
library(dplyr)

# Set up directory and download dataset for analysis
# URL to download
fileURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Local data filename
dataFileZIP <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

# Directory for the dataset
dirFile <- "./UCI HAR Dataset"

# If not exist, download the dataset.zip,
if (file.exists(dataFileZIP) == FALSE) {
      download.file(fileURL, destfile = dataFileZIP)
}

# Uncompress data file
if (file.exists(dirFile) == FALSE) {
      unzip(dataFileZIP)
}


####################################################################
# Instruction
####################################################################
# You should create one R script called run_analysis.R that does the following.

##################################################################
# 1. Merges the training and the test sets to create one data set:
##################################################################
# Import datasets

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",
                     header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",
                      header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",
                     header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                            header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                           header = FALSE)

# Explore dataset for understanding
# table(y_train)
# table(y_test)

# table(subject_test)
# table(subject_train)

# glimpse(x_train)
# glimpse(x_test)

# Using dplyr package, make a full join of the x train and x test dataset
# Since the train and test dataset have the same columns ids
# full_join() join the two dataset and match the column 
x_full <- tbl_df(full_join(x_train, x_test))

# Bind rows for the y dataset
y_full <- tbl_df(bind_rows(y_train, y_test))

# Full join on the subject dataset
subject_full <- tbl_df(full_join(subject_train, subject_test))

###################################################################
# 2. Extracts only the measurements on the mean
# and standard deviation for each measurement.
###################################################################

features <- read.table("./UCI HAR Dataset/features.txt")

# Explore
# head(features)
# Rename column names of features
names(features) <- c("featureID", "featureName")

# Rename columns for each full dataset
names(x_full) <- features$featureName
# Get rid of column duplicates
x_full <- x_full[ , !duplicated(colnames(x_full))]

# Create index of relevant column (mean and std)
index_features <- grep("[Mm]ean|[Ss]td", names(x_full))

# Select columns with mean and standard deviation using dplyr package
x_full_avg <- x_full %>% select(index_features)


#########################################################################
# 3. Use descriptive activity names to name the activities in the data set:
########################################################################

# Read activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Rename activities column and y_full column
names(activities) <- c("activityID", "activityName")
names(y_full) <- "activityID"

# Use left_join to match y_full with activities
# and select activity name column
y_full_clean <- y_full %>%
      left_join(activities) %>%
      select(activityName)

#########################################################################
# 4. Appropriately labels the data set with descriptive variable names.
###########################################################################

# Subject dataset is left to rename:
names(subject_full) <- "subjectID"

# Bind columns to get complete dataset
tidyDataset <- bind_cols(subject_full, y_full_clean, x_full_avg)


#########################################################################
# 5. From the data set in step 4, creates a second,
# independent tidy data set with the average 
# of each variable for each activity and each subject.
#########################################################################

# Create second dataset form tidyDataset using pipe operator
# and dplyr group_by and summary function
tidyDatasetAVG <- tidyDataset %>%
      group_by(subjectID, activityName) %>%
      summarise_all(mean)


########################################################################
# Created csv (tidy data set) in diretory
write.csv(tidyDataset, file = "tidyDataset.csv")
# Created csv (tidy data set AVG) in diretory
write.csv(tidyDatasetAVG, file = "tidyDatasetAVG.csv")

<<<<<<< HEAD
write.table(tidyDatasetAVG, file = "tidyDatasetAVG.txt", row.name = FALSE)
=======
# For assignment export tidyDatasetAVG as .txt
write.table(tidyDatasetAVG, file = "tidyDatasetAVG.txt", row.names = FALSE)
>>>>>>> master
