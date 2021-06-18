# README

This README file explains how all of the scripts work and how they are connected. The full process is described in detail in the below steps.

### Step 0. Library loading

Then necessary library is loaded. In this script, I use "dplyr" package for data processing:
```{r}
library(dplyr)
```

### Step 1. Dataset downloading and unzipping

The below scripts demonstrate how to create data directory under the working directory, to read the database url, to download the file. Later on the downloaded zip file is unzipped.
```{r}
if(!file.exists("./data")){dir.create("./data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/Dataset.zip")
unzip("./data/Dataset.zip", exdir = "./data")
```

### Step 2. Reading descriptive variable names (features) and descriptive activity names 

First, the dataset with the descriptive variable names (features) is read in via *read.table* funtion and saved as **features** dataframe. It contains two variables: V1 and V2. V1 represents the variable index, V2 -- the respective descriptive variable names. V1 is saved as character variable using *as.character* function to facilitate the further merging with relevant dataframes.
```{r}
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
features$V1 <- as.character(features$V1) 
```
Next, the dataset with the descriptive activity names is read in and saved as **activity_labels** dataframe.Then the variable names are renamed accordingly: the first column represents *activity_id* and the second column -- *activity* names, respectively. 
```{r}
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
names(activity_labels)[1] <- "activity_id"
names(activity_labels)[2] <- "activity"
```

### Step 3. Pre-processing of training datasets

The below scripts are designed to pre-process **the training datasets** and generate a complete training dataset with the necessary variables: subject id, descriptive activity names, features variables that calculate mean and standard deviations.

First, the dataset containing train subject id is read in and saved as **train_subjectid**. The dataframe contains one column (V1) representing subject ids. The column is renamed accordingly. 
As each row identifies the subject who performed the activity for each window sample, the rowid becomes an important key identifier for merging the subject ids with activity labels and the main train dataset. Hence, rowid (index) is added as a new column named "id" using *mutate* function. It will be used as a primary key. The outcome replaces **train_subjectid**.

```{r}
train_subjectid <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".")
names(train_subjectid)[names(train_subjectid) == "V1"] <- "subject_id"
train_subjectid <- mutate(train_subjectid, id = rownames(train_subjectid))
```
Below, the dataset that contains non-descriptive activity labels (ranging from 1 to 6) is read in and saved as **train_label**. The dataframe contains one column (V1) representing activities ids. The column is renamed accordingly.
As each row identifies the label of the activity performed at each window sample, the rowid becomes an important key identifier for merging with the descriptive activity names, subject ids and the main train dataset. Hence, rowid (index) is added as a new column named "id" using *mutate* function. It will be used as a primary key. Later, *merge* function is used to join the descriptive activity names. The outcome is saved as **train_activity_label**. 

```{r}
train_label <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", dec = ".")
names(train_label)[names(train_label) == "V1"] <- "activity_id"
train_label <- mutate(train_label, id = rownames(train_label))
train_activity_label <- merge(x = train_label, y = activity_labels, by = "activity_id", all = TRUE)
```

Next, the above **train_subjectid** and **train_activity_label** dataframes are merged by using their primary keys, column "id". The outcome is saved as **train_subjectid_activity**.
```{r}
train_subjectid_activity <- merge(x = train_subjectid, y = train_activity_label, by = "id", all = TRUE)
```
Below, the training dataset is read in as **train_data** dataframe. Since the header parameter in the *read.table* set to FALSE, the variable names are generated automatically. They range from V1 to V561. If I remove letter "V" from the variable names, the numerical values ranging from 1 to 561 can be used as keys for adding the descriptive variable names. **gsub** function is used to removing the letter "V".
```{r}
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")
names(train_data) <- gsub("V","",names(train_data)) 
```
Function *match* is used for adding the descriptive variable names from **features** dataframe to **train_data** dataframe:
```{r}
names(train_data) <- features$V2[match(names(train_data), features$V1)]
```
Function *select* is used for filtering those column variables that represent the measurement on the mean and standard deviation for each measurement. In doing so, literals that contain *"-mean()", "-std()"* are used. The outcome replaces the initial train_data dataframe, and is saved as **train_data**.
```{r}
train_data <- train_data %>% select(contains(c("-mean()", "-std()")))
```
Similarly to **train_subject_id** and **train_activity_label** dataframes, a primary key column is added in the **train_data** dataframe:
```{r}
train_data <- mutate(train_data, id = rownames(train_data)) ## adds a column with rowid
```
Finally, the final train dataframe **train_final** is created by *merge*-ing **train_subjectid_activity** and **train_data** dataframes by using their primary keys, i.e. "id" columns.  
```{r}
train_final <- merge(x = train_subjectid_activity, y = train_data, by = "id", all = TRUE)
```

