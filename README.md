---
title: "README"
author: "Pierre Baudin"
date: "January 2, 2017"
output:
  html_document:
    toc: true # table of content true
    depth: 3  # upto three depths of headings (specified by #, ## and ###)
    theme: united  # many options for theme, this one is my favorite.
    highlight: tango  # specifies the syntax highlighting style
---

# Getting and Cleaning data - Final Peer-graded assignment

## Purpose

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

## Review criteria

1- The submitted data set is tidy.

2- The Github repo contains the required scripts.

3- GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

4- The README that explains the analysis files is clear and understandable.

5- The work submitted for this project is the work of the student who submitted it.

## Dataset and origin

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Instructions for the peer-graded assignment

Create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## run_analysis.R script Operation

### Brief dataset description

* x dataset contains the measurements
* y dataset contains the activities id
* subject dataset contains the subject id

### Section 1 - Preparation operation

This section enables the relevant library and the collection of the dataset in a folder.
Note: the dataset form the URL need to be unzip.

The following packages are necessary to run the script:

```{r}
library(dplyr)
library(magrittr)
```

### Section 2 - Merge the datasets

This section read the datasets for train, test and subject.

The datasets (x, y and subject) have the same header which simplify the merge of the dataset.

The code uses dplyr function full_join() and tbl_df() to merge the x and subject dataset and convert it into a tibble object.

the y dataset simply use bind_rows() function.

### Section 3 - Extract the measurements

This section extract the mean and standard deviation measurements from the x dataset.

Using the feature dataset, the x dataset column are renamed.
Duplicate columns names are filtered at this point.

Using the grep() function, the script index the column number that correspond to the mean and standard deviation measurements.

Finally using the index and the dplyr select() function, the relevant columns are selected.

### Section 4 - Add descriptive activity names

Activity names are extracted for the activity_labels.txt file.

The y dataset is match with the activity names using left_join() function followed by the selection of the activity column to discard the id tag.

### Section 5 - Column rename and tidy dataset

At this stage, only the subject dataset is left untouched. Its column is rename at this point.

Finally the complete dataset containing mean and standard variables is bind to the subject and y dataset (activity) using the bind_cols() function from the dplyr package.

### Section 6 - Dataset with averaging of measurements

This section uses, in order, the functions group_by() and summarise_all() from the dplyr package to create the final tidy dataset of the assignment.
The tidy dataset is grouped by subject then activities. Subsequently, the mean function is applied to all the groups resulting in the final dataset.

### Section 7 - Save tidy datasets in .csv format

This section enables saving the tidy dataset and the tidy dataset with average computation in .csv format.

A description of the output datasets are available in the CodeBook.md file.

## Acknowledgements

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## License

Use of the run_Analysis.R script is free for all users.

Use of the resulting dataset "tidy_movement_data.txt" in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the author for its use or misuse. Any commercial use is prohibited.
