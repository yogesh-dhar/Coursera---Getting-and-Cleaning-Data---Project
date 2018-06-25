Download and Unzip dataset:

> library(plyr)
> url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> file <- "UCI HAR Dataset.zip"
> if (!file.exists(file)) {
	download.file(url, file, mode = "wb")
}
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
==================================================
downloaded 59.7 MB


Path <- "UCI HAR Dataset"
if (!file.exists(Path)) {
	unzip(file)
}

R Code to perform analysis:

# Step 1
	# We will merge the training and test sets to create one data set
	trainVal <- read.table("train/X_train.txt")
	trainAct <- read.table("train/y_train.txt")
	trainSub <- read.table("train/subject_train.txt")
	
	testVal <- read.table("test/X_test.txt")
	testAct <- read.table("test/y_test.txt")
	testSub <- read.table("test/subject_test.txt")
	
	# combine training and test values
	dataVal <- rbind(trainVal, testVal)
	
	# combine training and test activities
	dataAct <- rbind(trainAct, testAct)
	
	# creation of 'subject' data set
	dataSub <- rbind(trainSub, testSub)
	
	# Step 2
	# We will extract only the measurements on the mean and StDev for each measurement
	
	features <- read.table("features.txt")
	
	# get only columns with mean() or StDev() in their names
	featuresMStdev <- grep("-(mean|std)\\(\\)", features[, 2])
	
	# subset the desired columns
	dataVal <- dataVal[, featuresMStdev]
	
	# correct the column names
	names(dataVal) <- features[featuresMStdev, 2]
	
	# Step 3
	# Use activity names to name the activities in the data set
	
	activities <- read.table("activity_labels.txt")
	
	# update values with correct activity names
	dataAct[, 1] <- activities[dataAct[, 1], 2]
	
	# correct column name
	names(dataAct) <- "activity"
	
	# Step 4
	# label the data set with variable names
	
	# Rename column name
	names(dataSub) <- "subject"
	
	# Combine all the data in one data set
	full_data <- cbind(dataVal, dataAct, dataSub)
	
	# Step 5
	# Finally, we will create an independent tidy data set with the average of each variable using plyr package
	
	mean_data <- ddply(full_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
	
	write.table(mean_data, “tidy.txt”, row.name=FALSE)
