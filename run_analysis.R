#####################################
## DATASET DOWNLOADING AND UNZIPPING
#####################################

## suppose the user has already set the working directory

if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/Dataset.zip")
unzip("./data/Dataset.zip", exdir = "./data")

rm(list = ls())


#####################################
## Loading library(ies)
#####################################

library(dplyr)


####################################
## DESCRIPTIVE VARIABLE NAMES (FEATURES) and 
## DESCRIPTIVE ACTIVITY NAMES DATA
####################################

## Descriptive variable names (features) dataset reading
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
## Converting the column1 (labels ranging 1-561) to a character variable for further merging
features$V1 <- as.character(features$V1) 

## Descriptive activity names dataset reading
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
## Renaming of the variables to facilitate further merging
names(activity_labels)[1] <- "activity_id"
names(activity_labels)[2] <- "activity"


################################
## TRAINING DATA PRE-PROCESSING
################################

## Training subject_id data reading & column renaming
train_subjectid <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".")
names(train_subjectid)[names(train_subjectid) == "V1"] <- "subject_id"
## Adding a primary key (rowid) to facilitate further merging
train_subjectid <- mutate(train_subjectid, id = rownames(train_subjectid))

## Training labels data: reading & adding descriptive activity names
train_label <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", dec = ".")
## Renaming the column to activity_id
names(train_label)[names(train_label) == "V1"] <- "activity_id"
## Adding a primary key (rowid) to facilitate further merging
train_label <- mutate(train_label, id = rownames(train_label))
## Adding descriptive activity names
train_activity_label <- merge(x = train_label, y = activity_labels, by = "activity_id", all = TRUE)

## Merging train_subject_id with train_activity_labels
train_subjectid_activity <- merge(x = train_subjectid, y = train_activity_label, by = "id", all = TRUE)

## Training data: reading
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")
## removes "V" from train data column names
names(train_data) <- gsub("V","",names(train_data)) 

## Training data: labeling of the dataset with descriptive variable names 
names(train_data) <- features$V2[match(names(train_data), features$V1)]

## Training data: Extracting only the measurements on the mean and standard deviation for each measurement.
train_data <- train_data %>% select(contains(c("-mean()", "-std()")))

## Training Data: adding a primary key (rowid) to facilitate further merging
train_data <- mutate(train_data, id = rownames(train_data)) ## adds a column with rowid

## Final training dataset: creating the final training dataset by merging train_subject_activity with train_data
train_final <- merge(x = train_subjectid_activity, y = train_data, by = "id", all = TRUE)


################################
## TEST DATA PRE-PROCESSING
################################

## Test subject_id data reading & column renaming
test_subjectid <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".")
names(test_subjectid)[names(test_subjectid) == "V1"] <- "subject_id"
## Adding a primary key (rowid) to facilitate further merging
test_subjectid <- mutate(test_subjectid, id = rownames(test_subjectid))

## Test labels data: reading & adding descriptive activity names
test_label <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", dec = ".")
## Renaming the column to activity_id
names(test_label)[names(test_label) == "V1"] <- "activity_id"
## Adding a primary key (rowid) to facilitate further merging
test_label <- mutate(test_label, id = rownames(test_label))
## Adding descriptive activity names
test_activity_label <- merge(x = test_label, y = activity_labels, by = "activity_id", all = TRUE)

## Merging test_subject_id with test_activity_labels
test_subjectid_activity <- merge(x = test_subjectid, y = test_activity_label, by = "id", all = TRUE)

## Test data: reading
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")
## removes "V" from train data column names
names(test_data) <- gsub("V","",names(test_data))

## Test data: labeling of the data set with descriptive variable names 
names(test_data) <- features$V2[match(names(test_data), features$V1)]

## Test data: Extracting only the measurements on the mean and standard deviation for each measurement.
test_data <- test_data %>% select(contains(c("-mean()", "-std()")))

## Test data: adding a primary key (rowid) to facilitate further merging
test_data <- mutate(test_data, id = rownames(test_data)) ## adds a column with rowid

## Final test dataset: creating the final test dataset by merging test_subject_activity with test_data
test_final <- merge(x = test_subjectid_activity, y = test_data, by = "id", all = TRUE)


#########################################
## MERGING TRAINING DATA WITH TEST DATA
#########################################

## merging of training and test datasets into one dataset
final_dataset <- bind_rows(train_final, test_final)
## converting subject_id into a character variable
final_dataset$subject_id <- as.character(final_dataset$subject_id)


#########################################
## TIDY DATASET
## CALCULATING AVERAGE OF EACH VARIABLE 
## FOR EACH ACTIVITY AND EACH SUBJECT
#########################################

## calculating mean for each variable by each activity and each subject
average_activity_subject <- aggregate(final_dataset[, 5:70], 
                                      list(final_dataset$activity, 
                                           final_dataset$subject_id), 
                                      mean)

## renaming first two columns by their respective names, i.e. "activity" and "subject_id".
names(average_activity_subject)[1] <- "activity"
names(average_activity_subject)[2] <- "subject_id"


########################################
## PRINTING OF THE TIDY DATASET
########################################

## printing to txt file
write.table(average_activity_subject, file = "tidy_data.txt", sep = "\t",
            row.names = FALSE)      