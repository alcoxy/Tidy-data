# The objectives of this script are:
#   1.Merges the training and the test sets to create one data set.
#   2.Extracts only the measurements on the mean and standard deviation 
#   for each measurement.
#   3.Uses descriptive activity names to name the activities in the data set.
#   4.Appropriately labels the data set with descriptive variable names. 
#   5.From the data set in step 4, creates a second, independent tidy data 
#   set with the average of each variable for each activity and each subject.

library(dplyr)
old_wd <- getwd()

# Obtain the data.
if (!dir.exists("UCI HAR Dataset")) unzip("getdata_projectfiles_UCI HAR Dataset.zip")
setwd("UCI HAR Dataset")

# Create a function to help merge (by row) the test and train sets.
make_data <- function(test_file, train_file) {
  test <- read.table(file.path("test",test_file))
  train <- read.table(file.path("train",train_file))
  return(rbind(test,train))
}

# Merge the test and train sets by observations, labels, and subjects.
data_observations <- make_data("X_test.txt", "X_train.txt")
data_labels <- make_data("y_test.txt", "y_train.txt")
data_subjects <- make_data("subject_test.txt", "subject_train.txt")

# Set variable names (objective 4).
features <- read.table("features.txt")
names(data_observations) <- features[,2] # Subset all variable names in features
names(data_labels) <- "Activity"
names(data_subjects) <- "Subjects"

# Set activity names instead of numbers in the labels data set (objective 3).
activities <- read.table("activity_labels.txt")
data_labels[,1] <- activities[match(data_labels[,1],activities[,1]),2]

# Select the mean and standard deviations variables in the observations 
# data set (objective 2).
features_m_sd <- features[grep("mean()|std()",features$V2),2]
data_observations <- select(data_observations, features_m_sd)

# Complete the merge of all data into one data set (objective 1).
tidy_data <- cbind(data_labels,data_subjects,data_observations)

# Create a data set with the averages of each variable in tidy_data by Activity 
# and Subjects (objective 5).
average_data <- tidy_data %>% group_by(Activity,Subjects) %>% summarise_all(mean)

# Save the data in a txt format.
write.table(average_data, file.path(old_wd,"Course_Project.txt"), row.names = FALSE)