## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names. 
## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

##=============================================================================

## 1. Merge the training and the test sets into one data set.

##Load the library
library(dplyr)
library(data.table)

##Read shared metadata
features <- fread("UCI HAR Dataset/features.txt", col.names = c("index", "featureName"))
activities <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityName"))

##Read training data
X_train <- fread("UCI HAR Dataset/train/X_train.txt")
y_train <- fread("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")
subject_train <- fread("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectId")

##Read test data
X_test <- fread("UCI HAR Dataset/test/X_test.txt")
y_test <- fread("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectId")

##Bind rows for measurements, activities, and subjects
X_total <- rbind(X_train, X_test)
y_total <- rbind(y_train, y_test)
subject_total <- rbind(subject_train, subject_test)

##Assign initial feature names to the data columns
colnames(X_total) <- features$featureName

##Combine everything into one
combined_data <- cbind(subject_total, y_total, X_total)

##=============================================================================

## 2. Extract only the mean and standard deviation for each measurement.

##Identify columns, and keep subjectId and activityId as well
target_features <- grep("subjectId|activityId|mean\\(\\)|std\\(\\)", colnames(combined_data), value = TRUE)
filtered_data <- combined_data[, ..target_features]

##=============================================================================

## 3. Use descriptive activity names.

##Replace activity IDs with descriptive factors from the activity_labels file
filtered_data$activityId <- factor(filtered_data$activityId, 
                                   levels = activities$activityId, 
                                   labels = activities$activityName)

##Rename column to show it contains names now
filtered_data <- rename(filtered_data, activity = activityId)

##=============================================================================

## 4. Label data with descriptive variable names. 

##Clean up structural prefixes and contractions to make names readable
data_cols <- colnames(filtered_data)
data_cols <- gsub("^t", "time", data_cols)
data_cols <- gsub("^f", "frequency", data_cols)
data_cols <- gsub("Acc", "Accelerometer", data_cols)
data_cols <- gsub("Gyro", "Gyroscope", data_cols)
data_cols <- gsub("Mag", "Magnitude", data_cols)
data_cols <- gsub("BodyBody", "Body", data_cols) # Fixes data typo
data_cols <- gsub("-mean\\(\\)", "Mean", data_cols)
data_cols <- gsub("-std\\(\\)", "STD", data_cols)
data_cols <- gsub("-", "", data_cols) # Remove residual dashes

colnames(filtered_data) <- data_cols

##=============================================================================

## 5. Create a second, independent tidy data set with the average of each variable
## for each activity and each subject.

# Group by subject and activity, then calculate the average for every variable
tidy_dataset <- filtered_data %>%
    group_by(subjectId, activity) %>%
    summarise(across(everything(), mean), .groups = 'drop')

# Write the final table out to a text file
write.table(tidy_dataset, "tidy_dataset.txt", row.name = FALSE)