### Step 4. Pre-processing of test datasets

The below scripts are designed to pre-process **the test datasets** and generate a complete test dataset with the necessary variables: subject id, descriptive activity names, features variables that calculate mean and standard deviations. The scripts are identical to those used for pre-processing of training data pre-processing.

First, the dataset containing test subject id is read in and saved as **test_subjectid**. The dataframe contains one column (V1) representing subject ids. The column is renamed accordingly. 
As each row identifies the subject who performed the activity for each window sample, the rowid becomes an important key identifier for merging the subject ids with activity labels and the main test dataset. Hence, rowid (index) is added as a new column named "id" using *mutate* function. It will be used as a primary key. The outcome replaces **test_subjectid**.
```{r}
test_subjectid <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".")
names(test_subjectid)[names(test_subjectid) == "V1"] <- "subject_id"
test_subjectid <- mutate(test_subjectid, id = rownames(test_subjectid))
```

Below, the dataset that contains non-descriptive activity labels (ranging from 1 to 6) is read in and saved as **test_label**. The dataframe contains one column (V1) representing activities ids. The column is renamed accordingly.
As each row identifies the label of the activity performed at each window sample, the rowid becomes an important key identifier for merging with the descriptive activity names, subject ids and the main test dataset. Hence, rowid (index) is added as a new column named "id" using *mutate* function. It will be used as a primary key. Later, *merge* function is used to join the descriptive activity names. The outcome is saved as **test_activity_label**. 
```{r}
test_label <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", dec = ".")
names(test_label)[names(test_label) == "V1"] <- "activity_id"
test_label <- mutate(test_label, id = rownames(test_label))
test_activity_label <- merge(x = test_label, y = activity_labels, by = "activity_id", all = TRUE)
```

Next, the above **test_subjectid** and **test_activity_label** dataframes are merged by using their primary keys, column "id". The outcome is saved as **test_subjectid_activity**.
```{r}
test_subjectid_activity <- merge(x = test_subjectid, y = test_activity_label, by = "id", all = TRUE)
```

Below, the test dataset is read in as **test_data** dataframe. Since the header parameter in the *read.table* set to FALSE, the variable names are generated automatically. They range from V1 to V561. If I remove letter "V" from the variable names, the numerical values ranging from 1 to 561 can be used as keys for adding the descriptive variable names. **gsub** function is used to removing the letter "V".
```{r}
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")
names(test_data) <- gsub("V","",names(test_data))
```

Function *match* is used for adding the descriptive variable names from **features** dataframe to **test_data** dataframe:
```{r}
names(test_data) <- features$V2[match(names(test_data), features$V1)]
```

Function *select* is used for filtering those column variables that represent the measurement on the mean and standard deviation for each measurement. In doing so, literals that contain *"-mean()", "-std()"* are used. The outcome replaces the initial test_data dataframe, and is saved as **test_data**.
```{r}
test_data <- test_data %>% select(contains(c("-mean()", "-std()")))
```

Similarly to **test_subject_id** and **test_activity_label** dataframes, a primary key column is added in the **test_data** dataframe:
```{r}
test_data <- mutate(test_data, id = rownames(test_data)) ## adds a column with rowid
```

Finally, the final train dataframe **test_final** is created by *merge*-ing **test_subjectid_activity** and **test_data** dataframes by using their primary keys, i.e. "id" columns.
```{r}
test_subject_activity with test_data
test_final <- merge(x = test_subjectid_activity, y = test_data, by = "id", all = TRUE)
```

### Step 5. Merging training data with test data

Below, the **train_final** and **test_final** dataframes are concatenated by using *bind_rows* function. The *subject_id* column is converted to a character variables via *as.character* function:
```{r}
final_dataset <- bind_rows(train_final, test_final)
final_dataset$subject_id <- as.character(final_dataset$subject_id)
```

### Step 6. Creating tidy dataset by calculating average of each variable by each activity and each subject

Below, average values of each variable is calculated by each activity and each subject via *aggregate* function. Parameter *list* refers to the list of group by elements. Function parameter is set to *mean*. The output tidy dataset is saved to framework **average_activity_subject**. Then the first two columns of the dataframe are renamed to "activity" and "subject_id" respectively.
```{r}
average_activity_subject <- aggregate(final_dataset[, 5:70], 
                                      list(final_dataset$activity, 
                                           final_dataset$subject_id), 
                                      mean)

names(average_activity_subject)[1] <- "activity"
names(average_activity_subject)[2] <- "subject_id"
```

### Step 7. Printing of the tidy dataset

Below script prints the tidy dataset into a text file named **tidy_data.txt**.
```{r}
write.table(average_activity_subject, file = "tidy_data.txt", sep = "\t",
            row.names = FALSE)      
```
