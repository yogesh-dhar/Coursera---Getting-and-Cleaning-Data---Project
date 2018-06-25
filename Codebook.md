Introduction

The script has 5 steps described in the course project's definition.

First, we have to visualize and then understand the structure of the data provided to us in the zip file, like Subject, Values, Activities, etc, basically consolidating similar data (same columns). We use rbind function to merge similar data.
Select columns with Mean and Standard Deviation from the dataset. Then we apply correct names to the fields as given in the file 'features.txt'.
We take activity data with values 1:6 and select the activity names and IDs from the file 'activity_labels.txt'. Then we  substitute them in the dataset.
We correct columns with vague names in the dataset.
In final step we generate a new dataset (full_data) with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called 'tidy.txt', which I have uploaded to my Coursera submission.

Variables used:

trainVal (X_train.txt)
trainAct (y_train.txt)
trainSub (subject_train.txt)
testVal (X_test.txt)
testAct (y_test.txt)
testSub (subject_test.txt)

These vaiables contain data from the downloaded files.

- 'dataVal', 'dataAct' and 'dataSub' merge the aforementioned 6 datasets for further analysis.
- 'features' contains the correct names for the dataVal dataset, which we use to the column names stored in featuresMStdev (mean and standard deviation). This is a numeric vector used to extract the desired data.
- 'activities' variable deals with the activity names.
- 'full_data' merges 'dataVal', 'dataAct' and 'dataSub' in a consolidated and cleaned dataset.
- 'mean_data' contains the required mean values, which will be later stored in a .txt file (tidy.txt). We have used the function 'ddply()' from the 'plyr' package to apply colMeans() to improve our analysis.
