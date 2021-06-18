---
title: "CodeBook"
---

This is **a code book** that describes the data, variables, and any transformations or work that I performed to clean up the data.

### Database description

The database used for this assignment is called *Human Activity Recognition Using Smartphones (version 1.0)*, and is collected and shared by a group of researchers --- Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto --- from Smartlab - Non Linear Complex Systems Laboratory, Genoa, Italy.

The data have been collected via experimental method which was carried out with a group of 30 volunteers, aged 19-49 years. Each person performed six activities (*WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING*) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The data source and the relevant information can be found at the UCI Machine Learning Repository ([click here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)). 

The data for the project are downloaded via the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Datasets used

The data is downloaded as a zip file called Dataset.zip. When unzipped it contains a main folder named UCI HAR Dataset. Inside the main folder, there are two subfolders containing **test** and **train data** which are key datasets for this project.
The following datasets (located in train & test subfolders, respectively) will be used for data analysis of this project:

#### Training datasets:

* **train/X_train.txt**: *training set. It contains 7352 observations or rows across 561 variables of features. Each row represents one observation or one window sample. Hence the rowid is used as a primary key for matching or joining the dataset with other relational datasets:* __y_train.txt__ *and*  __subject_train.txt__.
* **train/y_train.txt**: *training labels. Each row identifies the label (id) for the activity which was performed at that specific window sample. It contains 7352 rows, each matching the respective window sample in* __X_train.txt__ *dataset, and 1 column, which represents the activity id for the respective window sample.*
* **train/subject_train.txt**: *each row identifies the subject who performed the activity for each window sample. It contains 7352 rows, each matching the respective window sample in* __X_train.txt__ *dataset, and 1 column, which represents the subject id for the respective window sample.*

#### Test datasets:

* **test/X_test.txt**: *test set. It contains 7352 observations or rows across 561 variables of features. Each row represents one observation or one window sample. Hence the rowid is used as a primary key for matching or joining the dataset with other relational datasets:* __y_test.txt__ *and*  __subject_test.txt__.
* **test/y_test.txt**: *test labels. Each row identifies the label (id) for the activity which was performed at that specific window sample. It contains 7352 rows, each matching the respective window sample in* __X_test.txt__ *dataset, and 1 column, which represents the activity id for the respective window sample.*
* **test/subject_test.txt**: *each row identifies the subject who performed the activity for each window sample. It contains 7352 rows, each matching the respective window sample in* __X_test.txt__ *dataset, and 1 column, which represents the subject id for the respective window sample.*

On top of the above mentioned main datasets, there are other supporting text files which provide important information:

* **features.txt**: *contains list of 561 features (i.e.* __descriptive variable names__*) with their respective coding (1 to 561). Later on, at the data processing stage, these variable names are used as variable column names in test and train data, respectively.*
* **activity_label.txt**: *provides* __descriptive activity names__ *with their respective class labels or coding (1 to 6). Later on, at the data processing stage of this project, these activity names are matched and joined with the main train and test datasets respectively for further data analyses.*

As described, **features.txt** and **activity_label.txt** are used to add variable names (as columns) and activity labels into the training and test datasets, respectively.

### Variables used

Following the current task requirements, the following variables are used in the data transformation and further analyses:

* **subject id** ranging from 1 to 30.
* **descriptive activity name**: there are 6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* **mean and standard deviation for each measurement from the features variables**: there are total of 66 variables (including mean and standard deviation) are selected from the initial 561 feature variables provided, for the data analysis in this project. The below is the list of 66 variables selected:

 [1] "tBodyAcc-mean()-X"          
 [2] "tBodyAcc-mean()-Y"          
 [3] "tBodyAcc-mean()-Z"          
 [4] "tGravityAcc-mean()-X"       
 [5] "tGravityAcc-mean()-Y"       
 [6] "tGravityAcc-mean()-Z"       
 [7] "tBodyAccJerk-mean()-X"      
 [8] "tBodyAccJerk-mean()-Y"      
 [9] "tBodyAccJerk-mean()-Z"      
