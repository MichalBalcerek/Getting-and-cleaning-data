library(reshape2)

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# finding the rows we want - with "mean" or "std" strings within - Step 2.
meanStd_cols <- grep(".*mean.*|.*std.*", features[,2])
meanStd_cols.names <- features[meanStd_cols,2]

# loading the data we want (subsetting on x_train/x_test here seems faster than doing it later)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[meanStd_cols]
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train, y_train, x_train)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[meanStd_cols]
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test, y_test, x_test)

# merging rows of our data - Step 1.
allData <- rbind(train, test)

# Step 3. Uses descriptive activity names to name the activities in the data set.
# Step 4. Appropriately labels the data set with descriptive variable names. 
colnames(allData) <- c("subject", "activity", meanStd_cols.names)
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# creating the "tidy.txt", as required in the course project
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