[10] "tBodyGyro-mean()-X"         
[11] "tBodyGyro-mean()-Y"         
[12] "tBodyGyro-mean()-Z"         
[13] "tBodyGyroJerk-mean()-X"     
[14] "tBodyGyroJerk-mean()-Y"     
[15] "tBodyGyroJerk-mean()-Z"     
[16] "tBodyAccMag-mean()"         
[17] "tGravityAccMag-mean()"      
[18] "tBodyAccJerkMag-mean()"     
[19] "tBodyGyroMag-mean()"        
[20] "tBodyGyroJerkMag-mean()"    
[21] "fBodyAcc-mean()-X"          
[22] "fBodyAcc-mean()-Y"          
[23] "fBodyAcc-mean()-Z"          
[24] "fBodyAccJerk-mean()-X"      
[25] "fBodyAccJerk-mean()-Y"      
[26] "fBodyAccJerk-mean()-Z"      
[27] "fBodyGyro-mean()-X"         
[28] "fBodyGyro-mean()-Y"         
[29] "fBodyGyro-mean()-Z"         
[30] "fBodyAccMag-mean()"         
[31] "fBodyBodyAccJerkMag-mean()"       
[32] "fBodyBodyGyroMag-mean()"          
[33] "fBodyBodyGyroJerkMag-mean()"      
[34] "tBodyAcc-std()-X"           
[35] "tBodyAcc-std()-Y"           
[36] "tBodyAcc-std()-Z"           
[37] "tGravityAcc-std()-X"        
[38] "tGravityAcc-std()-Y"        
[39] "tGravityAcc-std()-Z"        
[40] "tBodyAccJerk-std()-X"       
[41] "tBodyAccJerk-std()-Y"       
[42] "tBodyAccJerk-std()-Z"       
[43] "tBodyGyro-std()-X"          
[44] "tBodyGyro-std()-Y"          
[45] "tBodyGyro-std()-Z"          
[46] "tBodyGyroJerk-std()-X"      
[47] "tBodyGyroJerk-std()-Y"      
[48] "tBodyGyroJerk-std()-Z"      
[49] "tBodyAccMag-std()"          
[50] "tGravityAccMag-std()"       
[51] "tBodyAccJerkMag-std()"      
[52] "tBodyGyroMag-std()"         
[53] "tBodyGyroJerkMag-std()"     
[54] "fBodyAcc-std()-X"           
[55] "fBodyAcc-std()-Y"           
[56] "fBodyAcc-std()-Z"           
[57] "fBodyAccJerk-std()-X"       
[58] "fBodyAccJerk-std()-Y"       
[59] "fBodyAccJerk-std()-Z"       
[60] "fBodyGyro-std()-X"          
[61] "fBodyGyro-std()-Y"          
[62] "fBodyGyro-std()-Z"          
[63] "fBodyAccMag-std()"          
[64] "fBodyBodyAccJerkMag-std()"  
[65] "fBodyBodyGyroMag-std()"     
[66] "fBodyBodyGyroJerkMag-std()" 

### Data transformations performed
The following data transformation procedures are performed to generate the final tidy set with the average of each variable for each activity and each subject. Note that the Steps 5-9 were conducted in both training and test datasets separately. Only then, in Step 10 the training and test datasets were conbined, later on resulting in the final tidy dataset (Step 11):

1. Reading (1) __descriptive variable names (features)__ and (2) __descriptive activity names__ datasets. Further column renaming and column class changing applied to facilitate further integration of these with the main training and test datasets.
2. Reading of (1) __subject id__ and (2) __activity labels (non descriptive)__ data for each of the training and test datasets.
3. Adding of __the primary key (rowid) column__ into the subject id and activity labels (non descriptive datasets)
4. Joining of __the activity labels (non descriptive)__ dataset with __descriptive activity names__ dataset, to ensure that the descrtiptive activity names are added
5. Reading of the __main training__ and / or __test datasets__
6. Adding of __the descriptive variable names (features)__ into __the training__ / __test datasets__.
7. Extracting of the variables which denote only __mean and standard deviation for each measurement__ from the main training / test datasets.
8. Adding of __the primary key (rowid) column__ into the training / test datasets (from Step 5).
9. Joining of the training / test datasets (from Step 6) with __subject id, activity labels (descriptive)__ datasets in order to create the final training / test datasets.
10. Combining or concatenating of the training and test datasets into __the final dataset for analysis__ consisting of 10,299 rows.
11. Creating of __the independent tidy dataset with the average of each variable for each activity and each subject__. 
